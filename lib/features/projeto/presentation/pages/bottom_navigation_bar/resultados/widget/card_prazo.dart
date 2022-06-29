import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/store/store_resultados.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/alerta_copiar_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardResultadoPrazoCompartilhar extends StatelessWidget {
  final StoreProjetosIndexMenu storeIndex;
  final ProjetoEntitie projetoEntitie;
  final PrazoEntity prazoEntity;
  const CardResultadoPrazoCompartilhar(
      {Key? key,
      required this.projetoEntitie,
      required this.prazoEntity,
      required this.storeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreResultados store = StoreResultados();
    store.compartilhada = prazoEntity.compartilhada;
    return GestureDetector(
      onTap: () {
        prazoEntity.compartilhada
            ? Alerta.alertaSimplesTextoOk(
                "", "Estimativa já compartilhada", context)
            : Alerta.alertaSimOuNao(context, store, () async {
                prazoEntity.uidUsuario =
                    Modular.get<UsuarioAutenticado>().store.uid;

                await Modular.get<ProjetoController>()
                    .resultadoController
                    .enviarEstimativaPrazo(
                        store.anonimo,
                        prazoEntity,
                        projetoEntitie.uidProjeto,
                        Modular.get<UsuarioAutenticado>().store.uid);
                store.compartilhada = true;
                prazoEntity.compartilhada = true;
                storeIndex.houveMudancaEmResultado = true;
              });
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: arredondamentoBordas,
            color: Colors.amber.withOpacity(0.4)),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Center(
                child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Text("Estimativa Prazo"),
                  Text(prazoEntity.contagemPontoDeFuncao.split(" - ").first),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                String texto =
                    "Estimativa de Prazo\nTipo Contagem: ${prazoEntity.contagemPontoDeFuncao.split(" - ").first}\nTipo Sistema: ${prazoEntity.tipoSistema}\nPrazo Mínimo:${prazoEntity.prazoMinimo}\nPrazo total: ${prazoEntity.prazoTotal}\n";
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
            )
          ],
        ),
      ),
    );
  }
}
