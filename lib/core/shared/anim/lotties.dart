import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Carregando extends StatelessWidget {
  //final Color cordeFundo;
  const Carregando({
    Key? key,
    //  this.cordeFundo = Colors.black12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SizedBox(
        height: TamanhoTela.height(context, 0.9),
        width: TamanhoTela.width(context, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 150,
                height: 150,
                child: Lottie.asset("assets/carregando_2.json")),
            const Text(
              "Carregando..",
              style: TextStyle(fontSize: 25, color: Colors.black38),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class Erro extends StatelessWidget {
  const Erro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12.withOpacity(0.1),
      child: SizedBox(
        height: TamanhoTela.height(context, 0.9),
        width: TamanhoTela.width(context, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 150,
                height: 150,
                child: Lottie.asset("assets/carregando_2.json")),
            const Text(
              "Carregando..",
              style: TextStyle(fontSize: 25, color: Colors.black38),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
