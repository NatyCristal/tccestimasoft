import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/formatadores.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:flutter/material.dart';

class CardCustoEstimativa extends StatelessWidget {
  final StoreEstimativaCusto store;
  final CustoEntity custoEntity;
  const CardCustoEstimativa(
      {Key? key, required this.store, required this.custoEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              "Custo ${custoEntity.tipoContagem.split(" - ").first}",
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
                    "Custo Total Mensal: ${Formatadores.formatadorMonetario(custoEntity.custoTotalMensal)}",
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Custo Hora: ${Formatadores.formatadorMonetario(custoEntity.custoHora.toStringAsFixed(2))}",
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Custo do PF: ${Formatadores.formatadorMonetario(custoEntity.custoPF)}",
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
                          "Custo do projeto: ${Formatadores.formatadorMonetario(custoEntity.custoTotalProjeto.toStringAsFixed(2))}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: corTituloTexto),
                        ),
                        Text(
                          "Valor do projeto: ${Formatadores.formatadorMonetario(custoEntity.valorTotalProjeto.toStringAsFixed(2))}",
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
