import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_expandable_funcao_dados.dart';
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
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount:
          contagemDetalhada.contagemDetalhadaEntitie.funcaoTransacional.length,
      itemBuilder: (context, index) {
        IndiceDetalhada indiceDetalhada = contagemDetalhada
            .contagemDetalhadaEntitie.funcaoTransacional[index];

        return CardAdicaoContagemExpanded(
          storeContagemDetalhada: contagemDetalhada,
          indiceDetalhadaModel: indiceDetalhada,
        );
      },
    );
  }
}
