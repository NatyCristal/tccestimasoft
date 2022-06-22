import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/store/store_resultados.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/alerta_copiar_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/auth/usuario_autenticado.dart';

class CardEquipeResultadoCompartilhar extends StatelessWidget {
  final ProjetoEntitie projetoEntitie;
  final EquipeEntity equipeEntity;
  const CardEquipeResultadoCompartilhar({
    Key? key,
    required this.equipeEntity,
    required this.projetoEntitie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreResultados store = StoreResultados();
    store.compartilhada = equipeEntity.compartilhada;
    return GestureDetector(
      onTap: () {
        equipeEntity.compartilhada
            ? Alerta.alertaSimplesTextoOk(
                "", "Estimativa já compartilhada", context)
            : Alerta.alertaSimOuNao(context, store, () async {
                await Modular.get<ProjetoController>()
                    .resultadoController
                    .enviarEstimativaEquipe(
                        store.anonimo,
                        equipeEntity,
                        projetoEntitie.uidProjeto,
                        Modular.get<UsuarioAutenticado>().store.uid);
              });

        equipeEntity.compartilhada = true;
        store.compartilhada = true;
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: arredondamentoBordas,
          color: Colors.cyan.withOpacity(0.5),
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Center(
                child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Text("Estimativa Equipe"),
                  Text(equipeEntity.esforco.split(" - ").last),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                String texto =
                    "Estimativa de Equipe\nTipo Contagem: ${equipeEntity.esforco.split(" - ").last}\nEsforco:${equipeEntity.esforco}\nPrazo: ${equipeEntity.prazo} \nProdução diária: ${equipeEntity.producaoDiaria}\nEquipe Estimada: ${equipeEntity.equipeEstimada}";
                Alerta.alertaCopiar(context, texto, texto);
              },
              child: Observer(builder: (context) {
                return CircleAvatar(
                  backgroundColor: corDeFundoCards,
                  child: !store.compartilhada
                      ? const Icon(
                          Icons.send,
                          color: corCorpoTexto,
                        )
                      : const Icon(
                          Icons.lock,
                          color: corCorpoTexto,
                        ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
