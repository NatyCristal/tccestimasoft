import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/core/shared/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EstimativaIndicativa extends StatelessWidget {
  const EstimativaIndicativa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            InputPadrao(
                temErroCampoInput: false,
                corDeFundoBotao: background,
                erroTexto: "",
                rotulo: "Nome da função",
                acaoClicarIcone: () {},
                ehSenha: false,
                validar: () {},
                controller: TextEditingController()),
            DropdownButton(
                items: <String>[
                  'ALI',
                  'AIE',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {}),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 180,
                child: BotaoPadrao(
                    corDeTextoBotao: corTextoSobSecundaria,
                    acao: () {},
                    tituloBotao: "Adicionar Função",
                    corBotao: corDeFundoBotaoSecundaria,
                    carregando: false),
              ),
            )
          ],
        ),
      ),
    );
  }
}
