import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../tab_bar/contagem/contagem_indicativa.dart';
import '../../tab_bar/home/store/store_projeto_index_menu.dart';

class Contagem extends StatelessWidget {
  final StoreProjetosIndexMenu store;
  final Function itemSelecionado;
  final ProjetoEntitie projeto;
  final StoreContagemIndicativa storeIndicativa = StoreContagemIndicativa();
  Contagem(
      {Key? key,
      required this.projeto,
      required this.itemSelecionado,
      required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
                store: storeIndicativa, projetoUid: projeto.uidProjeto),
            const Icon(Icons.directions_transit),
            const Icon(Icons.directions_bike)
          ]),
          bottomNavigationBar: Observer(
            builder: (context) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: store.index,
                selectedItemColor: corDeAcao,
                onTap: itemSelecionado(store.index),
                items: const [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                      label: "Contagem", icon: Icon(Icons.auto_graph_outlined)),
                  BottomNavigationBarItem(
                      label: "Estimativas",
                      icon: Icon(Icons.bar_chart_rounded)),
                  BottomNavigationBarItem(
                      label: "Resultado",
                      icon: Icon(Icons.checklist_rtl_rounded)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
