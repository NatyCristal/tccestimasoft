import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/utils/formar_texto_compartilhar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_plus/share_plus.dart';

class IndexResultado extends StatelessWidget {
  final StoreContagemIndicativa storeContagemIndicativa;
  final StoreContagemEstimada storeContagemEstimada;
  final StoreContagemDetalhada storeContagemDetalhada;
  final StoreEstimativaEsforco storeEstimativaEsforco;
  final StoreEstimativaPrazo storeEstimativaPrazo;
  final StoreEstimativaEquipe storeEstimativaEquipe;
  final StoreEstimativaCusto storeEstimativaCusto;
  final StoreProjetosIndexMenu store;
  final ProjetoEntitie projeto;
  const IndexResultado(
      {Key? key,
      required this.storeContagemIndicativa,
      required this.storeContagemEstimada,
      required this.storeContagemDetalhada,
      required this.storeEstimativaEsforco,
      required this.storeEstimativaPrazo,
      required this.storeEstimativaEquipe,
      required this.storeEstimativaCusto,
      required this.store,
      required this.projeto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Contagens",
                    style: TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (storeContagemEstimada.contagemEstimadaValida.totalPF >
                          0) {
                        Share.share(
                            FormarTextoCompartilhar.funcaoTextoIndicativa(
                                    storeContagemIndicativa
                                        .contagemIndicativaValida) +
                                FormarTextoCompartilhar.funcaoEstimada(
                                    storeContagemEstimada
                                        .contagemEstimadaValida,
                                    storeContagemIndicativa
                                        .contagemIndicativaValida));
                      } else if (storeContagemIndicativa
                              .contagemIndicativaValida.totalPf >
                          0) {
                        Share.share(
                            FormarTextoCompartilhar.funcaoTextoIndicativa(
                                storeContagemIndicativa
                                    .contagemIndicativaValida));
                      }
                    },
                    child: const Icon(
                      Icons.share,
                      color: corCorpoTexto,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            Observer(builder: (context) {
              if (storeContagemIndicativa.contagemIndicativaValida.totalPf ==
                      0 &&
                  storeContagemEstimada.contagemEstimadaValida.totalPF == 0) {
                return const SizedBox(
                  child: Text(
                    "Não Realizado",
                    style: TextStyle(color: corCorpoTexto),
                  ),
                );
              }

              return const SizedBox();
            }),
            Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Observer(builder: (context) {
                      return storeContagemIndicativa
                                  .contagemIndicativaValida.totalPf >
                              0
                          ? CardIndicativaResultado(
                              storeIndex: store,
                              contagemIndicativaEntitie: storeContagemIndicativa
                                  .contagemIndicativaValida,
                              projetoEntitie: projeto,
                            )
                          : const SizedBox();
                    }),
                    Observer(builder: (context) {
                      return storeContagemEstimada
                                  .contagemEstimadaValida.totalPF >
                              0
                          ? CardEstimadaResultado(
                              storeIndex: store,
                              contagemEstimadaEntitie:
                                  storeContagemEstimada.contagemEstimadaValida,
                              projetoEntitie: projeto,
                            )
                          : const SizedBox();
                    }),
                    Observer(builder: (context) {
                      return storeContagemEstimada
                                  .contagemEstimadaValida.totalPF >
                              0
                          ? CardEstimadaResultado(
                              storeIndex: store,
                              contagemEstimadaEntitie:
                                  storeContagemEstimada.contagemEstimadaValida,
                              projetoEntitie: projeto,
                            )
                          : const SizedBox();
                    }),
                    //TODO Card Estimativa Detalhada
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Esforços",
                  style: TextStyle(
                      color: corCorpoTexto,
                      fontWeight: Fontes.weightTextoNormal),
                ),
                GestureDetector(
                  onTap: () {
                    if (storeEstimativaEsforco.esforcosValidos.isNotEmpty) {
                      Share.share(FormarTextoCompartilhar.funcaoTextoEsforco(
                          storeEstimativaEsforco.esforcosValidos));
                    }
                  },
                  child: const Icon(
                    Icons.share,
                    color: corCorpoTexto,
                    size: 20,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Observer(builder: (context) {
                  return storeEstimativaEsforco.esforcosValidos.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          height: 120,
                          width: TamanhoTela.width(context, 0.9),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount:
                                  storeEstimativaEsforco.esforcosValidos.length,
                              itemBuilder: (context, index) {
                                EsforcoEntity equipeEntity =
                                    storeEstimativaEsforco
                                        .esforcosValidos[index];
                                return CardEsforcoResultado(
                                    storeIndex: store,
                                    projetoEntitie: projeto,
                                    esforcoEntity: equipeEntity);
                              }),
                        )
                      : const SizedBox(
                          child: Center(
                              child: Text(
                            "Não Realizado",
                            style: TextStyle(color: corCorpoTexto),
                          )),
                        );
                }),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Prazos",
                    style: TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal)),
                GestureDetector(
                  onTap: () {
                    if (storeEstimativaPrazo.prazosValidos.isNotEmpty) {
                      Share.share(FormarTextoCompartilhar.funcaoTextoPrazo(
                          storeEstimativaPrazo.prazosValidos));
                    }
                  },
                  child: const Icon(
                    Icons.share,
                    color: corCorpoTexto,
                    size: 20,
                  ),
                )
              ],
            ),
            Observer(builder: (context) {
              return storeEstimativaPrazo.prazosValidos.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      height: 120,
                      width: TamanhoTela.width(context, 0.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount:
                                  storeEstimativaPrazo.prazosValidos.length,
                              itemBuilder: (context, index) {
                                PrazoEntity prazoEntity =
                                    storeEstimativaPrazo.prazosValidos[index];
                                return CardResultadoPrazoCompartilhar(
                                    storeIndex: store,
                                    projetoEntitie: projeto,
                                    prazoEntity: prazoEntity);
                              }),
                        ],
                      ),
                    )
                  : const SizedBox(
                      child: Text(
                        "Não Realizado",
                        style: TextStyle(color: corCorpoTexto),
                      ),
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Equipes",
                  style: TextStyle(
                      color: corCorpoTexto,
                      fontWeight: Fontes.weightTextoNormal),
                ),
                GestureDetector(
                  onTap: () {
                    if (storeEstimativaEquipe.equipesValidas.isNotEmpty) {
                      Share.share(FormarTextoCompartilhar.funcaoTextoEquipes(
                          storeEstimativaEquipe.equipesValidas));
                    }
                  },
                  child: const Icon(
                    Icons.share,
                    color: corCorpoTexto,
                    size: 20,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Observer(builder: (context) {
                  return storeEstimativaEquipe.equipesValidas.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          height: 120,
                          width: TamanhoTela.width(context, 0.9),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount:
                                  storeEstimativaEquipe.equipesValidas.length,
                              itemBuilder: (context, index) {
                                EquipeEntity equipeEntity =
                                    storeEstimativaEquipe.equipesValidas[index];
                                return CardEquipeResultadoCompartilhar(
                                    storeIndex: store,
                                    projetoEntitie: projeto,
                                    equipeEntity: equipeEntity);
                              }),
                        )
                      : const SizedBox(
                          child: Center(
                              child: Text(
                            "Não Realizado",
                            style: TextStyle(color: corCorpoTexto),
                          )),
                        );
                }),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Custos",
                  style: TextStyle(
                      color: corCorpoTexto,
                      fontWeight: Fontes.weightTextoNormal),
                ),
                GestureDetector(
                  onTap: () {
                    if (storeEstimativaCusto.custosValidos.isNotEmpty) {
                      Share.share(FormarTextoCompartilhar.funcaoTextoCustos(
                          storeEstimativaCusto.custosValidos));
                    }
                  },
                  child: const Icon(
                    Icons.share,
                    color: corCorpoTexto,
                    size: 20,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Observer(builder: (context) {
                  return storeEstimativaCusto.custosValidos.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          height: 120,
                          width: TamanhoTela.width(context, 0.9),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount:
                                  storeEstimativaCusto.custosValidos.length,
                              itemBuilder: (context, index) {
                                CustoEntity custoEntity =
                                    storeEstimativaCusto.custosValidos[index];
                                return CardResultadoCustoCompartilhar(
                                    storeIndex: store,
                                    projetoEntitie: projeto,
                                    custoEntity: custoEntity);
                              }),
                        )
                      : const SizedBox(
                          child: Center(
                              child: Text(
                            "Não Realizado",
                            style: TextStyle(color: corCorpoTexto),
                          )),
                        );
                }),
              ],
            ),
            BotaoPadrao(
                corDeTextoBotao: corTextoSobCorPrimaria,
                acao: () {
                  //   String texto = verificaEstimativas()

                  Share.share(FormarTextoCompartilhar.funcaoTextoIndicativa(
                          storeContagemIndicativa.contagemIndicativaValida) +
                      FormarTextoCompartilhar.funcaoEstimada(
                          storeContagemEstimada.contagemEstimadaValida,
                          storeContagemIndicativa.contagemIndicativaValida) +
                      FormarTextoCompartilhar.funcaoTextoEsforco(
                          storeEstimativaEsforco.esforcosValidos) +
                      FormarTextoCompartilhar.funcaoTextoPrazo(
                          storeEstimativaPrazo.prazosValidos) +
                      FormarTextoCompartilhar.funcaoTextoEquipes(
                          storeEstimativaEquipe.equipesValidas) +
                      FormarTextoCompartilhar.funcaoTextoCustos(
                          storeEstimativaCusto.custosValidos));
                },
                tituloBotao: "     Enviar Estimativas",
                corBotao: corDeFundoBotaoPrimaria,
                carregando: false),
          ],
        ),
      ),
    );
  }
}