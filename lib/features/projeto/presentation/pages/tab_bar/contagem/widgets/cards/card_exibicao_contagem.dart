import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CardExibicaoContagem extends StatelessWidget {
  final String tipo;
  final String tituloCard;
  final List<String> storeIndicativa;
  const CardExibicaoContagem({
    Key? key,
    required this.storeIndicativa,
    required this.tituloCard,
    required this.tipo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        alertaEdicao(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        width: TamanhoTela.width(context, 0.9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: storeIndicativa.length,
                itemBuilder: (context, index) {
                  String nomeFuncao = storeIndicativa[index];
                  return Row(children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        nomeFuncao,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: corCorpoTexto.withOpacity(0.5),
                          fontWeight: Fontes.weightTextoLeve,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        tipo,
                        maxLines: 1,
                        style: TextStyle(
                          color: corCorpoTexto.withOpacity(0.5),
                          fontWeight: Fontes.weightTextoLeve,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Text(
                        "Baixa",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: corCorpoTexto.withOpacity(0.5),
                          fontWeight: Fontes.weightTextoLeve,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        "7",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: corCorpoTexto.withOpacity(0.5),
                          fontWeight: Fontes.weightTextoLeve,
                        ),
                      ),
                    ),
                  ]);
                }),
          ],
        ),
      ),
    );
  }
}

alertaEdicao(context) {
  return Alert(
    context: context,
    title: "Edição impossível",
    style: const AlertStyle(
      titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
    ),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          height: 20,
        ),
        Text(
          "Para editar um ALI ou AIE volte para a contagem indicativa",
          style: TextStyle(
              fontWeight: Fontes.weightTextoLeve,
              color: corCorpoTexto,
              fontSize: tamanhoSubtitulo),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        color: corDeFundoBotaoSecundaria,
        child: const Text(
          "OK",
          style: TextStyle(
              fontWeight: Fontes.weightTextoNormal,
              color: corDeTextoBotaoSecundaria,
              fontSize: 14),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        width: 120,
      ),
    ],
  ).show();
}
