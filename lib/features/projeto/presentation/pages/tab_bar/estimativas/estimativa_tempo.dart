import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';

class EstimativaTempo extends StatelessWidget {
  const EstimativaTempo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //     final String response = await rootBundle.loadString('assets/sample.json');
    // final data = await json.decode(response);

    return Container(
      height: TamanhoTela.height(context, 1),
      color: Colors.blue,
    );
  }
}
