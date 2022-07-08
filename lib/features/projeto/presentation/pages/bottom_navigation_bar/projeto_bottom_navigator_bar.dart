// ignore_for_file: avoid_init_to_null

import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/index_resultado.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/pdf/gerador_pdf.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/utils/formar_texto_compartilhar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/custo_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/esforco_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/equipe_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/prazo_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share_plus/share_plus.dart';
import '../tab_bar/contagem/contagem_estimada.dart';
import '../tab_bar/contagem/contagem_indicativa.dart';
import 'home/index_home.dart';

class ProjetoMenuPage extends StatefulWidget {
  final ProjetoEntitie projeto;

  const ProjetoMenuPage({Key? key, required this.projeto}) : super(key: key);

  @override
  State<ProjetoMenuPage> createState() => _ProjetoMenuPageState();
}

class _ProjetoMenuPageState extends State<ProjetoMenuPage>
    with TickerProviderStateMixin {
  //stores contagem
  final StoreProjetosIndexMenu store = StoreProjetosIndexMenu();

  final StoreContagemIndicativa storeIndicativa = StoreContagemIndicativa();

  final StoreContagemEstimada storeEstimada = StoreContagemEstimada();

  final StoreContagemDetalhada storeDetalhada = StoreContagemDetalhada();

  //stores Estimativas
  final StoreEstimativaPrazo storeEstimativaPrazo = StoreEstimativaPrazo();

  final StoreEstimativaEsforco storeEstimativaEsforco =
      StoreEstimativaEsforco();

  final StoreEstimativaEquipe storeEstimativaEquipe = StoreEstimativaEquipe();

  final StoreEstimativaCusto storeEstimativaCusto = StoreEstimativaCusto();

  late TabController tabContagem;
  late TabController tabEstimativas;
  int valorTabEstimativas = 0;

  @override
  void initState() {
    tabContagem = TabController(length: 3, vsync: this, initialIndex: 0);
    tabEstimativas = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  itemSelecionado(int index) {
    store.index = index;
    valorTabEstimativas = 0;
    tabEstimativas.index = 0;
  }

  listaBottomNavigator(ProjetoEntitie projeto, StoreProjetosIndexMenu store) {
    switch (store.index) {
      case 0:
        return IndexHome(
          prazo: storeEstimativaPrazo,
          indicativa: storeIndicativa,
          estimada: storeEstimada,
          esforco: storeEstimativaEsforco,
          custo: storeEstimativaCusto,
          detalhada: storeDetalhada,
          equipe: storeEstimativaEquipe,
          store: store,
          projeto: projeto,
        );

      case 1:
        return const Text("Index 1: Estimativas");

      case 2:
        return const Text(
          'Index 2: Perfil',
        );
      case 3:
        return const Text("Resultados possível para compartilhamento");

      default:
        return const Text("Algo de errado aconteceu");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return store.index == 1
          ? Material(
              child: DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar: AppBar(
                      actions: [
                        GestureDetector(
                          onTap: () {
                            alertaCompartilhamentoProjeto(
                                widget.projeto, context);
                          },
                          child: const Icon(
                            Icons.share,
                            color: corTituloTexto,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Text(
                        widget.projeto.nomeProjeto,
                        style: const TextStyle(
                            fontSize: tamanhoSubtitulo, color: corTituloTexto),
                      ),
                      bottom: TabBar(
                        controller: tabContagem,
                        indicatorWeight: 2,
                        overlayColor: MaterialStateProperty.all(background),
                        indicatorColor: corDeAcao,
                        tabs: const [
                          Tab(
                            text: "Indicativa",
                          ),
                          Tab(
                            text: "Estimada",
                          ),
                          Tab(
                            text: "Detalhada",
                          ),
                        ],
                      ),
                    ),
                    body: TabBarView(controller: tabContagem, children: [
                      ContagemIndicativa(
                          store: storeIndicativa,
                          projetoUid: widget.projeto.uidProjeto),
                      ContagemEstimada(
                        storeIndicativa: storeIndicativa,
                        store: storeEstimada,
                        projetoUid: widget.projeto.uidProjeto,
                      ),
                      ContagemDetalhada(
                          storeContagemDetalhada: storeDetalhada,
                          projetoUid: widget.projeto.uidProjeto,
                          storeEstimada: storeEstimada,
                          storeIndicativa: storeIndicativa),
                    ]),
                    bottomNavigationBar: Observer(builder: (context) {
                      return BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        currentIndex: store.index,
                        selectedItemColor: corDeAcao,
                        onTap: itemSelecionado,
                        items: const [
                          BottomNavigationBarItem(
                            label: "Home",
                            icon: Icon(Icons.home),
                          ),
                          BottomNavigationBarItem(
                              label: "Contagem",
                              icon: Icon(Icons.auto_graph_outlined)),
                          BottomNavigationBarItem(
                              label: "Estimativas",
                              icon: Icon(Icons.bar_chart_rounded)),
                          BottomNavigationBarItem(
                              label: "Resultado",
                              icon: Icon(Icons.checklist_rtl_rounded)),
                        ],
                      );
                    })),
              ),
            )
          : store.index == 2
              ? Material(
                  child: Builder(builder: (context) {
                    return DefaultTabController(
                      initialIndex: tabEstimativas.index,
                      length: 4,
                      child: Builder(builder: (context) {
                        return Scaffold(
                            appBar: AppBar(
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    alertaCompartilhamentoProjeto(
                                        widget.projeto, context);
                                  },
                                  child: const Icon(
                                    Icons.share,
                                    color: corTituloTexto,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              title: Text(
                                widget.projeto.nomeProjeto,
                                style: const TextStyle(
                                    fontSize: tamanhoSubtitulo,
                                    color: corTituloTexto),
                              ),
                              bottom: TabBar(
                                isScrollable: false,
                                onTap: (value) {
                                  valorTabEstimativas = value;

                                  setState(() {
                                    DefaultTabController.of(context)?.index =
                                        value;
                                  });
                                },
                                indicatorWeight: 2,
                                overlayColor:
                                    MaterialStateProperty.all(background),
                                indicatorColor: corDeAcao,
                                tabs: const [
                                  Tab(
                                    text: "Esforço",
                                  ),
                                  Tab(
                                    text: "Prazo",
                                  ),
                                  Tab(
                                    text: "Equipe",
                                  ),
                                  Tab(
                                    text: "Custo",
                                  ),
                                ],
                              ),
                            ),
                            body: TabBarView(children: [
                              EstimativaEsforcoPage(
                                projetoEntitie: widget.projeto,
                                storeEstimativaEsforco: storeEstimativaEsforco,
                                storeIndicativa: storeIndicativa,
                                storeContagemDetalhada: storeDetalhada,
                                storeContagemEstimada: storeEstimada,
                              ),
                              EstimativaPrazo(
                                projetoEntitie: widget.projeto,
                                store: storeEstimativaPrazo,
                                storeIndicativa: storeIndicativa,
                                storeContagemDetalhada: storeDetalhada,
                                storeEstimada: storeEstimada,
                              ),
                              EstimativaEquipePage(
                                projetoEntitie: widget.projeto,
                                storeEstimativaEquipe: storeEstimativaEquipe,
                                storeEstimativaEsforco: storeEstimativaEsforco,
                                storeEstimativaPrazo: storeEstimativaPrazo,
                              ),
                              EstimativaCustoPage(
                                storeEstimativaPrazo: storeEstimativaPrazo,
                                projetoEntitie: widget.projeto,
                                storeEstimativaEsforco: storeEstimativaEsforco,
                                storeContagemIndicativa: storeIndicativa,
                                storeContagemEstimada: storeEstimada,
                                storeContagemDetalhada: storeDetalhada,
                                storeEstimativaEquipe: storeEstimativaEquipe,
                                storeEstimativaCusto: storeEstimativaCusto,
                              )
                            ]),
                            bottomNavigationBar: Observer(builder: (context) {
                              return BottomNavigationBar(
                                type: BottomNavigationBarType.fixed,
                                currentIndex: store.index,
                                selectedItemColor: corDeAcao,
                                onTap: itemSelecionado,
                                items: const [
                                  BottomNavigationBarItem(
                                    label: "Home",
                                    icon: Icon(Icons.home),
                                  ),
                                  BottomNavigationBarItem(
                                      label: "Contagem",
                                      icon: Icon(Icons.auto_graph_outlined)),
                                  BottomNavigationBarItem(
                                      label: "Estimativas",
                                      icon: Icon(Icons.bar_chart_rounded)),
                                  BottomNavigationBarItem(
                                      label: "Resultado",
                                      icon: Icon(Icons.checklist_rtl_rounded)),
                                ],
                              );
                            }));
                      }),
                    );
                  }),
                )
              : store.index == 0
                  ? Scaffold(
                      appBar: AppBar(
                        actions: [
                          GestureDetector(
                            onTap: () {
                              alertaCompartilhamentoProjeto(
                                  widget.projeto, context);
                            },
                            child: const Icon(
                              Icons.share,
                              color: corTituloTexto,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text(
                          widget.projeto.nomeProjeto,
                          style: const TextStyle(
                              fontSize: tamanhoSubtitulo,
                              color: corTituloTexto),
                        ),
                        shape: const Border(
                          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
                        ),
                      ),
                      body: IndexHome(
                        prazo: storeEstimativaPrazo,
                        indicativa: storeIndicativa,
                        estimada: storeEstimada,
                        esforco: storeEstimativaEsforco,
                        custo: storeEstimativaCusto,
                        detalhada: storeDetalhada,
                        equipe: storeEstimativaEquipe,
                        store: store,
                        projeto: widget.projeto,
                      ),
                      bottomNavigationBar: Observer(builder: (context) {
                        return BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: store.index,
                          selectedItemColor: corDeAcao,
                          onTap: itemSelecionado,
                          items: const [
                            BottomNavigationBarItem(
                              label: "Home",
                              icon: Icon(Icons.home),
                            ),
                            BottomNavigationBarItem(
                                label: "Contagem",
                                icon: Icon(Icons.auto_graph_outlined)),
                            BottomNavigationBarItem(
                                label: "Estimativas",
                                icon: Icon(Icons.bar_chart_rounded)),
                            BottomNavigationBarItem(
                                label: "Resultado",
                                icon: Icon(Icons.checklist_rtl_rounded)),
                          ],
                        );
                      }))
                  : Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text(
                          widget.projeto.nomeProjeto,
                          style: const TextStyle(
                              fontSize: tamanhoSubtitulo,
                              color: corTituloTexto),
                        ),
                        shape: const Border(
                          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
                        ),
                      ),
                      body: IndexResultado(
                          projeto: widget.projeto,
                          store: store,
                          storeContagemDetalhada: storeDetalhada,
                          storeContagemEstimada: storeEstimada,
                          storeContagemIndicativa: storeIndicativa,
                          storeEstimativaCusto: storeEstimativaCusto,
                          storeEstimativaEquipe: storeEstimativaEquipe,
                          storeEstimativaEsforco: storeEstimativaEsforco,
                          storeEstimativaPrazo: storeEstimativaPrazo),
                      bottomNavigationBar: Observer(builder: (context) {
                        return BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: store.index,
                          selectedItemColor: corDeAcao,
                          onTap: itemSelecionado,
                          items: const [
                            BottomNavigationBarItem(
                              label: "Home",
                              icon: Icon(Icons.home),
                            ),
                            BottomNavigationBarItem(
                                label: "Contagem",
                                icon: Icon(Icons.auto_graph_outlined)),
                            BottomNavigationBarItem(
                                label: "Estimativas",
                                icon: Icon(Icons.bar_chart_rounded)),
                            BottomNavigationBarItem(
                                label: "Resultado",
                                icon: Icon(Icons.checklist_rtl_rounded)),
                          ],
                        );
                      }),
                      floatingActionButton: SpeedDial(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        overlayColor: Colors.black,
                        overlayOpacity: 0.4,
                        icon: Icons.share,
                        iconTheme: const IconThemeData(color: Colors.white),
                        backgroundColor: Colors.black,
                        children: [
                          SpeedDialChild(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              label: "Compartilhar com o projeto",
                              child: const Icon(Icons.move_down_rounded),
                              onTap: () {}),
                          SpeedDialChild(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              label: "Compartilhar via texto",
                              child: const Icon(Icons.send),
                              onTap: () {
                                if (storeDetalhada
                                        .contagemDetalhadaValida.totalPf >
                                    0) {
                                  if (validarContagens(
                                    context,
                                    storeEstimativaEsforco,
                                    storeEstimativaEquipe,
                                    storeEstimativaPrazo,
                                    storeEstimativaCusto,
                                  )) {
                                    Share.share(FormarTextoCompartilhar
                                        .compartilharTexto(
                                            widget.projeto,
                                            storeEstimativaEsforco,
                                            storeEstimativaEquipe,
                                            storeEstimativaPrazo,
                                            storeEstimativaCusto,
                                            storeIndicativa,
                                            storeEstimada,
                                            storeDetalhada));
                                  }
                                } else {
                                  AlertaSnack.exbirSnackBar(context,
                                      "Realize a contagem detalhada para compartilhar PDF");
                                }
                              }),
                          SpeedDialChild(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              label: "Gerar PDF",
                              child: const Icon(Icons.picture_as_pdf),
                              onTap: () {
                                if (storeDetalhada.totalPf > 0) {
                                  if (validarContagens(
                                      context,
                                      storeEstimativaEsforco,
                                      storeEstimativaEquipe,
                                      storeEstimativaPrazo,
                                      storeEstimativaCusto)) {
                                    GeradorPdf pdf = GeradorPdf(
                                      storeDetalhada,
                                      storeEstimada,
                                      storeIndicativa,
                                      storeEstimativaEsforco,
                                      storeEstimativaPrazo,
                                      storeEstimativaEquipe,
                                      storeEstimativaCusto,
                                    );

                                    pdf.gerarDocument(widget.projeto);
                                  }
                                } else {
                                  AlertaSnack.exbirSnackBar(context,
                                      "Realize a contagem detalhada para compartilhar PDF");
                                }
                              }),
                        ],
                      ),
                    );
    });
  }
}

alertaCompartilhamentoProjeto(ProjetoEntitie projetoEntitie, context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Id de compartilhamento:",
    style: const AlertStyle(
      titleStyle: TextStyle(color: corTituloTexto, fontSize: 20),
    ),
    content: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          projetoEntitie.uidProjeto,
          style: const TextStyle(
              color: corCorpoTexto,
              fontSize: 18,
              fontWeight: Fontes.weightTextoLeve),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        color: corDeFundoBotaoSecundaria,
        child: const Text(
          "Copiar",
          style: TextStyle(
              fontWeight: Fontes.weightTextoNormal,
              color: corDeTextoBotaoSecundaria,
              fontSize: 14),
        ),
        onPressed: () async {
          ClipboardData data = ClipboardData(text: projetoEntitie.uidProjeto);

          await Clipboard.setData(data).then((value) {
            AlertaSnack.exbirSnackBar(context, "Código copiado");
            Navigator.of(context, rootNavigator: true).pop();
          });
        },
        width: 120,
      ),
    ],
  ).show();
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
        "Finalize a estimativa de esforço com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (prazoDetalhado == null) {
    AlertaSnack.exbirSnackBar(context,
        "Finalize a estimativa de prazo com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (equipeDetalhada == null) {
    AlertaSnack.exbirSnackBar(context,
        "Finalize a estimativa de equipe com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (custoDetalhado == null) {
    AlertaSnack.exbirSnackBar(context,
        "Finalize a estimativa de custo com a contagem detalhada para compartihar o PDF");
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
