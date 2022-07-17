import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/formatadores.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CardCustosGerais extends StatelessWidget {
  final StoreEstimativaCusto storeEstimativaCusto;
  const CardCustosGerais({Key? key, required this.storeEstimativaCusto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerCustoPF = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    controllerCustoPF.text = storeEstimativaCusto.custoPF.toString();
    return Column(
      children: [
        const Text(
          "Custos Gerais",
          style: TextStyle(color: corTituloTexto, fontSize: tamanhoSubtitulo),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Custo total mensal",
              style: TextStyle(
                  fontSize: tamanhoSubtitulo,
                  color: corCorpoTexto,
                  fontWeight: Fontes.weightTextoNormal),
            ),
            Observer(builder: (context) {
              return SizedBox(
                child: Text(
                  Formatadores.formatadorMonetario(
                      storeEstimativaCusto.custoTotalMensal.toStringAsFixed(2)),
                  style: const TextStyle(
                      fontSize: tamanhoSubtitulo,
                      color: corCorpoTexto,
                      fontWeight: Fontes.weightTextoNormal),
                ),
              );
            }),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Custo PF",
              style: TextStyle(
                  fontSize: tamanhoSubtitulo,
                  color: corCorpoTexto,
                  fontWeight: Fontes.weightTextoNormal),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: controllerCustoPF,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  storeEstimativaCusto.custoPF = double.parse(
                      value.toString() == ""
                          ? "0"
                          : value
                              .toString()
                              .replaceAll("R\$", "")
                              .replaceAll(".", "")
                              .replaceAll(",", "."));

                  storeEstimativaCusto.validarValorTotalProjeto();
                  storeEstimativaCusto.calcularCustoHora();
                },
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Porcentagem de lucro",
              style: TextStyle(
                  fontSize: tamanhoSubtitulo,
                  color: corCorpoTexto,
                  fontWeight: Fontes.weightTextoNormal),
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      storeEstimativaCusto.porcentagemLucro = double.parse(
                          value.toString() == "" ? "0" : value.toString());
                      storeEstimativaCusto.validarValorTotalProjeto();
                    },
                  ),
                ),
                const Text("%",
                    style: TextStyle(
                        fontSize: tamanhoSubtitulo,
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal)),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          color: corDeLinhaAppBar,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
