import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GraficoHorizontal extends StatelessWidget {
  final StoreEstimativaEsforco store;
  const GraficoHorizontal({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: TamanhoTela.width(context, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Engenharia de Requisitos ",
                      style: TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
                Observer(builder: (context) {
                  return Text(
                    "${store.valorEngenhariaRequisitos.toString()} Hrs",
                    style: const TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  );
                }),
              ],
            ),
          ),
          const Divider(
            color: corDeLinhaAppBar,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: TamanhoTela.width(context, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Design e Arquitetura ",
                      style: TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
                Observer(builder: (context) {
                  return Text(
                    "${store.valorDesign.toString()} Hrs",
                    style: const TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  );
                }),
              ],
            ),
          ),
          const Divider(
            color: corDeLinhaAppBar,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: TamanhoTela.width(context, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Implementação",
                      style: TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
                Observer(builder: (context) {
                  return Text(
                    "${store.valorImplementacao.toString()} Hrs",
                    style: const TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  );
                }),
              ],
            ),
          ),
          const Divider(
            color: corDeLinhaAppBar,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: TamanhoTela.width(context, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Testes ",
                      style: TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
                Observer(builder: (context) {
                  return Text(
                    "${store.valorTestes.toStringAsFixed(2)} Hrs",
                    style: const TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  );
                }),
              ],
            ),
          ),
          const Divider(
            color: corDeLinhaAppBar,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: TamanhoTela.width(context, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Homologação",
                      style: TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
                Observer(builder: (context) {
                  return Text(
                    "${store.valorHomologacao.toString()} Hrs",
                    style: const TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  );
                }),
              ],
            ),
          ),
          const Divider(
            color: corDeLinhaAppBar,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            width: TamanhoTela.width(context, 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      "Implantação",
                      style: TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
                Observer(builder: (context) {
                  return Text(
                    "${store.valorImplantacao.toString()} Hrs",
                    style: const TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
