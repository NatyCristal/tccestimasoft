import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:flutter/material.dart';

import '../cards/card_contagem_detalhada.dart';

class FuncaoDeDadosDetalhada extends StatelessWidget {
  final ScrollController scrollController;
  final StoreContagemDetalhada storeContagemDetalhada;
  const FuncaoDeDadosDetalhada(
      {Key? key,
      required this.scrollController,
      required this.storeContagemDetalhada})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: arredondamentoBordas,
            color: Colors.yellow.withOpacity(0.2)),
        width: TamanhoTela.width(context, 1.3),
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
                  width: 130,
                  child: Text(
                    " Quantidade de TR's",
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
              itemCount: storeContagemDetalhada
                  .contagemDetalhadaEntitie.funcaoDados.length,
              itemBuilder: (context, index) {
                IndiceDetalhada indiceDetalhada = storeContagemDetalhada
                    .contagemDetalhadaEntitie.funcaoDados[index];

                return ContagemDetalhadaCard(
                  store: storeContagemDetalhada,
                  indiceDetalhada: indiceDetalhada,
                );
              },
            ),
            // ListView.builder(
            //   controller: scrollController,
            //   shrinkWrap: true,
            //   itemCount:
            //       storeContagemIndicativa.contagemIndicativaValida.aie.length,
            //   itemBuilder: (context, index) {
            //     String nomeFuncao =
            //         storeContagemIndicativa.contagemIndicativaValida.aie[index];

            //     return ContagemDetalhadaCard(
            //       store: storeContagemDetalhada,
            //       tipoFuncao: "AIE",
            //       nomeDaFuncao: nomeFuncao,
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
