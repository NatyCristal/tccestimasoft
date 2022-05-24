import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'contagem/contagem_indicativa.dart';
import 'home/index_home.dart';
import 'home/store/store_projeto_index_menu.dart';

class ProjetoMenuPage extends StatelessWidget {
  final ProjetoEntitie projeto;
  final StoreProjetosIndexMenu store = StoreProjetosIndexMenu();
  final StoreContagemIndicativa storeIndicativa = StoreContagemIndicativa();

  ProjetoMenuPage({Key? key, required this.projeto}) : super(key: key);

  _itemSelecionado(int index) {
    store.index = index;
  }

  listaBottomNavigator(ProjetoEntitie projeto, StoreProjetosIndexMenu store) {
    switch (store.index) {
      case 0:
        return IndexHome(
          projeto: projeto,
        );

      case 1:
        return const Text("Index 1: Estimativas");

      case 2:
        return const Text(
          'Index 2: Perfil',
        );

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
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Text(
                        projeto.nomeProjeto,
                        style: const TextStyle(
                            fontSize: tamanhoSubtitulo, color: corTituloTexto),
                      ),
                      // shape: const Border(
                      //   bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
                      // ),
                      bottom: TabBar(
                        indicatorWeight: 2,
                        overlayColor: MaterialStateProperty.all(background),
                        indicatorColor: corDeFundoBotaoSecundaria,
                        tabs: const [
                          Tab(
                              text: "Indicativa",
                              icon: Icon(Icons.call_missed_outgoing_rounded)),
                          Tab(
                              text: "Estimada",
                              icon: Icon(Icons.import_export_rounded)),
                          Tab(
                              text: "Detalhada",
                              icon: Icon(Icons.manage_search_rounded)),
                        ],
                      ),
                    ),
                    body: TabBarView(children: [
                      ContagemIndicativa(
                        store: storeIndicativa,
                        projetoUid: projeto.uidProjeto,
                      ),
                      const Icon(Icons.directions_transit),
                      const Icon(Icons.directions_bike)
                    ]),
                    bottomNavigationBar: Observer(builder: (context) {
                      return BottomNavigationBar(
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
                        ],
                      );
                    })),
              ),
            )
          : Scaffold(
              appBar: AppBar(
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
                  ],
                );
              }),
            );
    });
  }
}
