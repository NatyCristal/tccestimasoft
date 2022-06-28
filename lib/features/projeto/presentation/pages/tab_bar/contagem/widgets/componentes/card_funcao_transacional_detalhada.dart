import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_contagem_detalhada.dart';
import 'package:flutter/material.dart';

class CardFuncaoTransacionalDetalhada extends StatelessWidget {
  final StoreContagemDetalhada contagemDetalhada;
  final ScrollController scrollController;

  const CardFuncaoTransacionalDetalhada({
    Key? key,
    required this.scrollController,
    required this.contagemDetalhada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: arredondamentoBordas,
            color: Colors.yellow.withOpacity(0.2)),
        padding: const EdgeInsets.all(10),
        width: 650,
        child: Column(
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 120,
                  child: Text(
                    "Nome",
                    style: TextStyle(color: corTituloTexto),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    "Tipo",
                    style: TextStyle(color: corTituloTexto),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    "PF",
                    style: TextStyle(color: corTituloTexto),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    "Complexidade",
                    style: TextStyle(color: corTituloTexto),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    " Quantidade de AR's",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: corTituloTexto),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 130,
                  child: Text(
                    "Quantidade de TD's",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: corTituloTexto),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: contagemDetalhada
                  .contagemDetalhadaEntitie.funcaoTransacional.length,
              itemBuilder: (context, index) {
                IndiceDetalhada indiceDetalhada = contagemDetalhada
                    .contagemDetalhadaEntitie.funcaoTransacional[index];

                return ContagemDetalhadaCard(
                  store: contagemDetalhada,
                  indiceDetalhada: indiceDetalhada,
                );
              },
            ),
            // ListView.builder(
            //   controller: scrollController,
            //   shrinkWrap: true,
            //   itemCount: storeEstimada.tamanhoListaEE,
            //   itemBuilder: (context, index) {
            //     String nomeFuncao = storeEstimada.ee[index];

            //     return ContagemDetalhadaCard(
            //       store: contagemDetalhada,
            //       tipoFuncao: "EE",
            //       nomeDaFuncao: nomeFuncao,
            //     );
            //   },
            // ),
            // ListView.builder(
            //   controller: scrollController,
            //   shrinkWrap: true,
            //   itemCount: storeEstimada.tamanhoListaSE,
            //   itemBuilder: (context, index) {
            //     String nomeFuncao = storeEstimada.se[index];

            //     return ContagemDetalhadaCard(
            //       store: contagemDetalhada,
            //       tipoFuncao: "SE",
            //       nomeDaFuncao: nomeFuncao,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
