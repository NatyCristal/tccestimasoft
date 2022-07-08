import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_expandable_funcao_dados.dart';
import 'package:flutter/material.dart';

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
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount:
          storeContagemDetalhada.contagemDetalhadaEntitie.funcaoDados.length,
      itemBuilder: (context, index) {
        IndiceDetalhada indiceDetalhada =
            storeContagemDetalhada.contagemDetalhadaEntitie.funcaoDados[index];

        return CardAdicaoContagemExpanded(
          indiceDetalhadaModel: indiceDetalhada,
          storeContagemDetalhada: storeContagemDetalhada,
        );
      },
    );
  }
}
