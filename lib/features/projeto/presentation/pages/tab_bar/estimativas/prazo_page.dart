import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/conteudo/conteudo_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstimativaPrazoPage extends StatelessWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ProjetoEntitie projetoEntitie;
  final ScrollController scrollController = ScrollController();
  final StoreEstimativaPrazo store;
  final StoreContagemIndicativa storeIndicativa;
  final StoreContagemEstimada storeEstimada;
  final StoreContagemDetalhada storeContagemDetalhada;

  EstimativaPrazoPage(
      {Key? key,
      required this.storeIndicativa,
      required this.storeEstimada,
      required this.storeContagemDetalhada,
      required this.store,
      required this.projetoEntitie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    store.contagens = [
      "Detalhada - " +
          storeContagemDetalhada.contagemDetalhadaValida.totalPf.toString(),
      "Indicativa - " +
          storeIndicativa.contagemIndicativaValida.totalPf.toString(),
      "Estimada - " + storeEstimada.contagemEstimadaValida.totalPF.toString()
    ];

    return SizedBox(
      width: TamanhoTela.width(context, 1),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!store.isVisualizacao) const Text("Informe o tipo de sistema"),
            if (!store.isVisualizacao)
              const SizedBox(
                height: 20,
              ),
            if (!store.isVisualizacao)
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
            if (!store.isVisualizacao)
              const SizedBox(
                height: 20,
              ),
            if (!store.isVisualizacao)
              const SizedBox(
                height: 20,
              ),
            if (!store.isVisualizacao)
              Observer(builder: (_) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              corDeFundoBotaoSecundaria)),
                      onPressed: () {
                        store.adicionarPrazo(context);
                      },
                      child: const Text("Adicionar")),
                );
              }),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (context) {
              store.tamanhoListaPrazo > 0;
              return ConteudoPrazo(
                scrollController: scrollController,
                projetoEntitie: projetoEntitie,
                storeEstimativaPrazo: store,
              );
            }),
            Observer(builder: (context) {
              return store.tamanhoListaPrazo > 0 && !store.isVisualizacao
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          store.prazos = <PrazoEntity>[];

                          store.tamanhoListaPrazo = store.prazos.length;
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text("Excluir"),
                      ),
                    )
                  : const SizedBox();
            }),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (context) {
              return store.alteracao
                  ? const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Clique em continuar!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: Fontes.weightTextoNormal),
                      ),
                    )
                  : const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
