import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/store/store_resultados.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/alerta_copiar_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardResultadoCustoCompartilhar extends StatelessWidget {
  final StoreProjetosIndexMenu storeIndex;
  final ProjetoEntitie projetoEntitie;
  final CustoEntity custoEntity;
  const CardResultadoCustoCompartilhar(
      {Key? key,
      required this.projetoEntitie,
      required this.custoEntity,
      required this.storeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    StoreResultados store = StoreResultados();
    store.compartilhada = custoEntity.compartilhada;
    return GestureDetector(
      onTap: () {
        custoEntity.compartilhada
            ? Alerta.alertaSimplesTextoOk(
                "", "Estimativa já compartilhada", context)
            : Alerta.alertaSimOuNao(context, store, () async {
                custoEntity.uidUsuario =
                    Modular.get<UsuarioAutenticado>().store.uid;

                await Modular.get<ProjetoController>()
                    .resultadoController
                    .enviarEstimativaCusto(
                        store.anonimo,
                        custoEntity,
                        projetoEntitie.uidProjeto,
                        Modular.get<UsuarioAutenticado>().store.uid);
                custoEntity.compartilhada = true;
                store.compartilhada = true;
                storeIndex.houveMudancaEmResultado = true;
              });
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: arredondamentoBordas,
          color: Colors.black.withOpacity(0.3),
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Center(
                child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Text(
                    "Estimativa Custo",
                  ),
                  Text(custoEntity.tipoContagem),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                String texto =
                    "Estimativa de Custo\nTipo Contagem: ${custoEntity.tipoContagem}\nCusto Total Mensal: ${custoEntity.custoTotalMensal}\nCusto Pf ${custoEntity.custoPF}\n\nProcentagem: ${custoEntity.porcentagemLucro}\n\nCusto total projeto: ${custoEntity.custoTotalProjeto}\nValor Total Projeto: ${custoEntity.valorTotalProjeto}";
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
