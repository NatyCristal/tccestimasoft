import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CardCustosTotais extends StatelessWidget {
  final StoreEstimativaCusto storeEstimativaCusto;
  const CardCustosTotais({Key? key, required this.storeEstimativaCusto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerCustoTotalProjeto = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    final controllerValorTotalProjeto = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: arredondamentoBordas),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Custo do projeto",
                style: TextStyle(
                    fontSize: tamanhoSubtitulo,
                    color: corTituloTexto,
                    fontWeight: Fontes.weightTextoNormal),
              ),
              Observer(builder: (context) {
                controllerCustoTotalProjeto.text = storeEstimativaCusto
                    .custoProjeto
                    .ceilToDouble()
                    .toStringAsFixed(2);
                return SizedBox(
                  width: 150,
                  child: Text(
                    controllerCustoTotalProjeto.text,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: tamanhoSubtitulo,
                      color: corTituloTexto,
                    ),
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
                "Valor total do projeto",
                style: TextStyle(
                    fontSize: tamanhoSubtitulo,
                    color: corTituloTexto,
                    fontWeight: Fontes.weightTextoNormal),
              ),
              Observer(builder: (context) {
                controllerValorTotalProjeto.text =
                    storeEstimativaCusto.valorTotalProjeto.toString() + "0";
                return SizedBox(
                  width: 150,
                  child: Text(
                    controllerValorTotalProjeto.text,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: tamanhoSubtitulo,
                      color: corTituloTexto,
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
