import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/store/store_resultados.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Alerta {
  static alertaCopiar(context, String textoDialogo, String textoParaCopiar) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Informações",
      style: const AlertStyle(
        titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
      ),
      content: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            textoDialogo,
            style: const TextStyle(
                color: corCorpoTexto, fontSize: tamanhoSubtitulo),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: corDeFundoBotaoSecundaria,
          child: const Text(
            "Copiar",
            style: TextStyle(
                fontWeight: Fontes.weightTextoNormal,
                color: corDeTextoBotaoSecundaria,
                fontSize: 14),
          ),
          onPressed: () async {
            ClipboardData data = ClipboardData(text: textoParaCopiar);
            await Clipboard.setData(data).then((value) {
              AlertaSnack.exbirSnackBar(context, "Dados copiados");
              Navigator.of(context, rootNavigator: true).pop();
            });
          },
          width: 120,
        ),
      ],
    ).show();
  }

  static alertaSimOuNao(context, StoreResultados store, Function acaoSim) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Deseja Compartilhar essa estimativa?",
      style: const AlertStyle(
        titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
      ),
      content: Column(
        children: [
          Observer(builder: (context) {
            return CheckboxListTile(
                title: const Text("Compartilhar Anônimamente?"),
                value: store.anonimo,
                onChanged: (value) {
                  store.anonimo = value as bool;
                });
          }),
        ],
      ),
      buttons: [
        DialogButton(
          color: corDeFundoBotaoSecundaria,
          child: const Text(
            "SIM",
            style: TextStyle(
                fontWeight: Fontes.weightTextoNormal,
                color: corDeTextoBotaoSecundaria,
                fontSize: 14),
          ),
          onPressed: () async {
            acaoSim();
            Navigator.of(context, rootNavigator: true).pop();
          },
          width: 120,
        ),
        DialogButton(
          color: Colors.indigo,
          child: const Text(
            "NÃO",
            style: TextStyle(
              fontWeight: Fontes.weightTextoNormal,
              color: corTextoSobCorPrimaria,
              fontSize: 14,
            ),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          width: 120,
        )
      ],
    ).show();
  }

  static alertaSimplesTextoOk(String texto, String titulo, context) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: titulo,
      style: const AlertStyle(
        titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
      ),
      content: Column(
        children: [
          Text(texto),
        ],
      ),
      buttons: [
        DialogButton(
          color: corDeFundoBotaoSecundaria,
          child: const Text(
            "Ok",
            style: TextStyle(
                fontWeight: Fontes.weightTextoNormal,
                color: corDeTextoBotaoSecundaria,
                fontSize: 14),
          ),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
          },
          width: 120,
        ),
      ],
    ).show();
  }
}