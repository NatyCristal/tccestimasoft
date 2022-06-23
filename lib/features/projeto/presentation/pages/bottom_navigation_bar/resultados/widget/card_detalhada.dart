import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/store/store_resultados.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'alerta_copiar_estimativas.dart';

class CardDetalhadaResultado extends StatelessWidget {
  final StoreProjetosIndexMenu storeIndex;
  final ProjetoEntitie projetoEntitie;
  final ContagemDetalhadaEntitie contagemDetalhadaEntitie;
  const CardDetalhadaResultado(
      {Key? key,
      required this.projetoEntitie,
      required this.contagemDetalhadaEntitie,
      required this.storeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreResultados store = StoreResultados();
    store.compartilhada = contagemDetalhadaEntitie.compartilhada;
    return GestureDetector(
      onTap: () {
        contagemDetalhadaEntitie.compartilhada
            ? Alerta.alertaSimplesTextoOk(
                "", "Estimativa já compartilhada", context)
            : Alerta.alertaSimOuNao(context, store, () async {
                await Modular.get<ProjetoController>()
                    .resultadoController
                    .enviarContagemDetalhada(
                        store.anonimo,
                        contagemDetalhadaEntitie,
                        projetoEntitie.uidProjeto,
                        Modular.get<UsuarioAutenticado>().store.uid);
                store.compartilhada = true;
                contagemDetalhadaEntitie.compartilhada = true;
                storeIndex.houveMudancaEmResultado = true;
              });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: arredondamentoBordas,
            color: Colors.red.withOpacity(0.5)),
        width: 140,
        height: 100,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            const Center(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text("Contagem Detalhada"))),
            GestureDetector(
              onTap: (() {
                String texto =
                    "Contagem Detalhada\n\nTotal de PF:  ${contagemDetalhadaEntitie.totalPf}\n";
                Alerta.alertaCopiar(context, texto, texto);
              }),
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
            ),
          ],
        ),
      ),
    );
  }
}
