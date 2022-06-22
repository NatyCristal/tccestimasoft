import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/card_prazo.dart';
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

  itemSelecionado(int index) {
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
                            alertaCompartilhamentoProjeto(projeto, context);
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
                          storeContagemDetalhada: storeDetalhada,
                          projetoUid: projeto.uidProjeto,
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
                  child: DefaultTabController(
                    length: 4,
                    child: Scaffold(
                        appBar: AppBar(
                          actions: [
                            GestureDetector(
                              onTap: () {
                                alertaCompartilhamentoProjeto(projeto, context);
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
                            projetoEntitie: projeto,
                            storeEstimativaEquipe: storeEstimativaEquipe,
                            storeEstimativaEsforco: storeEstimativaEsforco,
                            storeEstimativaPrazo: storeEstimativaPrazo,
                          ),
                          EstimativaCustoPage(
                            projetoEntitie: projeto,
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
                        })),
                  ),
                )
              : store.index == 0
                  ? Scaffold(
                      appBar: AppBar(
                        actions: [
                          GestureDetector(
                            onTap: () {
                              alertaCompartilhamentoProjeto(projeto, context);
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
                        projeto: projeto,
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
                        actions: [
                          GestureDetector(
                            onTap: () {
                              alertaCompartilhamentoProjeto(projeto, context);
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
                        shape: const Border(
                          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
                        ),
                      ),
                      body: Container(
                        padding: paddingPagePrincipal,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Contagens prontas para compartilhar'),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Observer(builder: (context) {
                                    return storeIndicativa
                                                .contagemIndicativaValida
                                                .totalPf >
                                            0
                                        ? const CardIndicativaResultado()
                                        : const SizedBox();
                                  }),
                                  Observer(builder: (context) {
                                    return storeEstimada.contagemEstimadaValida
                                                .totalPF >
                                            0
                                        ? const CardEstimadaResultado()
                                        : const SizedBox();
                                  }),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Esforços para compartilhamento"),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Observer(builder: (context) {
                                    return storeEstimativaEsforco
                                            .esforcosValidos.isNotEmpty
                                        ? SizedBox(
                                            height: 120,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount:
                                                    storeEstimativaEsforco
                                                        .esforcosValidos.length,
                                                itemBuilder: (context, index) {
                                                  EsforcoEntity esforcoEntity =
                                                      storeEstimativaEsforco
                                                              .esforcosValidos[
                                                          index];
                                                  return CardEsforcoResultado(
                                                      projetoEntitie: projeto,
                                                      esforcoEntity:
                                                          esforcoEntity);
                                                }),
                                          )
                                        : const SizedBox();
                                  }),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Prazos para compartilhamento"),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Observer(builder: (context) {
                                    return storeEstimativaPrazo
                                            .prazosValidos.isNotEmpty
                                        ? SizedBox(
                                            height: 120,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: storeEstimativaPrazo
                                                    .prazosValidos.length,
                                                itemBuilder: (context, index) {
                                                  PrazoEntity prazoEntity =
                                                      storeEstimativaPrazo
                                                          .prazosValidos[index];
                                                  return CardResultadoPrazoCompartilhar(
                                                      projetoEntitie: projeto,
                                                      prazoEntity: prazoEntity);
                                                }),
                                          )
                                        : const SizedBox();
                                  }),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Equipes para compartilhamento"),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Observer(builder: (context) {
                                    return storeEstimativaPrazo
                                            .prazosValidos.isNotEmpty
                                        ? SizedBox(
                                            height: 120,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: storeEstimativaPrazo
                                                    .prazosValidos.length,
                                                itemBuilder: (context, index) {
                                                  EquipeEntity equipeEntity =
                                                      storeEstimativaEquipe
                                                              .equipesValidas[
                                                          index];
                                                  return CardEquipeResultadoCompartilhar(
                                                      projetoEntitie: projeto,
                                                      equipeEntity:
                                                          equipeEntity);
                                                }),
                                          )
                                        : const SizedBox();
                                  }),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Custos para compartilhamento"),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Observer(builder: (context) {
                                    return storeEstimativaCusto
                                            .custosValidos.isNotEmpty
                                        ? SizedBox(
                                            height: 120,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: storeEstimativaCusto
                                                    .custosValidos.length,
                                                itemBuilder: (context, index) {
                                                  CustoEntity custoEntity =
                                                      storeEstimativaCusto
                                                          .custosValidos[index];
                                                  return CardResultadoCustoCompartilhar(
                                                      projetoEntitie: projeto,
                                                      custoEntity: custoEntity);
                                                }),
                                          )
                                        : const SizedBox();
                                  }),
                                ],
                              )
                            ],
                          ),
                        ),
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
                      }),
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
