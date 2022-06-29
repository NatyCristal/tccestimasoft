import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'bottom_navigation_bar/home/cards_resultados_compartilhados/card_resultado_custo_exibicao.dart';
import 'bottom_navigation_bar/home/cards_resultados_compartilhados/card_resultado_detalhada_exibicao.dart';
import 'bottom_navigation_bar/home/cards_resultados_compartilhados/card_resultado_equipe_exibicao.dart';
import 'bottom_navigation_bar/home/cards_resultados_compartilhados/card_resultado_esforco_exibicao.dart';
import 'bottom_navigation_bar/home/cards_resultados_compartilhados/card_resultado_estimada_exibicao.dart';
import 'bottom_navigation_bar/home/cards_resultados_compartilhados/card_resultado_indicativa_exibicao.dart';
import 'bottom_navigation_bar/home/cards_resultados_compartilhados/card_resultado_prazo_exibicao.dart';

class VisualizarEstimativas extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final List<ResultadoEntity> estimativas;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final String uidProjeto;
  final String tipoDeEstimativa;

  VisualizarEstimativas(
      {Key? key,
      required this.uidProjeto,
      required this.tipoDeEstimativa,
      required this.estimativas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future verificaEstimativa(
      String estimativa,
      ProjetoController controller,
      String uidProjeto,
    ) async {
      switch (estimativa) {
        case "Indicativa":
          return await controller.contagemController
              .recuperarContagensIndicativas(uidProjeto);
        case "Estimada":
          return await controller.contagemController
              .recuperarContagensEstimadas(uidProjeto);
        case "Detalhada":
          return await controller.contagemController
              .recuperarContagensDetalhadas(uidProjeto);
        case "Esforco":
          return await controller.estimativasController
              .recuperarEsforcosCompartilhados(uidProjeto, estimativa);
        case "Prazo":
          return await controller.estimativasController
              .recuperarPrazosCompartilhados(uidProjeto, estimativa);
        case "Equipe":
          return await controller.estimativasController
              .recuperarEquipesCompartilhadas(uidProjeto, estimativa);
        case "Custo":
          return await controller.estimativasController
              .recuperarCustosCompartilhados(uidProjeto, estimativa);

        default:
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Detalhes da Estimativa  - $tipoDeEstimativa",
          style: const TextStyle(fontSize: 14, color: corTituloTexto),
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
                future: verificaEstimativa(
                  tipoDeEstimativa,
                  controller,
                  uidProjeto,
                ),
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return const Text("Erro");
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data is List<EsforcoEntity>) {
                          return ExibicaoCardEsforco(
                              scrollController: scrollController,
                              esforcos: snapshot.data,
                              resultados: estimativas);
                        } else if (snapshot.data is List<PrazoEntity>) {
                          return ExibicaoCardPrazo(
                              scrollController: scrollController,
                              esforcos: snapshot.data,
                              resultados: estimativas);
                        } else if (snapshot.data is List<EquipeEntity>) {
                          return ExibicaoCardEquipes(
                              scrollController: scrollController,
                              equipes: snapshot.data,
                              resultados: estimativas);
                        } else if (snapshot.data is List<CustoEntity>) {
                          return ExibicaoCardCusto(
                              scrollController: scrollController,
                              custos: snapshot.data,
                              resultados: estimativas);
                        } else if (snapshot.data
                            is List<ContagemIndicativaEntitie>) {
                          return ExibicaoCardContagemIndicativa(
                            scrollController: scrollController,
                            resultados: estimativas,
                          );
                        } else if (snapshot.data
                            is List<ContagemDetalhadaEntitie>) {
                          return CardExibicaoResultadoDetalhada(
                            scrollController: scrollController,
                            resultados: estimativas,
                          );
                        } else if (snapshot.data
                            is List<ContagemEstimadaEntitie>) {
                          return ExibicaoCardContagemEstimada(
                            scrollController: scrollController,
                            resultados: estimativas,
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
