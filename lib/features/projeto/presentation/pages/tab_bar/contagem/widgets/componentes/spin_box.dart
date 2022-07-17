import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:flutter/material.dart';

class SpinBox extends StatelessWidget {
  final StoreContagemDetalhada storeContagemDetalhada;
  final IndiceDetalhada indiceDetalhada;
  final bool ehQuantidadeTd;
  final String nomeTipoFuncao;

  const SpinBox({
    Key? key,
    required this.nomeTipoFuncao,
    required this.ehQuantidadeTd,
    required this.indiceDetalhada,
    required this.storeContagemDetalhada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController valueController = TextEditingController();
    if (ehQuantidadeTd) {
      valueController.text = indiceDetalhada.quantidadeTDs.toString();
    } else {
      valueController.text = indiceDetalhada.quantidadeTrsEArs.toString();
    }

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            height: 40,
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 15,
                    onPressed: () {
                      valueController.text =
                          int.parse(valueController.text) - 1 >= 0
                              ? (int.parse(valueController.text) - 1).toString()
                              : valueController.text;

                      if (ehQuantidadeTd) {
                        indiceDetalhada.quantidadeTDs =
                            int.parse(valueController.text);
                        storeContagemDetalhada.adicionarQuantidade(
                            indiceDetalhada, nomeTipoFuncao);
                      } else {
                        indiceDetalhada.quantidadeTrsEArs =
                            int.parse(valueController.text);
                        storeContagemDetalhada.adicionarQuantidade(
                            indiceDetalhada, nomeTipoFuncao);
                      }
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: corDeAcao,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: TextField(
                    onChanged: (value) {
                      value.toString();

                      if (ehQuantidadeTd) {
                        indiceDetalhada.quantidadeTDs =
                            int.parse(value.toString());

                        storeContagemDetalhada.adicionarQuantidade(
                            indiceDetalhada, nomeTipoFuncao);
                      } else {
                        indiceDetalhada.quantidadeTrsEArs =
                            int.parse(value.toString());

                        storeContagemDetalhada.adicionarQuantidade(
                            indiceDetalhada, nomeTipoFuncao);
                      }
                    },
                    textAlign: TextAlign.center,
                    onTap: () {
                      valueController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: valueController.value.text.length);
                    },
                    controller: valueController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 2),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 15,
                    onPressed: () {
                      valueController.text =
                          (int.parse(valueController.text) + 1).toString();

                      if (ehQuantidadeTd) {
                        indiceDetalhada.quantidadeTDs =
                            int.parse(valueController.text);

                        storeContagemDetalhada.adicionarQuantidade(
                            indiceDetalhada, nomeTipoFuncao);
                      } else {
                        indiceDetalhada.quantidadeTrsEArs =
                            int.parse(valueController.text);

                        storeContagemDetalhada.adicionarQuantidade(
                            indiceDetalhada, nomeTipoFuncao);
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: corDeAcao,
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
