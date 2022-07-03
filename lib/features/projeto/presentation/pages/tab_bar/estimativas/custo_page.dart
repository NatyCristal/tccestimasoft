import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
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
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: TamanhoTela.height(context, 1),
        width: TamanhoTela.width(context, 1),
        padding: paddingPagePrincipal,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Observer(builder: (context) {
                return DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: [
                    "Indicativa - ${storeContagemIndicativa.contagemIndicativaValida.totalPf.toString()} PF",
                    "Estimada - ${storeContagemEstimada.contagemEstimadaValida.totalPF.toString()} PF",
                    "Detalhada - ${storeContagemDetalhada.contagemDetalhadaValida.totalPf.toString()} PF",
                  ],
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Contagem de ponto de função",
                  ),
                  popupItemDisabled: (String s) {
                    bool temIgual = false;

                    temIgual = s.contains(' 0 ');

                    for (var element in storeEstimativaCusto.custos) {
                      if (s.contains(element.tipoContagem)) {
                        temIgual = true;
                      }
                    }

                    return temIgual;
                  },
                  onChanged: (value) {
                    storeEstimativaCusto.quantidadePFSelecionada = int.parse(
                        value
                            .toString()
                            .split(" - ")
                            .last
                            .replaceAll(" PF", ""));

                    storeEstimativaCusto.tipoContagem = value.toString();
                  },
                );
              }),
              Observer(builder: (context) {
                return DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: storeEstimativaCusto.exibirEsforcos(
                      Modular.get<ProjetoController>()
                          .estimativasController
                          .esforcos),
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Esforço",
                  ),
                  popupItemDisabled: (String s) {
                    bool temIgual = false;

                    temIgual = s.contains(' 0 ');

                    for (var element in storeEstimativaCusto.custos) {
                      if (s.contains(element.tipoContagem)) {
                        temIgual = true;
                      }
                    }

                    return temIgual;
                  },
                  onChanged: (value) {
                    for (var element
                        in storeEstimativaEsforco.esforcosValidos) {
                      if (element.esforcoTotal ==
                          value.toString().split(" HH ").first) {
                        storeEstimativaCusto.esforcoEntitySelecionado = element;
                      }
                    }

                    double prazoFinal = 0;
                    for (var element in storeEstimativaPrazo.prazosValidos) {
                      if (element.contagemPontoDeFuncao
                          .split(" - ")
                          .first
                          .contains(storeEstimativaCusto.tipoContagem
                              .split(" - ")
                              .first)) {
                        prazoFinal = element.prazoTotal;
                      }
                    }
                    //FIXME: passar apropriadamente o przo

                    storeEstimativaCusto.prazo = prazoFinal / 30;
                  },
                  emptyBuilder: (context, searchEntry) => const Center(
                      child: Text('Cadastre um esforço para continuar.',
                          style: TextStyle(color: Colors.blue))),
                );
              }),
              Observer(builder: (context) {
                return DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: storeEstimativaCusto.exibirEquipe(
                    Modular.get<ProjetoController>()
                        .estimativasController
                        .equipe,
                  ),
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Equipe",
                  ),
                  popupItemDisabled: (String s) {
                    bool temIgual = false;

                    temIgual = s.contains(' 0 ');

                    for (var element in storeEstimativaCusto.custos) {
                      if (s.contains(element.tipoContagem)) {
                        temIgual = true;
                      }
                    }

                    return temIgual;
                  },
                  onChanged: (value) {
                    for (var element in storeEstimativaEquipe.equipesValidas) {
                      if (element.equipeEstimada ==
                          value.toString().split(" HH ").first) {
                        storeEstimativaCusto.equipeEntitySelecionado = element;

                        storeEstimativaCusto.calcularDisponibiliadeEquipe();
                      }
                    }
                  },
                  emptyBuilder: (context, searchEntry) => const Center(
                      child: Text('Cadastre uma equipe para continuar.',
                          style: TextStyle(color: Colors.blue))),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              CardMembros(
                storeEstimativaCusto: storeEstimativaCusto,
                scrollController: scrollController,
              ),
              CardCustosVariaveisFixos(
                  scroll: scrollController,
                  storeEstimativaCusto: storeEstimativaCusto),
              CardCustosGerais(storeEstimativaCusto: storeEstimativaCusto),
              CardCustosTotais(storeEstimativaCusto: storeEstimativaCusto),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(corDeFundoBotaoSecundaria),
                    ),
                    onPressed: () {
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
                          tipoContagem: storeEstimativaCusto.tipoContagem,
                          equipe: storeEstimativaCusto.equipe,
                          custosVariaisFixos:
                              storeEstimativaCusto.custosVariaveis,
                          disponibilidadeEquipe: storeEstimativaCusto
                              .disponibilidadeEquipe
                              .toStringAsFixed(2),
                          custoTotalMensal: storeEstimativaCusto
                              .custoTotalMensal
                              .toStringAsFixed(2),
                          custoHora: storeEstimativaCusto.custoHora,
                          porcentagemLucro:
                              storeEstimativaCusto.porcentagemLucro.toString(),
                          custoTotalProjeto: storeEstimativaCusto.custoProjeto,
                          valorTotalProjeto:
                              storeEstimativaCusto.valorTotalProjeto,
                          custoPF:
                              storeEstimativaCusto.custoPF.toStringAsFixed(2),
                        );
                        storeEstimativaCusto.adicionarNovoCusto(
                            novoCusto, context);
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
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (context) {
                return storeEstimativaCusto.alteracao
                    ? const Text(
                        "Salve as alterações!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: Fontes.weightTextoNormal),
                      )
                    : const SizedBox();
              }),
              Observer(builder: (context) {
                return BotaoPadrao(
                    corDeTextoBotao: corTextoSobCorPrimaria,
                    acao: () async {
                      if (storeEstimativaCusto.custos.isNotEmpty &&
                          storeEstimativaCusto.alteracao) {
                        storeEstimativaCusto.carregando = true;
                        for (var element in storeEstimativaCusto.custos) {
                          await Modular.get<ProjetoController>().salvarCusto(
                              element,
                              projetoEntitie.uidProjeto,
                              Modular.get<UsuarioAutenticado>().store.uid,
                              storeEstimativaCusto.tipoContagem
                                  .split(" - ")
                                  .first);
                        }
                        storeEstimativaCusto.custosValidos =
                            await Modular.get<ProjetoController>()
                                .estimativasController
                                .recuperarCusto(
                                    projetoEntitie.uidProjeto,
                                    Modular.get<UsuarioAutenticado>()
                                        .store
                                        .uid);
                        storeEstimativaCusto.carregando = false;
                        AlertaSnack.exbirSnackBar(
                            context, "Custo salvo com sucesso!");
                      } else {
                        AlertaSnack.exbirSnackBar(context,
                            "Não existem alterações para serem salvas!");
                      }
                    },
                    tituloBotao: "Salvar",
                    corBotao: corDeFundoBotaoPrimaria,
                    carregando: storeEstimativaCusto.carregando);
              })
            ],
          ),
        ),
      ),
    );
  }
}
