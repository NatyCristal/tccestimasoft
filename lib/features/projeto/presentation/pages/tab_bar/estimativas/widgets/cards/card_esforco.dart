import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:flutter/material.dart';

class CardEsforco extends StatelessWidget {
  final StoreEstimativaEsforco store;
  final EsforcoEntity esforcoEntity;
  const CardEsforco(
      {Key? key, required this.esforcoEntity, required this.store})
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
              "Tipo Contagem: " + esforcoEntity.contagemPontoDeFuncao,
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
                    "Linguagem: " + esforcoEntity.linguagem,
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Produtividade Equipe: " +
                        esforcoEntity.produtividadeEquipe,
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Esforço Total: ${esforcoEntity.esforcoTotal} Horas",
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         //    store.remover(esforcoEntity);
              //       },
              //       child: const SizedBox(
              //         width: 50,
              //         // child:
              //         //  Icon(
              //         //   Icons.delete,
              //         //   color: corDeAcao.withOpacity(0.8),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
