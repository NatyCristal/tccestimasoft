import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_contagem_detalhada.dart';
import 'package:flutter/widgets.dart';

class CardFuncaoTransacionalDetalhada extends StatelessWidget {
  final ScrollController scrollController;
  final StoreContagemEstimada storeEstimada;
  const CardFuncaoTransacionalDetalhada(
      {Key? key, required this.storeEstimada, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: SizedBox(
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
              itemCount: storeEstimada.tamanhoListaCE,
              itemBuilder: (context, index) {
                String nomeFuncao = storeEstimada.ce[index];

                return ContagemDetalhadaCard(
                  scrollController: scrollController,
                  tipoFuncao: "CE",
                  nomeDaFuncao: nomeFuncao,
                );
              },
            ),
            ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: storeEstimada.tamanhoListaEE,
              itemBuilder: (context, index) {
                String nomeFuncao = storeEstimada.ee[index];

                return ContagemDetalhadaCard(
                  scrollController: scrollController,
                  tipoFuncao: "EE",
                  nomeDaFuncao: nomeFuncao,
                );
              },
            ),
            ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: storeEstimada.tamanhoListaSE,
              itemBuilder: (context, index) {
                String nomeFuncao = storeEstimada.se[index];

                return ContagemDetalhadaCard(
                  scrollController: scrollController,
                  tipoFuncao: "SE",
                  nomeDaFuncao: nomeFuncao,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
