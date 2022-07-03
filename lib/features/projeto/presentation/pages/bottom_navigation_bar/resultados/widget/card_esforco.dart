import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/store/store_resultados.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/alerta_copiar_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/auth/usuario_autenticado.dart';

class CardEsforcoResultado extends StatelessWidget {
  final StoreProjetosIndexMenu storeIndex;
  final ProjetoEntitie projetoEntitie;
  final EsforcoEntity esforcoEntity;
  const CardEsforcoResultado({
    Key? key,
    required this.esforcoEntity,
    required this.projetoEntitie,
    required this.storeIndex,
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
                esforcoEntity.uidUsuario =
                    Modular.get<UsuarioAutenticado>().store.uid;

                await Modular.get<ProjetoController>()
                    .resultadoController
                    .enviarEstimativasEsforco(
                        store.anonimo,
                        esforcoEntity,
                        projetoEntitie.uidProjeto,
                        Modular.get<UsuarioAutenticado>().store.uid);
                esforcoEntity.compartilhada = true;
                store.compartilhada = esforcoEntity.compartilhada;
                storeIndex.houveMudancaEmResultado = true;
              });
      },
      child: Container(
        width: 140,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: arredondamentoBordas,
          color: Colors.pink.withOpacity(0.4),
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
            Observer(builder: (context) {
              return CircleAvatar(
                radius: 15,
                backgroundColor: corDeFundoCards,
                child: !store.compartilhada
                    ? const Icon(
                        Icons.check_rounded,
                        color: corCorpoTexto,
                        size: 20,
                      )
                    : Icon(
                        Icons.lock,
                        color: corCorpoTexto.withOpacity(0.5),
                        size: 20,
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}
