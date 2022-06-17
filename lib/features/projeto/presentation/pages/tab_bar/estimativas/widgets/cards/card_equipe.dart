import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:flutter/material.dart';

class CardEquipeEstimativa extends StatelessWidget {
  final StoreEstimativaEquipe store;
  final EquipeEntity equipeEntity;
  const CardEquipeEstimativa(
      {Key? key, required this.equipeEntity, required this.store})
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
              "Equipe ${equipeEntity.esforco.split(" - ").last}",
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
                    "Esforço: " + equipeEntity.esforco,
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Prazo: " + equipeEntity.prazo,
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Produção diária: ${equipeEntity.producaoDiaria}",
                    style: const TextStyle(color: corCorpoTexto),
                  ),
                  Text(
                    "Equipe Estimada: ${equipeEntity.equipeEstimada}",
                    style: const TextStyle(color: corCorpoTexto),
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
                      store.remover(equipeEntity);
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
