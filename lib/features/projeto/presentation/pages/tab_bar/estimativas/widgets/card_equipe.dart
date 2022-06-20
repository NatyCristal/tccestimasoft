import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/cadastro_insumo_custo_entity.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CardEquipe extends StatelessWidget {
  final StoreEstimativaCusto store;
  final CadastroInsumoCustoEntity insumoCustoEntity;

  final bool custo;
  const CardEquipe(
      {Key? key,
      required this.store,
      this.custo = false,
      required this.insumoCustoEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerSalario = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");

    controllerSalario.text = insumoCustoEntity.valor;
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
                width: 180,
                child: Text(
                  insumoCustoEntity.nome,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: corCorpoTexto,
                      fontWeight: Fontes.weightTextoNormal),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      controllerSalario.text,
                      overflow: TextOverflow.ellipsis,
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
                          ? store.removerCusto(insumoCustoEntity, context)
                          : store.removerEquipe(insumoCustoEntity, context)),
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
