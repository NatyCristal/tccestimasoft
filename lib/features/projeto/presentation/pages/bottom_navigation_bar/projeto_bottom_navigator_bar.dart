import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
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
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../tab_bar/contagem/contagem_estimada.dart';
import '../tab_bar/contagem/contagem_indicativa.dart';
import '../tab_bar/home/index_home.dart';

class ProjetoMenuPage extends StatelessWidget {
  final ProjetoEntitie projeto;
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
  ProjetoMenuPage({Key? key, required this.projeto}) : super(key: key);

  _itemSelecionado(int index) {
    store.index = index;
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
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Id de compartilhamento:",
                              style: const AlertStyle(
                                titleStyle: TextStyle(
                                    color: corTituloTexto, fontSize: 20),
                              ),
                              content: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    projeto.uidProjeto,
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
                                    "OK",
                                    style: TextStyle(
                                        fontWeight: Fontes.weightTextoNormal,
                                        color: corDeTextoBotaoSecundaria,
                                        fontSize: 14),
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  width: 120,
                                ),
                              ],
                            ).show();
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
                        projeto.nomeProjeto,
                        style: const TextStyle(
                            fontSize: tamanhoSubtitulo, color: corTituloTexto),
                      ),
                      bottom: TabBar(
                        indicatorWeight: 2,
                        overlayColor: MaterialStateProperty.all(background),
                        indicatorColor: corDeFundoBotaoSecundaria,
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
                    body: TabBarView(children: [
                      ContagemIndicativa(
                          store: storeIndicativa,
                          projetoUid: projeto.uidProjeto),
                      ContagemEstimada(
                        storeIndicativa: storeIndicativa,
                        store: storeEstimada,
                        projetoUid: projeto.uidProjeto,
                      ),
                      ContagemDetalhada(
                          projetoUid: projeto.uidProjeto,
                          store: storeEstimada,
                          storeIndicativa: storeIndicativa),
                    ]),
                    bottomNavigationBar: Observer(builder: (context) {
                      return BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        currentIndex: store.index,
                        selectedItemColor: corDeAcao,
                        onTap: _itemSelecionado,
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
                  child: DefaultTabController(
                    length: 4,
                    child: Scaffold(
                        appBar: AppBar(
                          actions: [
                            GestureDetector(
                              onTap: () {
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "Id de compartilhamento:",
                                  style: const AlertStyle(
                                    titleStyle: TextStyle(
                                        color: corTituloTexto, fontSize: 20),
                                  ),
                                  content: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        projeto.uidProjeto,
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
                                        "OK",
                                        style: TextStyle(
                                            fontWeight:
                                                Fontes.weightTextoNormal,
                                            color: corDeTextoBotaoSecundaria,
                                            fontSize: 14),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      width: 120,
                                    ),
                                  ],
                                ).show();
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
                            projeto.nomeProjeto,
                            style: const TextStyle(
                                fontSize: tamanhoSubtitulo,
                                color: corTituloTexto),
                          ),
                          bottom: TabBar(
                            indicatorWeight: 2,
                            overlayColor: MaterialStateProperty.all(background),
                            indicatorColor: corDeFundoBotaoSecundaria,
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
                            projetoEntitie: projeto,
                            storeEstimativaEsforco: storeEstimativaEsforco,
                            storeIndicativa: storeIndicativa,
                            storeContagemDetalhada: storeDetalhada,
                            storeContagemEstimada: storeEstimada,
                          ),
                          EstimativaPrazo(
                            projetoEntitie: projeto,
                            store: storeEstimativaPrazo,
                            storeIndicativa: storeIndicativa,
                            storeContagemDetalhada: storeDetalhada,
                            storeEstimada: storeEstimada,
                          ),
                          EstimativaEquipePage(
                            storeEstimativaEquipe: storeEstimativaEquipe,
                            storeEstimativaEsforco: storeEstimativaEsforco,
                            storeEstimativaPrazo: storeEstimativaPrazo,
                          ),
                          EstimativaCustoPage(
                            storeEstimativaEquipe: storeEstimativaEquipe,
                            storeEstimativaCusto: storeEstimativaCusto,
                          )
                        ]),
                        bottomNavigationBar: Observer(builder: (context) {
                          return BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            currentIndex: store.index,
                            selectedItemColor: corDeAcao,
                            onTap: _itemSelecionado,
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
              : Scaffold(
                  appBar: AppBar(
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "Id de compartilhamento:",
                            style: const AlertStyle(
                              titleStyle: TextStyle(
                                  color: corTituloTexto, fontSize: 20),
                            ),
                            content: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  projeto.uidProjeto,
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
                                  "OK",
                                  style: TextStyle(
                                      fontWeight: Fontes.weightTextoNormal,
                                      color: corDeTextoBotaoSecundaria,
                                      fontSize: 14),
                                ),
                                onPressed: () async {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                width: 120,
                              ),
                            ],
                          ).show();
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
                      projeto.nomeProjeto,
                      style: const TextStyle(
                          fontSize: tamanhoSubtitulo, color: corTituloTexto),
                    ),
                    shape: const Border(
                      bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
                    ),
                  ),
                  body: Observer(builder: (context) {
                    return Center(
                      child: listaBottomNavigator(projeto, store),
                    );
                  }),
                  bottomNavigationBar: Observer(builder: (context) {
                    return BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      currentIndex: store.index,
                      selectedItemColor: corDeAcao,
                      onTap: _itemSelecionado,
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
                );
    });
  }
}
