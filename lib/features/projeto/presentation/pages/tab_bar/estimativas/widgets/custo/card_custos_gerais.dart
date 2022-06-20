import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
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
    final controllerCustoTotalMensal = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    final controllerCustoDaHora = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");
    final controllerCustoPF = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    return Column(
      children: [
        const Text(
          "Custos Gerais",
          style: TextStyle(color: corTituloTexto, fontSize: tamanhoSubtitulo),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Disponibilidade equipe",
              style: TextStyle(
                  color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            ),
            Observer(builder: (context) {
              return Text(
                "${storeEstimativaCusto.disponibilidadeEquipe.toString()} Homem Hora",
                style: const TextStyle(
                    color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
              );
            }),
          ],
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
                  color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            ),
            Observer(builder: (context) {
              controllerCustoTotalMensal.text =
                  storeEstimativaCusto.custoTotalMensal.toStringAsFixed(2);
              return SizedBox(
                child: Text(
                  controllerCustoTotalMensal.text,
                  style: const TextStyle(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Custo da hora",
              style: TextStyle(
                  color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            ),
            Observer(builder: (context) {
              controllerCustoDaHora.text =
                  storeEstimativaCusto.custoHora.toStringAsFixed(2);
              return Text(
                controllerCustoDaHora.text,
                style: const TextStyle(
                    color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
              );
            }),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Custo do PF",
              style: TextStyle(
                  color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            ),
            Observer(builder: (context) {
              controllerCustoPF.text =
                  storeEstimativaCusto.custoPF.toStringAsFixed(2);
              return Text(
                controllerCustoPF.text,
                style: const TextStyle(
                    color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
              );
            }),
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
            // return Text(
            //   "${storeEstimativaCusto.porcentagemLucro.toString()} R\$",
            //   style: const TextStyle(
            //       color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
            // );
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
