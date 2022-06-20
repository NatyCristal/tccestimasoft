import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CardCustoEstimativa extends StatelessWidget {
  final StoreEstimativaCusto store;
  final CustoEntity custoEntity;
  const CardCustoEstimativa(
      {Key? key, required this.store, required this.custoEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerCustoTotalProjeto = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    controllerCustoTotalProjeto.text =
        custoEntity.custoTotalProjeto.toStringAsFixed(2);

    final controllerValorTotalProjeto = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");
    controllerValorTotalProjeto.text =
        custoEntity.valorTotalProjeto.toStringAsFixed(2);

    final controllerCustoTotalMensal = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    controllerCustoTotalMensal.text = custoEntity.custoTotalMensal;

    final controllerCustoPf = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");
    controllerCustoPf.text = custoEntity.custoPF;

    final controllerCustoHora = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    controllerCustoHora.text = custoEntity.custoHora.toStringAsFixed(2);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: arredondamentoBordas,
          color: Colors.yellow.withOpacity(0.3)),
      width: double.infinity,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Custo ${custoEntity.tipoContagem}",
              style: const TextStyle(color: corTituloTexto),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Disp. Equipe:  ${custoEntity.disponibilidadeEquipe} HH",
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Custo Total Mensal: " + controllerCustoTotalMensal.text,
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Custo Hora: ${controllerCustoHora.text}",
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Custo do PF: ${controllerCustoPf.text}",
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Custo do projeto: ${controllerCustoTotalProjeto.text}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: corTituloTexto),
                        ),
                        Text(
                          "Valor do projeto: ${controllerValorTotalProjeto.text}",
                          style: const TextStyle(color: corTituloTexto),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      store.remover(custoEntity);
                    },
                    child: SizedBox(
                      width: 50,
                      child: Icon(
                        Icons.delete,
                        color: corDeAcao.withOpacity(0.8),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
