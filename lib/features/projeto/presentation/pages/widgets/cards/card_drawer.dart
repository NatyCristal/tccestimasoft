import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';

class CardDrawer extends StatelessWidget {
  final Function acao;
  final IconData icone;
  final String nomeCard;
  const CardDrawer(
      {Key? key,
      required this.nomeCard,
      required this.acao,
      this.icone = Icons.abc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => acao(),
      child: Container(
          alignment: Alignment.centerLeft,
          padding: paddingPagePrincipal,
          height: 60,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide.none,
              left: BorderSide.none,
              bottom: BorderSide(
                width: 0.5,
                color: corDeLinhaAppBar,
              ),
              top: BorderSide(
                width: 0.5,
                color: corDeLinhaAppBar,
              ),
            ),
            color: corDeFundoCards,
          ),
          width: TamanhoTela.width(context, 1),
          child: Row(
            children: [
              Text(
                nomeCard,
                style: const TextStyle(
                    color: corTituloTexto,
                    fontWeight: Fontes.weightTextoNormal),
              ),
              icone == Icons.abc
                  ? const SizedBox()
                  : Icon(icone, color: corCorpoTexto)
            ],
          )),
    );
  }
}
