import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
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
                  Row(
                    children: [
                      const SizedBox(
                        width: 90,
                        child: Text(
                          "Tipo Sistema:",
                          style: TextStyle(color: corCorpoTexto),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          prazoEntity.tipoSistema,
                          style: const TextStyle(color: corCorpoTexto),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      store.remover(prazoEntity);
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
