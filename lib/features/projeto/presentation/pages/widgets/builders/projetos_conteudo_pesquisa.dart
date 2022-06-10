import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/projeto_principal_pesquisa_card.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/widgets.dart';

class ProjetosConteudoPesquisa extends StatelessWidget {
  final ScrollController scroll;
  final StoreProjetos store;
  const ProjetosConteudoPesquisa(
      {Key? key, required this.scroll, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scroll,
      shrinkWrap: true,
      itemCount: store.pesquisarProjetos(),
      itemBuilder: (context, index) {
        ProjetoEntitie projeto = store.projetosPesquisa[index];

        return ProjetoPesquisaCard(projeto: projeto);
      },
    );
  }
}
