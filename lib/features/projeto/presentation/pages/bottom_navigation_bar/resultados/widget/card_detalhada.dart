import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/material.dart';

class CardDetalhadaResultado extends StatelessWidget {
  const CardDetalhadaResultado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: arredondamentoBordas,
        color: Colors.grey.withOpacity(0.2),
      ),
      width: 100,
      height: 120,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: const [
          Center(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Text("Contagem Detalhada"))),
          CircleAvatar(
            backgroundColor: corDeFundoBotaoSecundaria,
            child: Icon(
              Icons.send,
              color: corDeFundoBotaoPrimaria,
            ),
          )
        ],
      ),
    );
  }
}
