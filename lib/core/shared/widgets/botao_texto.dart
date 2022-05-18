import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/material.dart';

class BotaoTexto extends StatelessWidget {
  final Color corTexto;
  final String textoBotao;
  final Function acaoBotao;
  const BotaoTexto(
      {Key? key,
      required this.textoBotao,
      required this.acaoBotao,
      required this.corTexto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => acaoBotao(),
      child: Text(textoBotao,
          style: TextStyle(
              fontSize: tamanhoSubtitulo,
              color: corTexto,
              fontWeight: Fontes.weightTextoTitulo)),
    );
  }
}
