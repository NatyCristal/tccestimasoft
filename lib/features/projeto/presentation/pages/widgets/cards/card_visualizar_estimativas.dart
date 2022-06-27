import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/linha_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/componente_estimativa_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardVisualizarEstimativas extends StatelessWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final List<ResultadoEntity> resultadosEstimativas;
  final String tipoDeEstimativa;
  final String uidProjeto;
  final List<CustoEntity> custos;
  final List<EquipeEntity> equipe;
  final List<PrazoEntity> prazos;
  final List<EsforcoEntity> esforcos;
  final List<ContagemIndicativa> indivativas;
  final List<ContagemEstimada> estimadas;
  CardVisualizarEstimativas(
      {Key? key,
      required this.tipoDeEstimativa,
      required this.resultadosEstimativas,
      required this.uidProjeto,
      required this.custos,
      required this.equipe,
      required this.prazos,
      required this.esforcos,
      required this.indivativas,
      required this.estimadas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: paddingPagePrincipal,
        child: Column(
          children: [
            if (custos.isNotEmpty)
              ListView.builder(
                itemCount: custos.length,
                itemBuilder: ((context, index) {
                  CustoEntity custo = custos[index];
                  if (resultadosEstimativas[index].uidMembro ==
                      custo.uidUsuario) {
                    return ComponenteEstimativasPadrao(
                      resultadoEntity: resultadosEstimativas[index],
                      corpoEstimativas: [
                        LinhaEstimativas(
                          nome: "Tipo Contagem",
                          resultado: custo.tipoContagem,
                        ),
                      ],
                      membro:
                          controller.membrosProjetoAtual.singleWhere((element) {
                        return element.uid == custo.uidUsuario;
                      }),
                    );
                  }
                  return const SizedBox();
                }),
              ),
          ],
        ));
  }
}
