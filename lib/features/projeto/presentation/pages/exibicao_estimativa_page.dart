import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class VisualizarEstimativas extends StatelessWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ProjetoEntitie projeto;

  VisualizarEstimativas({Key? key, required this.projeto}) : super(key: key);
  _getData() async {
    return Modular.get<ProjetoController>()
        .resultadoController
        .recuperarResultados(projeto.uidProjeto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Detalhes da Estimativa",
          style: TextStyle(fontSize: 14, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: Container(
        padding: paddingPagePrincipal,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return const Text("Erro");
                      }
                      if (snapshot.hasData) {
                        List<ResultadoEntity> resultados = snapshot.data;

                        if (resultados.isEmpty) {
                          return const Center(
                              child: Text(
                            "Não tem nenhuma estimativa compartilhada",
                            style: TextStyle(
                                fontSize: tamanhoSubtitulo,
                                color: corCorpoTexto,
                                fontWeight: Fontes.weightTextoNormal),
                          ));
                        } else {
                          return ListView.builder(
                            itemCount: resultados.length,
                            itemBuilder: (context, index) {
                              ResultadoEntity resultadoEntity = controller
                                  .resultadoController
                                  .resultadosCompartilhados[index];

                              return Column(
                                children: [
                                  Text(resultadoEntity.valor),
                                  Divider(
                                    color: corDeAcao.withOpacity(0.7),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            },
                          );
                        }
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
            ),
          ],
        ),
      ),
    );
  }
}
