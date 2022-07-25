import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/conteudo/conteudo_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/custo/card_custos_gerais.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/custo/card_custos_totais.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/custo/card_custos_variaveis.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/custo/card_membros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EstimativaCustoPage extends StatelessWidget {
  final ProjetoEntitie projetoEntitie;
  final StoreContagemIndicativa storeContagemIndicativa;
  final StoreContagemEstimada storeContagemEstimada;
  final StoreContagemDetalhada storeContagemDetalhada;
  final ScrollController scrollController = ScrollController();
  final StoreEstimativaCusto storeEstimativaCusto;
  final StoreEstimativaEquipe storeEstimativaEquipe;
  final StoreEstimativaEsforco storeEstimativaEsforco;
  final StoreEstimativaPrazo storeEstimativaPrazo;
  EstimativaCustoPage(
      {Key? key,
      required this.storeEstimativaCusto,
      required this.storeEstimativaEquipe,
      required this.storeContagemIndicativa,
      required this.storeContagemEstimada,
      required this.storeContagemDetalhada,
      required this.storeEstimativaEsforco,
      required this.projetoEntitie,
      required this.storeEstimativaPrazo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    storeEstimativaCusto.contagens = [
      "Detalhada - " +
          storeContagemDetalhada.contagemDetalhadaValida.totalPf.toString(),
      "Indicativa - " +
          storeContagemIndicativa.contagemIndicativaValida.totalPf.toString(),
      "Estimada - " +
          storeContagemEstimada.contagemEstimadaValida.totalPF.toString()
    ];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox(
        width: TamanhoTela.width(context, 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!storeEstimativaCusto.isVisualizacao)
                CardMembros(
                  storeEstimativaCusto: storeEstimativaCusto,
                  scrollController: scrollController,
                ),
              if (!storeEstimativaCusto.isVisualizacao)
                CardCustosVariaveisFixos(
                    scroll: scrollController,
                    storeEstimativaCusto: storeEstimativaCusto),
              if (!storeEstimativaCusto.isVisualizacao)
                CardCustosGerais(storeEstimativaCusto: storeEstimativaCusto),
              if (!storeEstimativaCusto.isVisualizacao)
                CardCustosTotais(storeEstimativaCusto: storeEstimativaCusto),
              if (!storeEstimativaCusto.isVisualizacao)
                const SizedBox(
                  height: 20,
                ),
              if (!storeEstimativaCusto.isVisualizacao)
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            corDeFundoBotaoSecundaria),
                      ),
                      onPressed: () {
                        for (var cont in storeEstimativaCusto.contagens) {
                          storeEstimativaCusto.tipoContagem = cont;
                          storeEstimativaCusto.esforcoEntitySelecionado =
                              storeEstimativaEsforco.esforcosValidos
                                  .singleWhere((element) => element
                                      .contagemPontoDeFuncao
                                      .contains(cont.split(" - ").first));
                          storeEstimativaCusto.prazo = storeEstimativaPrazo
                              .prazosValidos
                              .singleWhere((element) => element
                                  .contagemPontoDeFuncao
                                  .contains(cont.split(" - ").first))
                              .prazoTotal;

                          storeEstimativaCusto.equipeEntitySelecionado =
                              storeEstimativaEquipe.equipesValidas.singleWhere(
                                  (element) => element.contagemPontoDeFuncao
                                      .contains(cont.split(" - ").first));
                          storeEstimativaCusto.quantidadePFSelecionada =
                              int.parse(cont.split(" - ").last);

                          storeEstimativaCusto.calcularCustoHora();
                          storeEstimativaCusto.validarValorTotalProjeto();
                          if (storeEstimativaCusto
                              .validarCamposPreenchidos(context)) {
                            CustoEntity novoCusto = CustoEntity(
                              valorPorcentagem:
                                  storeEstimativaCusto.valorPorcentagem,
                              despesasTotaisDurantePrazoProjeto:
                                  storeEstimativaCusto
                                      .despesasTotaisDurantePrazoProjeto,
                              custoBasico: storeEstimativaCusto.custoBasico,
                              compartilhada: false,
                              tipoContagem: cont,
                              equipe: storeEstimativaCusto.equipe,
                              custosVariaisFixos:
                                  storeEstimativaCusto.custosVariaveis,
                              custoTotalMensal: storeEstimativaCusto
                                  .custoTotalMensal
                                  .toStringAsFixed(2),
                              porcentagemLucro: storeEstimativaCusto
                                  .porcentagemLucro
                                  .toString(),
                              custoTotalProjeto:
                                  storeEstimativaCusto.custoProjeto,
                              valorTotalProjeto:
                                  storeEstimativaCusto.valorTotalProjeto,
                              custoPF: storeEstimativaCusto.custoPF
                                  .toStringAsFixed(2),
                            );
                            storeEstimativaCusto.adicionarNovoCusto(
                                novoCusto, context);
                          }
                        }
                      },
                      child: const Text("Adicionar")),
                ),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (context) {
                storeEstimativaCusto.tamanhoListaCustos > 0;
                return ConteudoCusto(
                  custo: storeEstimativaCusto,
                  scrollController: scrollController,
                  projetoEntitie: projetoEntitie,
                );
              }),
              Observer(builder: (context) {
                return storeEstimativaCusto.tamanhoListaCustos > 0 &&
                        !storeEstimativaCusto.isVisualizacao
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {
                            storeEstimativaCusto.custos = <CustoEntity>[];

                            storeEstimativaCusto.tamanhoListaCustos =
                                storeEstimativaCusto.custos.length;
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
                return storeEstimativaCusto.alteracao
                    ? const Text(
                        "Clique em continuar!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: Fontes.weightTextoNormal),
                      )
                    : const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
