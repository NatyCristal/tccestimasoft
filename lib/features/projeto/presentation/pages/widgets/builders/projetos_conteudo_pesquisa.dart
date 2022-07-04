import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/projeto_card.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/widgets.dart';

class ProjetosConteudoPesquisa extends StatelessWidget {
  final ScrollController scroll;
  final String valorPesquisa;
  final StoreProjetos projetosStore;
  const ProjetosConteudoPesquisa(
      {Key? key,
      required this.scroll,
      required this.valorPesquisa,
      required this.projetosStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProjetoEntitie> projetos =
        projetosStore.pesquisarProjetos(valorPesquisa);

    return projetos.isNotEmpty
        ? ListView.builder(
            itemCount: projetos.length,
            itemBuilder: (context, index) {
              ProjetoEntitie projeto = projetos[index];
              return ProjetoCard(projeto: projeto);
            })
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                // ProdutosVazio(),
                Text(
                  "A pesquisa não retornou nenhum resultado",
                  style: TextStyle(
                      color: corCorpoTexto,
                      fontSize: 16,
                      fontWeight: Fontes.weightTextoNormal),
                ),
              ],
            ),
          );

    // return ListView.builder(
    //   controller: scroll,
    //   shrinkWrap: true,
    //   itemCount: store.pesquisarProjetos(),
    //   itemBuilder: (context, index) {
    //     ProjetoEntitie projeto = store.projetosPesquisa[index];

    //     return ProjetoPesquisaCard(projeto: projeto);
    //   },
    // );
  }
}
