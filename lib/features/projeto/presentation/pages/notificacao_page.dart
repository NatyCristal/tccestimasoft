import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared/utils/cores_fontes.dart';

class NotificacaoPage extends StatelessWidget {
  const NotificacaoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Notificações",
          style: TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: SizedBox(
        height: TamanhoTela.height(context, 1),
        child: const Center(
            child: Text(
          "Tela em desenvolvimento \nAguarde lançamentos futuros",
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
