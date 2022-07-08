// ignore_for_file: avoid_init_to_null

import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/pdf/gerador_pdf.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/utils/formar_texto_compartilhar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_detalhada.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
            const Text(
              "Para compartilhar as estimativas realize as contagens: Indicativa, Estimada e Detalhada. \n\n\nApós a contagem estime: Esforço, Prazo, Equipe e Custo com a contagem DETALHADA para gerar o PDF e o texto para compartilhar",
              style: TextStyle(fontSize: tamanhoSubtitulo),
            ),

            Observer(builder: (context) {
              return storeContagemDetalhada.contagemDetalhadaValida.totalPf >
                          0 &&
                      podeCompartilhar(
                              context,
                              storeEstimativaEsforco,
                              storeEstimativaEquipe,
                              storeEstimativaPrazo,
                              storeEstimativaCusto) ==
                          true
                  ? SizedBox(
                      height: 200,
                      child: Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.teal.withOpacity(0.4),
                                radius: 40,
                                child: const Icon(Icons.check_circle_sharp,
                                    color: Colors.teal, size: 80),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Estimativas prontas para compartilhar",
                                style: TextStyle(color: corCorpoTexto),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      child: Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red.withOpacity(0.4),
                                radius: 40,
                                child: const Icon(Icons.cancel,
                                    color: Colors.red, size: 80),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Finalize as estimativas para compartilhar",
                                style: TextStyle(color: corCorpoTexto),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            })

            // const Text(
            //   "Contagens",
            //   style: TextStyle(
            //       color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            // ),
            // Observer(builder: (context) {
            //   if (storeContagemIndicativa.contagemIndicativaValida.totalPf ==
            //           0 &&
            //       storeContagemEstimada.contagemEstimadaValida.totalPF == 0) {
            //     return const SizedBox(
            //       child: Text(
            //         "Não Realizado",
            //         style: TextStyle(color: corCorpoTexto),
            //       ),
            //     );
            //   }

            //   return const SizedBox();
            // }),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         Observer(builder: (context) {
            //           return storeContagemIndicativa
            //                       .contagemIndicativaValida.totalPf >
            //                   0
            //               ? CardIndicativaResultado(
            //                   storeIndex: store,
            //                   contagemIndicativaEntitie: storeContagemIndicativa
            //                       .contagemIndicativaValida,
            //                   projetoEntitie: projeto,
            //                 )
            //               : const SizedBox();
            //         }),
            //         Observer(builder: (context) {
            //           return storeContagemEstimada
            //                       .contagemEstimadaValida.totalPF >
            //                   0
            //               ? CardEstimadaResultado(
            //                   storeIndex: store,
            //                   contagemEstimadaEntitie:
            //                       storeContagemEstimada.contagemEstimadaValida,
            //                   projetoEntitie: projeto,
            //                 )
            //               : const SizedBox();
            //         }),
            //         Observer(builder: (context) {
            //           return storeContagemDetalhada
            //                       .contagemDetalhadaValida.totalPf >
            //                   0
            //               ? CardDetalhadaResultado(
            //                   storeIndex: store,
            //                   contagemDetalhadaEntitie: storeContagemDetalhada
            //                       .contagemDetalhadaValida,
            //                   projetoEntitie: projeto,
            //                 )
            //               : const SizedBox();
            //         }),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Text(
            //   "Esforços",
            //   style: TextStyle(
            //       color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            // ),
            // Row(
            //   children: [
            //     Observer(builder: (context) {
            //       return storeEstimativaEsforco.esforcosValidos.isNotEmpty
            //           ? Container(
            //               padding: const EdgeInsets.all(10),
            //               height: 120,
            //               width: TamanhoTela.width(context, 0.9),
            //               child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   shrinkWrap: true,
            //                   itemCount:
            //                       storeEstimativaEsforco.esforcosValidos.length,
            //                   itemBuilder: (context, index) {
            //                     EsforcoEntity equipeEntity =
            //                         storeEstimativaEsforco
            //                             .esforcosValidos[index];
            //                     return CardEsforcoResultado(
            //                         storeIndex: store,
            //                         projetoEntitie: projeto,
            //                         esforcoEntity: equipeEntity);
            //                   }),
            //             )
            //           : const SizedBox(
            //               child: Center(
            //                   child: Text(
            //                 "Não Realizado",
            //                 style: TextStyle(color: corCorpoTexto),
            //               )),
            //             );
            //     }),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Text("Prazos",
            //     style: TextStyle(
            //         color: corCorpoTexto,
            //         fontWeight: Fontes.weightTextoNormal)),
            // Row(
            //   children: [
            //     Observer(builder: (context) {
            //       return storeEstimativaPrazo.prazosValidos.isNotEmpty
            //           ? Container(
            //               padding: const EdgeInsets.all(10),
            //               height: 120,
            //               width: TamanhoTela.width(context, 0.9),
            //               child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   shrinkWrap: true,
            //                   itemCount:
            //                       storeEstimativaPrazo.prazosValidos.length,
            //                   itemBuilder: (context, index) {
            //                     PrazoEntity prazoEntity =
            //                         storeEstimativaPrazo.prazosValidos[index];
            //                     return CardResultadoPrazoCompartilhar(
            //                         storeIndex: store,
            //                         projetoEntitie: projeto,
            //                         prazoEntity: prazoEntity);
            //                   }),
            //             )
            //           : const SizedBox(
            //               child: Text(
            //                 "Não Realizado",
            //                 style: TextStyle(color: corCorpoTexto),
            //               ),
            //             );
            //     }),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Text(
            //   "Equipes",
            //   style: TextStyle(
            //       color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            // ),
            // Row(
            //   children: [
            //     Observer(builder: (context) {
            //       return storeEstimativaEquipe.equipesValidas.isNotEmpty
            //           ? Container(
            //               padding: const EdgeInsets.all(10),
            //               height: 120,
            //               width: TamanhoTela.width(context, 0.9),
            //               child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   shrinkWrap: true,
            //                   itemCount:
            //                       storeEstimativaEquipe.equipesValidas.length,
            //                   itemBuilder: (context, index) {
            //                     EquipeEntity equipeEntity =
            //                         storeEstimativaEquipe.equipesValidas[index];
            //                     return CardEquipeResultadoCompartilhar(
            //                         storeIndex: store,
            //                         projetoEntitie: projeto,
            //                         equipeEntity: equipeEntity);
            //                   }),
            //             )
            //           : const SizedBox(
            //               child: Center(
            //                   child: Text(
            //                 "Não Realizado",
            //                 style: TextStyle(color: corCorpoTexto),
            //               )),
            //             );
            //     }),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Text(
            //   "Custos",
            //   style: TextStyle(
            //       color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            // ),
            // Row(
            //   children: [
            //     Observer(builder: (context) {
            //       return storeEstimativaCusto.custosValidos.isNotEmpty
            //           ? Container(
            //               padding: const EdgeInsets.all(10),
            //               height: 120,
            //               width: TamanhoTela.width(context, 0.9),
            //               child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   shrinkWrap: true,
            //                   itemCount:
            //                       storeEstimativaCusto.custosValidos.length,
            //                   itemBuilder: (context, index) {
            //                     CustoEntity custoEntity =
            //                         storeEstimativaCusto.custosValidos[index];
            //                     return CardResultadoCustoCompartilhar(
            //                         storeIndex: store,
            //                         projetoEntitie: projeto,
            //                         custoEntity: custoEntity);
            //                   }),
            //             )
            //           : const SizedBox(
            //               child: Center(
            //                   child: Text(
            //                 "Não Realizado",
            //                 style: TextStyle(color: corCorpoTexto),
            //               )),
            //             );
            //     }),
            //   ],
            // ),
            // BotaoPadrao(
            //     corDeTextoBotao: corTextoSobCorPrimaria,
            //     acao: () {
            //       if (validarContagens(
            //         context,
            //         storeEstimativaEsforco,
            //         storeEstimativaEquipe,
            //         storeEstimativaPrazo,
            //         storeEstimativaCusto,
            //       )) {
            //         Share.share(FormarTextoCompartilhar.compartilharTexto(
            //             projeto,
            //             storeEstimativaEsforco,
            //             storeEstimativaEquipe,
            //             storeEstimativaPrazo,
            //             storeEstimativaCusto,
            //             storeContagemIndicativa,
            //             storeContagemEstimada,
            //             storeContagemDetalhada));
            //       }
            //     },
            //     tituloBotao: "     Enviar Estimativas",
            //     corBotao: corDeFundoBotaoPrimaria,
            //     carregando: false),
            // BotaoPadrao(
            //     tituloBotao: "Gerar PDF",
            //     corBotao: corDeFundoBotaoSecundaria,
            //     carregando: false,
            //     icone: const Icon(Icons.file_download_outlined),
            //     acao: () async {
            //       if (validarContagens(
            //           context,
            //           storeEstimativaEsforco,
            //           storeEstimativaEquipe,
            //           storeEstimativaPrazo,
            //           storeEstimativaCusto)) {
            //         if (storeContagemDetalhada.totalPf > 0) {
            //           GeradorPdf pdf = GeradorPdf(
            //             storeContagemDetalhada,
            //             storeContagemEstimada,
            //             storeContagemIndicativa,
            //             storeEstimativaEsforco,
            //             storeEstimativaPrazo,
            //             storeEstimativaEquipe,
            //             storeEstimativaCusto,
            //           );

            //           pdf.gerarDocument(projeto);
            //         } else {
            //           AlertaSnack.exbirSnackBar(context,
            //               "Finalize sua contagem detalhada para compartilhar PDF");
            //         }
            //       }
            //     }),
          ],
        ),
      ),
    );
  }
}

podeCompartilhar(context, storeEstimativaEsforco, storeEstimativaEquipe,
    storeEstimativaPrazo, storeEstimativaCusto) {
  var esforcoDetalhada = null;
  var equipeDetalhada = null;
  var prazoDetalhado = null;
  var custoDetalhado = null;
  for (var element in storeEstimativaEsforco.esforcosValidos) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      esforcoDetalhada = element;
    }
  }

  for (var element in storeEstimativaEquipe.equipesValidas) {
    if (element.esforco.contains("Detalhada")) {
      equipeDetalhada = element;
    }
  }

  for (var element in storeEstimativaPrazo.prazosValidos) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      prazoDetalhado = element;
    }
  }

  for (var element in storeEstimativaCusto.custosValidos) {
    if (element.tipoContagem.contains("Detalhada")) {
      custoDetalhado = element;
    }
  }

  if (esforcoDetalhada == null ||
      prazoDetalhado == null ||
      equipeDetalhada == null ||
      custoDetalhado == null) {
    return false;
  } else if (esforcoDetalhada != null &&
      equipeDetalhada != null &&
      prazoDetalhado != null &&
      custoDetalhado != null) {
    return true;
  }
}

validarContagens(context, storeEstimativaEsforco, storeEstimativaEquipe,
    storeEstimativaPrazo, storeEstimativaCusto) {
  var esforcoDetalhada = null;
  var equipeDetalhada = null;
  var prazoDetalhado = null;
  var custoDetalhado = null;
  for (var element in storeEstimativaEsforco.esforcosValidos) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      esforcoDetalhada = element;
    }
  }

  for (var element in storeEstimativaEquipe.equipesValidas) {
    if (element.esforco.contains("Detalhada")) {
      equipeDetalhada = element;
    }
  }

  for (var element in storeEstimativaPrazo.prazosValidos) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      prazoDetalhado = element;
    }
  }

  for (var element in storeEstimativaCusto.custosValidos) {
    if (element.tipoContagem.contains("Detalhada")) {
      custoDetalhado = element;
    }
  }

  if (esforcoDetalhada == null) {
    AlertaSnack.exbirSnackBar(context,
        "Realize a estimativa de esforço com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (prazoDetalhado == null) {
    AlertaSnack.exbirSnackBar(context,
        "Realize a estimativa de prazo com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (equipeDetalhada == null) {
    AlertaSnack.exbirSnackBar(context,
        "Realize a estimativa de equipe com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (custoDetalhado == null) {
    AlertaSnack.exbirSnackBar(context,
        "Realize a estimativa de custo com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (esforcoDetalhada != null &&
      equipeDetalhada != null &&
      prazoDetalhado != null &&
      custoDetalhado != null) {
    return true;
  } else {
    AlertaSnack.exbirSnackBar(
        context, "Finalize suas estimativas  para compartihar o PDF");
    return false;
  }
}
