import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/componentes/spin_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CardAdicaoContagemExpanded extends StatelessWidget {
  final bool ehfuncaoTransacional;
  final IndiceDetalhada indiceDetalhadaModel;
  final StoreContagemDetalhada storeContagemDetalhada;

  const CardAdicaoContagemExpanded({
    Key? key,
    required this.indiceDetalhadaModel,
    required this.storeContagemDetalhada,
    this.ehfuncaoTransacional = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFBF7D4),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nome: ${indiceDetalhadaModel.nome}",
            ),
            Text(
              "Tipo: ${indiceDetalhadaModel.tipo}",
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Descrição: ${indiceDetalhadaModel.descricao}",
                ),
                Observer(builder: (context) {
                  storeContagemDetalhada.houveMudancaComplexidade;
                  return Text(
                      "Complexidade: ${indiceDetalhadaModel.complexidade}");
                }),
                Observer(builder: (context) {
                  storeContagemDetalhada.houveMudancaComplexidade;
                  return Text(
                      "Ponto de função: ${indiceDetalhadaModel.pontoDeFuncao}");
                }),
                Row(
                  children: [
                    Text(
                      ehfuncaoTransacional ? "Qtd. de ARs" : "Qtd. de TRs",
                    ),
                    SpinBox(
                        nomeTipoFuncao: indiceDetalhadaModel.tipo,
                        ehQuantidadeTd: false,
                        indiceDetalhada: indiceDetalhadaModel,
                        storeContagemDetalhada: storeContagemDetalhada),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Qtd. de TDs",
                    ),
                    SpinBox(
                        nomeTipoFuncao: indiceDetalhadaModel.tipo,
                        ehQuantidadeTd: true,
                        indiceDetalhada: indiceDetalhadaModel,
                        storeContagemDetalhada: storeContagemDetalhada),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
