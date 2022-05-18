import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  final bool carregando;
  final Color corBotao;
  final String tituloBotao;
  final Function acao;
  final Color corDeTextoBotao;
  final Widget icone;
  const BotaoPadrao(
      {Key? key,
      required this.acao,
      required this.tituloBotao,
      required this.corBotao,
      this.corDeTextoBotao = corDeTextoBotaoSecundaria,
      this.icone = const SizedBox(),
      required this.carregando})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginBotaoInputs,
      height: alturaBotao,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => acao(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tituloBotao,
              style:
                  TextStyle(color: corDeTextoBotao, fontSize: tamanhoSubtitulo),
            ),
            const SizedBox(
              width: 10,
            ),
            icone,
            const SizedBox(
              width: 10,
            ),
            carregando
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: corDeTextoBotao,
                    ),
                  )
                : const SizedBox()
          ],
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: arredondamentoBordas)),
          backgroundColor: MaterialStateProperty.all(corBotao),
        ),
      ),
    );
  }
}
