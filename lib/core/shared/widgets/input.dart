import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:flutter/material.dart';

class InputPadrao extends StatelessWidget {
  final TextEditingController controller;
  final Function validar;
  final Color corDeFundoIcone;
  final Function acaoClicarIcone;
  final bool ehSenha;
  final String rotulo;
  final IconData icone;
  final String erroTexto;
  final Color corDeFundoBotao;
  final bool temErroCampoInput;
  const InputPadrao(
      {Key? key,
      required this.temErroCampoInput,
      required this.corDeFundoBotao,
      required this.erroTexto,
      required this.rotulo,
      this.icone = Icons.abc,
      required this.acaoClicarIcone,
      required this.ehSenha,
      this.corDeFundoIcone = Colors.transparent,
      required this.validar,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rotulo,
            style: const TextStyle(
                color: corTituloTexto, fontWeight: Fontes.weightTextoTitulo),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: controller,
            onChanged: (value) => validar(value),
            obscureText: ehSenha,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 13, right: 13, top: 0, bottom: 0),
              errorStyle: const TextStyle(
                height: 0.3,
                overflow: TextOverflow.ellipsis,
                fontWeight: Fontes.weightTextoLeve,
              ),
              errorText: erroTexto == "" ? "" : erroTexto,
              suffixIcon: icone != Icons.abc
                  ? GestureDetector(
                      onTap: () => acaoClicarIcone(),
                      child: Container(
                          //margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            borderRadius: arredondamentoBordas,
                            color: corDeFundoIcone,
                          ),
                          child: Icon(icone)),
                    )
                  : const SizedBox(),
              filled: true,
              fillColor: corDeFundoBotao,
              border: OutlineInputBorder(
                borderRadius: arredondamentoBordas,
                borderSide: BorderSide(
                  width: 0,
                  style:
                      temErroCampoInput ? BorderStyle.solid : BorderStyle.none,
                ),
              ),
            ),
            cursorColor: corDeTextoBotaoSecundaria,
          ),
        ],
      ),
    );
  }
}
