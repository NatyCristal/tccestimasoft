import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:flutter/widgets.dart';

class ProjetoPesquisaCard extends StatelessWidget {
  final ProjetoEntitie projeto;
  const ProjetoPesquisaCard({Key? key, required this.projeto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: paddingPagePrincipal,
      decoration: BoxDecoration(
          color: corDeFundoCards, borderRadius: arredondamentoBordas),
      height: 100,
      width: double.infinity,
      child: Column(
        children: [
          Text(projeto.nomeProjeto),
          Text(projeto.dataCriacao),
        ],
      ),
    );
  }
}
