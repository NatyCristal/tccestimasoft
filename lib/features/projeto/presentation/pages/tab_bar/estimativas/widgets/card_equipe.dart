import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:flutter/material.dart';

class CardEquipe extends StatelessWidget {
  final StoreEstimativaCusto store;
  final String chave;
  final String valor;
  final bool custo;
  const CardEquipe(
      {Key? key,
      required this.valor,
      required this.chave,
      required this.store,
      this.custo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                    color: const Color(0xFF87D8CD),
                    borderRadius: arredondamentoBordas),
                child: custo
                    ? const Icon(
                        Icons.monetization_on,
                        color: corDeFundoBotaoSecundaria,
                      )
                    : const Icon(
                        Icons.person,
                        color: corDeFundoBotaoSecundaria,
                      ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  chave,
                  maxLines: 1,
                  style: const TextStyle(
                      color: corCorpoTexto,
                      fontWeight: Fontes.weightTextoNormal),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      valor,
                      maxLines: 1,
                      style: const TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: (() => custo
                          ? store.removerCusto(chave, valor, context)
                          : store.removerEquipe(chave, valor, context)),
                      child: const Icon(Icons.delete, color: Colors.grey))
                ],
              ),
            ],
          ),
          Divider(
            color: corDeFundoBotaoSecundaria.withOpacity(0.6),
          )
        ],
      ),
    );
  }
}
