import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/store/store_resultados.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/alerta_copiar_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardEstimadaResultado extends StatelessWidget {
  final StoreProjetosIndexMenu storeIndex;
  final ProjetoEntitie projetoEntitie;
  final ContagemEstimadaEntitie contagemEstimadaEntitie;
  const CardEstimadaResultado(
      {Key? key,
      required this.projetoEntitie,
      required this.contagemEstimadaEntitie,
      required this.storeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreResultados store = StoreResultados();
    store.compartilhada = contagemEstimadaEntitie.compartilhada;
    return GestureDetector(
      onTap: () {
        contagemEstimadaEntitie.compartilhada
            ? Alerta.alertaSimplesTextoOk(
                "", "Estimativa já compartilhada", context)
            : Alerta.alertaSimOuNao(context, store, () async {
                contagemEstimadaEntitie.uidUsuario =
                    Modular.get<UsuarioAutenticado>().store.uid;
                await Modular.get<ProjetoController>()
                    .resultadoController
                    .enviarContagemEstimada(
                        store.anonimo,
                        contagemEstimadaEntitie,
                        projetoEntitie.uidProjeto,
                        Modular.get<UsuarioAutenticado>().store.uid);
                store.compartilhada = true;
                contagemEstimadaEntitie.compartilhada = true;
                storeIndex.houveMudancaEmResultado = true;
              });
      },
      child: Container(
        margin: const EdgeInsets.all(5),
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
                    child: Text("Contagem Estimada"))),
            GestureDetector(
              onTap: () {
                String texto =
                    "Contagem Estimada\n\nTotal de PF:  ${contagemEstimadaEntitie.totalPF}\n";
                Alerta.alertaCopiar(context, texto, texto);
              },
              child: Observer(builder: (context) {
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
