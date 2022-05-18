import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjetoCard extends StatelessWidget {
  final ProjetoEntitie projeto;
  const ProjetoCard({
    Key? key,
    required this.projeto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() =>
          Modular.to.pushNamed("projeto-informacao", arguments: projeto)),
      child: Container(
        padding: paddingPagePrincipal,
        decoration: BoxDecoration(
            image: const DecorationImage(
              opacity: 0.2,
              image: AssetImage("assets/projeto3.png"),
            ),
            color: const Color(0XFFD8DCDF).withOpacity(0.3),
            borderRadius: arredondamentoBordas),
        margin: const EdgeInsets.all(5),
        height: 100,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              projeto.nomeProjeto,
              style: const TextStyle(
                color: corTituloTexto,
                fontWeight: Fontes.weightTextoNormal,
              ),
            ),
            const SizedBox(height: 10),
            Text(projeto.dataCriacao,
                style: const TextStyle(
                  fontSize: tamanhoTextoCorpoTexto,
                  color: corCorpoTexto,
                  fontWeight: Fontes.weightTextoNormal,
                )),
          ],
        ),
      ),
    );
  }
}
