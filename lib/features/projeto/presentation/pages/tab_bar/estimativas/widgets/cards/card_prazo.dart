import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:flutter/material.dart';

class CardPrazo extends StatelessWidget {
  final StoreEstimativaPrazo store;
  final PrazoEntity prazoEntity;
  const CardPrazo({Key? key, required this.store, required this.prazoEntity})
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
              "Tipo Contagem: " + prazoEntity.contagemPontoDeFuncao,
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
                  Column(
                    children: [
                      SizedBox(
                        width: TamanhoTela.width(context, 0.7),
                        child: Text(
                          "Tipo Sistema: ${prazoEntity.tipoSistema}",
                          maxLines: 3,
                          style: const TextStyle(color: corCorpoTexto),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Prazo Mínimo: ${prazoEntity.prazoMinimo} Dias",
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Prazo: ${prazoEntity.prazoTotal} Dias",
                    style: const TextStyle(color: corTituloTexto),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
