import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/linha_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/componente_estimativa_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExibicaoCardEsforco extends StatelessWidget {
  final ScrollController scrollController;
  final List<ResultadoEntity> resultados;
  final List<EsforcoEntity> esforcos;
  const ExibicaoCardEsforco(
      {Key? key,
      required this.esforcos,
      required this.resultados,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: esforcos.length,
      itemBuilder: ((context, index) {
        EsforcoEntity esforco = esforcos[index];
        if (resultados[index].uidMembro == esforco.uidUsuario) {
          return ComponenteEstimativasPadrao(
            resultadoEntity: resultados[index],
            corpoEstimativas: [
              LinhaEstimativas(
                  nome: "Tipo Contagem",
                  resultado: esforco.contagemPontoDeFuncao.split(" - ").first),
              LinhaEstimativas(nome: "Linguagem", resultado: esforco.linguagem),
              LinhaEstimativas(
                  nome: "Produtividade Equipe",
                  resultado: esforco.produtividadeEquipe),
              LinhaEstimativas(
                  nome: "Esforco Total",
                  resultado: "${esforco.esforcoTotal} Horas"),
            ],
            membro: Modular.get<ProjetoController>()
                .membrosProjetoAtual
                .singleWhere((element) {
              return element.uid == esforco.uidUsuario;
            }),
          );
        }
        return const SizedBox();
      }),
    );
  }
}