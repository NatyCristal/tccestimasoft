import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class VisualizarEstimativas extends StatelessWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ResultadoEntity resultadoEntity;
  final String uidProjeto;
  final String tipoDeEstimativa;

  VisualizarEstimativas(
      {Key? key,
      required this.resultadoEntity,
      required this.uidProjeto,
      required this.tipoDeEstimativa})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Detalhes da Estimativa",
          style: TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: Container(
        padding: paddingPagePrincipal,
        height: TamanhoTela.height(context, 1),
        width: TamanhoTela.width(context, 1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: verificaEstimativa(
                    tipoDeEstimativa, controller, uidProjeto, resultadoEntity),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return const Text("Erro");
                      }
                      if (snapshot.hasData) {
                        ListView.builder(itemBuilder: ((context, index) {
                          return Container(
                            height: 60,
                            padding: paddingPagePrincipal,
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2)),
                          );
                        }));
                      }

                      break;
                    case ConnectionState.active:
                      return const Carregando();
                    case ConnectionState.none:
                      return const Text("Erro");
                    case ConnectionState.waiting:
                      return const Carregando();
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

verificaEstimativa(String estimativa, ProjetoController controller,
    String uidProjeto, ResultadoEntity resultadoEntity) async {
  switch (estimativa) {
    case "Esforco":
      return await controller.estimativasController
          .recuperarEsforcos(uidProjeto, resultadoEntity.uidMembro);
    case "Prazo":
      return await controller.estimativasController
          .recuperarPrazos(uidProjeto, resultadoEntity.uidMembro);
    case "Equipe":
      return await controller.estimativasController
          .recuperarEquipe(uidProjeto, resultadoEntity.uidMembro);
    case "Custo":
      return await controller.estimativasController
          .recuperarCusto(uidProjeto, resultadoEntity.uidMembro);
    default:
  }
}
