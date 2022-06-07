import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContagemDetalhada extends StatelessWidget {
  final String nomeDaFuncao;
  final String tipoFuncao;
  const ContagemDetalhada(
      {Key? key, required this.tipoFuncao, required this.nomeDaFuncao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                nomeDaFuncao,
                style: const TextStyle(color: corCorpoTexto),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                tipoFuncao,
                style: const TextStyle(color: corCorpoTexto),
              ),
            ),

            // SizedBox(
            //   width: ,

            // )
          ],
        )
      ],
    );
  }
}
