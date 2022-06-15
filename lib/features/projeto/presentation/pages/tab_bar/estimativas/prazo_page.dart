import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EstimativaPrazo extends StatelessWidget {
  final StoreEstimativaPrazo store;
  final StoreContagemIndicativa storeIndicativa;
  final StoreContagemEstimada storeEstimada;
  final StoreContagemDetalhada storeContagemDetalhada;

  const EstimativaPrazo(
      {Key? key,
      required this.storeIndicativa,
      required this.storeEstimada,
      required this.storeContagemDetalhada,
      required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      width: TamanhoTela.width(context, 1),
      child: Column(
        children: [
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: [
              "Indicativa - ${storeIndicativa.totalPf.toString()} PF",
              "Estimada - ${storeEstimada.totalPf.toString()} PF",
              "Detalhada - ${storeContagemDetalhada.totalPf.toString()} PF",
            ],
            dropdownSearchDecoration: const InputDecoration(
              labelText: "Contagem de ponto de função",
            ),
            //    popupItemDisabled: (String s) => s.contains(' 0 '),
            onChanged: (value) {
              store.contagemPF = value.toString();
              store.validarContagem();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItems: true,
            items: store.tipoSistema,
            dropdownSearchDecoration: const InputDecoration(
              labelText: "Tipo de sistema",
            ),
            selectedItem: store.tipoSistema[0],
            onChanged: (value) {
              store.tipoSistemaSelecionado = value.toString();
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Observer(builder: (context) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: arredondamentoBordas,
                color: Colors.blue.withOpacity(0.2),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Prazo Total",
                        style: TextStyle(
                            color: corCorpoTexto,
                            fontWeight: Fontes.weightTextoNormal),
                      ),
                      Text(store.prazoTotal.toString(),
                          style: const TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Prazo mínimo (região do impossível)",
                        style: TextStyle(
                            color: corCorpoTexto,
                            fontWeight: Fontes.weightTextoNormal),
                      ),
                      Text(store.regiaoDoImpossivel.toString(),
                          style: const TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal)),
                    ],
                  ),
                ],
              ),
            );
          }),
          const SizedBox(
            height: 30,
          ),
          Observer(builder: (context) {
            return BotaoPadrao(
                corDeTextoBotao: corDeTextoBotaoPrimaria,
                acao: () {},
                tituloBotao: "Salvar",
                corBotao: corDeFundoBotaoPrimaria,
                carregando: store.carregando);
          }),
        ],
      ),
    );
  }
}
