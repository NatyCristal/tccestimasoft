import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/conteudo/conteudo_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstimativaEquipePage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ProjetoEntitie projetoEntitie;
  final StoreEstimativaEquipe storeEstimativaEquipe;
  final StoreEstimativaEsforco storeEstimativaEsforco;
  final StoreEstimativaPrazo storeEstimativaPrazo;
  final StoreContagemIndicativa storeContagemIndicativa;
  final StoreContagemEstimada storeContagemEstimada;
  final StoreContagemDetalhada storeContagemDetalhada;

  EstimativaEquipePage(
      {Key? key,
      required this.storeEstimativaPrazo,
      required this.storeEstimativaEsforco,
      required this.storeEstimativaEquipe,
      required this.projetoEntitie,
      required this.storeContagemIndicativa,
      required this.storeContagemEstimada,
      required this.storeContagemDetalhada})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    storeEstimativaEquipe
        .exibirEsforcos(controller.estimativasController.esforcos);
    storeEstimativaEquipe.exibirPrazps(controller.estimativasController.prazos);

    storeEstimativaEquipe.contagens = [
      "Detalhada - " +
          storeContagemDetalhada.contagemDetalhadaValida.totalPf.toString(),
      "Indicativa - " +
          storeContagemIndicativa.contagemIndicativaValida.totalPf.toString(),
      "Estimada - " +
          storeContagemEstimada.contagemEstimadaValida.totalPF.toString()
    ];

    return SizedBox(
      width: TamanhoTela.width(context, 1),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!storeEstimativaEquipe.isVisualizacao)
              const Text("Escolha a produção diária"),
            if (!storeEstimativaEquipe.isVisualizacao)
              const SizedBox(
                height: 20,
              ),
            if (!storeEstimativaEquipe.isVisualizacao)
              DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: storeEstimativaEquipe.menuItem,
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Produção Diária",
                ),
                selectedItem:
                    storeEstimativaEquipe.menuItem[6] + " (Recomendado)",
                popupItemDisabled: (String s) => s.contains(' 0 '),
                onChanged: (value) {
                  storeEstimativaEquipe.producaoDiaria = value.toString();
                  storeEstimativaEquipe.estimarEquipe();
                },
              ),
            if (!storeEstimativaEquipe.isVisualizacao)
              const SizedBox(
                height: 20,
              ),
            if (!storeEstimativaEquipe.isVisualizacao)
              const SizedBox(
                height: 15,
              ),
            if (!storeEstimativaEquipe.isVisualizacao)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(corDeFundoBotaoSecundaria),
                    ),
                    onPressed: () {
                      storeEstimativaEquipe.adicionarEquipe(context);
                    },
                    child: const Text("Adicionar")),
              ),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (context) {
              return storeEstimativaEquipe.tamanhoEquipe > 0
                  ? ConteudoEquipe(
                      scrollController: scrollController,
                      projetoEntitie: projetoEntitie,
                      equipe: storeEstimativaEquipe,
                    )
                  : const SizedBox();
            }),
            Observer(builder: (context) {
              return storeEstimativaEquipe.tamanhoEquipe > 0 &&
                      !storeEstimativaEquipe.isVisualizacao
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          storeEstimativaEquipe.equipes = <EquipeEntity>[];

                          storeEstimativaEquipe.tamanhoEquipe =
                              storeEstimativaEquipe.equipes.length;
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
              return storeEstimativaEquipe.alteracao
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
