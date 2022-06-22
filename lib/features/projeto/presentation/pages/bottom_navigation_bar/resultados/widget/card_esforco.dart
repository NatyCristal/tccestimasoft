import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/store/store_resultados.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/alerta_copiar_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/auth/usuario_autenticado.dart';

class CardEsforcoResultado extends StatelessWidget {
  final ProjetoEntitie projetoEntitie;
  final EsforcoEntity esforcoEntity;
  const CardEsforcoResultado({
    Key? key,
    required this.esforcoEntity,
    required this.projetoEntitie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreResultados store = StoreResultados();
    store.compartilhada = esforcoEntity.compartilhada;
    return GestureDetector(
      onTap: () {
        esforcoEntity.compartilhada
            ? Alerta.alertaSimplesTextoOk(
                "", "Estimativa já compartilhada", context)
            : Alerta.alertaSimOuNao(context, store, () async {
                await Modular.get<ProjetoController>()
                    .resultadoController
                    .enviarEstimativasEsforco(
                        store.anonimo,
                        esforcoEntity,
                        projetoEntitie.uidProjeto,
                        Modular.get<UsuarioAutenticado>().store.uid);
              });

        esforcoEntity.compartilhada = true;
        store.compartilhada = esforcoEntity.compartilhada;
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: arredondamentoBordas,
          color: Colors.lime.withOpacity(0.4),
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Center(
                child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Text("Estimativa esforco"),
                  Text(esforcoEntity.contagemPontoDeFuncao.split(" - ").first),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                String texto =
                    "Estimativa de Esforço\nTipo Contagem: ${esforcoEntity.contagemPontoDeFuncao.split(" - ").first}\n Linguagem:${esforcoEntity.linguagem}\nProdutividade Equipe: ${esforcoEntity.produtividadeEquipe} \nEsforço Total: ${esforcoEntity.esforcoTotal}";
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
