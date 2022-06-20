import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/conteudo/conteudo_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/grafico_horizontal.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstimativaEsforcoPage extends StatefulWidget {
  final ProjetoEntitie projetoEntitie;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ScrollController scroll = ScrollController();
  final StoreContagemIndicativa storeIndicativa;
  final StoreContagemDetalhada storeContagemDetalhada;
  final StoreContagemEstimada storeContagemEstimada;
  final StoreEstimativaEsforco storeEstimativaEsforco;

  EstimativaEsforcoPage(
      {Key? key,
      required this.storeIndicativa,
      required this.storeContagemDetalhada,
      required this.storeContagemEstimada,
      required this.storeEstimativaEsforco,
      required this.projetoEntitie})
      : super(key: key);

  @override
  State<EstimativaEsforcoPage> createState() => _EstimativaEsforcoPageState();
}

class _EstimativaEsforcoPageState extends State<EstimativaEsforcoPage> {
  Map<String, dynamic> dados = <String, dynamic>{};

  Future<String> carregarDados() async {
    var textoJson = await rootBundle.loadString('assets/arquivos/indices.json');

    setState(() => dados = json.decode(textoJson));

    return 'sucesso';
  }

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.storeEstimativaEsforco.pontoFuncaoHora = buscaValorDaLinguagem(
        widget.storeEstimativaEsforco.linguagemSelecionada, dados);
    return Container(
      padding: paddingPagePrincipal,
      width: TamanhoTela.width(context, 1),
      height: TamanhoTela.height(context, 1),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Observer(builder: (context) {
                  return DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: [
                      "Indicativa - ${widget.storeIndicativa.contagemIndicativaValida.totalPf.toString()} PF",
                      "Estimada - ${widget.storeContagemEstimada.contagemEstimadaValida.totalPF.toString()} PF",
                      "Detalhada - ${widget.storeContagemDetalhada.totalPf.toString()} PF",
                    ],
                    dropdownSearchDecoration: const InputDecoration(
                      labelText: "Contagem de ponto de função",
                    ),
                    popupItemDisabled: (String s) {
                      bool temIgual = false;

                      temIgual = s.contains(' 0 ');

                      for (var element
                          in widget.storeEstimativaEsforco.esforcos) {
                        if (s.contains(element.contagemPontoDeFuncao)) {
                          temIgual = true;
                        }
                      }

                      return temIgual;
                    },
                    onChanged: (value) {
                      widget.storeEstimativaEsforco.contagemPF =
                          value.toString();
                      widget.storeEstimativaEsforco.validarContagem();
                    },
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: exibeDados(dados),
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Linguagem",
                  ),
                  emptyBuilder: (context, searchEntry) => const Center(
                      child: Text('Não encontrado',
                          style: TextStyle(color: Colors.blue))),
                  selectedItem: "ACCESS",
                  onChanged: (value) {
                    widget.storeEstimativaEsforco.linguagemSelecionada =
                        value.toString();
                    widget.storeEstimativaEsforco.pontoFuncaoHora =
                        buscaValorDaLinguagem(
                            widget.storeEstimativaEsforco.linguagemSelecionada,
                            dados);
                  },
                  showSearchBox: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Observer(builder: (context) {
                  return DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: widget.storeEstimativaEsforco.pontoFuncaoHora,
                    dropdownSearchDecoration: const InputDecoration(
                      labelText: "Produtividade da Equipe",
                    ),
                    selectedItem:
                        widget.storeEstimativaEsforco.pontoFuncaoHora.isNotEmpty
                            ? widget.storeEstimativaEsforco.pontoFuncaoHora[1]
                            : "",
                    onChanged: (value) {
                      widget.storeEstimativaEsforco.produtividadeEquipe =
                          value.toString();
                    },
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Distribuição De Esforço",
                  style: TextStyle(
                      fontWeight: Fontes.weightTextoNormal,
                      fontSize: tamanhoSubtitulo),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: arredondamentoBordas),
                  child:
                      GraficoHorizontal(store: widget.storeEstimativaEsforco),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Esforço total: ${widget.storeEstimativaEsforco.valorTotalEsforco.toString()} Horas",
                        style: const TextStyle(
                            color: corTituloTexto,
                            fontSize: tamanhoSubtitulo,
                            fontWeight: Fontes.weightTextoNormal),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                corDeFundoBotaoSecundaria),
                          ),
                          onPressed: () {
                            widget.storeEstimativaEsforco
                                .adicionarEsforco(context);
                          },
                          child: const Text("Adicionar")),
                    ],
                  );
                }),
                Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Estimativas já realizadas",
                    style: TextStyle(color: corCorpoTexto),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Observer(builder: (context) {
                    return widget.storeEstimativaEsforco.tamanhoListaEsforco > 0
                        ? ConteudoEsforco(
                            scrollController: widget.scroll,
                            projetoEntitie: widget.projetoEntitie,
                            storeEstimativaEsforco:
                                widget.storeEstimativaEsforco,
                          )
                        : const SizedBox();
                  }),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Observer(builder: (context) {
                  return widget.storeEstimativaEsforco.alteracores
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
                      corDeTextoBotao: corDeTextoBotaoPrimaria,
                      acao: () async {
                        if (widget.storeEstimativaEsforco.esforcos.isNotEmpty) {
                          widget.storeEstimativaEsforco.carregando = true;

                          for (var element
                              in widget.storeEstimativaEsforco.esforcos) {
                            await widget.controller.salvarEsforco(
                                element,
                                widget.projetoEntitie.uidProjeto,
                                Modular.get<UsuarioAutenticado>().store.uid,
                                element.contagemPontoDeFuncao
                                    .split(" - ")
                                    .first);
                          }
                          widget.storeEstimativaEsforco.esforcosValidos =
                              widget.controller.estimativasController.esforcos;
                          widget.storeEstimativaEsforco.alteracores = false;
                          widget.storeEstimativaEsforco.carregando = false;
                          AlertaSnack.exbirSnackBar(context, "Esforço salvo!");
                        } else {
                          AlertaSnack.exbirSnackBar(context,
                              "Adicione uma estimativa de esforço para salvar.");
                        }
                      },
                      tituloBotao: "Salvar",
                      corBotao: corDeFundoBotaoPrimaria,
                      carregando: widget.storeEstimativaEsforco.carregando);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<String> buscaValorDaLinguagem(
    String linguagem, Map<String, dynamic> dados) {
  List<String> valores = [];
  dados.forEach((key, value) {
    if (key.toString().toUpperCase() == linguagem.toString().toUpperCase()) {
      Map<String, dynamic> teste = value;

      teste.forEach((key, value) {
        valores.add(key.toString().toUpperCase() + " - " + value);
      });
    }
  });
  return valores;
}

List<String> exibeDados(Map<String, dynamic> dados) {
  List<String> retornoDados = [];

  dados.forEach((key, value) {
    retornoDados.add(key.toString().toUpperCase());
  });

  return retornoDados;
}
