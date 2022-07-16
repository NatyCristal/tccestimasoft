import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/conteudo/conteudo_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
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
  // final StoreStepperEstimativas stepperEstimativas;

  EstimativaEsforcoPage({
    Key? key,
    required this.storeIndicativa,
    required this.storeContagemDetalhada,
    required this.storeContagemEstimada,
    required this.storeEstimativaEsforco,
    required this.projetoEntitie,
    //  required this.stepperEstimativas,
  }) : super(key: key);

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

  TextEditingController textEditingController = TextEditingController();

  final controllerProdutividade = MaskedTextController(mask: "00");
  @override
  Widget build(BuildContext context) {
    widget.storeEstimativaEsforco.pontoFuncaoHora = buscaValorDaLinguagem(
        widget.storeEstimativaEsforco.linguagemSelecionada, dados);

    widget.storeEstimativaEsforco.contagens = [
      "Detalhada - " +
          widget.storeContagemDetalhada.contagemDetalhadaValida.totalPf
              .toString(),
      "Indicativa - " +
          widget.storeIndicativa.contagemIndicativaValida.totalPf.toString(),
      "Estimada - " +
          widget.storeContagemEstimada.contagemEstimadaValida.totalPF.toString()
    ];

    return SizedBox(
      width: TamanhoTela.width(context, 1),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.storeEstimativaEsforco.isVisualizacao)
                  const Text("Escolha as opções"),
                if (!widget.storeEstimativaEsforco.isVisualizacao)
                  const SizedBox(
                    height: 20,
                  ),
                if (!widget.storeEstimativaEsforco.isVisualizacao)
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
                              widget
                                  .storeEstimativaEsforco.linguagemSelecionada,
                              dados);
                      widget.storeEstimativaEsforco.validarContagem();
                    },
                    showSearchBox: true,
                  ),
                if (!widget.storeEstimativaEsforco.isVisualizacao)
                  const SizedBox(
                    height: 20,
                  ),
                if (!widget.storeEstimativaEsforco.isVisualizacao)
                  Observer(builder: (context) {
                    return !widget
                            .storeEstimativaEsforco.utilizarProdutividadePropria
                        ? DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItems: true,
                            items:
                                widget.storeEstimativaEsforco.pontoFuncaoHora,
                            dropdownSearchDecoration: const InputDecoration(
                              labelText: "Produtividade da Equipe",
                            ),
                            selectedItem: widget.storeEstimativaEsforco
                                    .pontoFuncaoHora.isNotEmpty
                                ? widget
                                    .storeEstimativaEsforco.pontoFuncaoHora[1]
                                : "",
                            onChanged: (value) {
                              widget.storeEstimativaEsforco
                                  .produtividadeEquipe = value.toString();
                              widget.storeEstimativaEsforco.validarContagem();
                            },
                          )
                        : const SizedBox();
                  }),
                if (!widget.storeEstimativaEsforco.isVisualizacao)
                  const SizedBox(
                    height: 20,
                  ),
              ],
            ),
            Observer(builder: (context) {
              widget.storeEstimativaEsforco.utilizarProdutividadePropria;
              return CheckboxListTile(
                  value: widget
                      .storeEstimativaEsforco.utilizarProdutividadePropria,
                  // subtitle: Observer(builder: (context) {
                  //   return widget.storeEstimativaEsforco
                  //               .utilizarProdutividadePropria &&
                  //           widget.storeEstimativaEsforco.produtividadeEquipe !=
                  //               ""
                  //       ? Text(
                  //           widget.storeEstimativaEsforco.produtividadeEquipe)
                  //       : const SizedBox();
                  // }),
                  title: const Text("Informar a própria produtividade equipe?"),
                  onChanged: (value) {
                    if (value == false) {
                      widget.storeEstimativaEsforco.produtividadeEquipe =
                          widget.storeEstimativaEsforco.pontoFuncaoHora[1];
                    }

                    widget.storeEstimativaEsforco.utilizarProdutividadePropria =
                        value as bool;
                  });
            }),
            Observer(builder: (context) {
              return widget.storeEstimativaEsforco.utilizarProdutividadePropria
                  ? Observer(builder: (context) {
                      return widget.storeEstimativaEsforco
                                  .erroProdutividadePropria ==
                              ""
                          ? TextField(
                              controller: controllerProdutividade,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: "Informe a produtividade",
                                  label: Text("Produtividade Equipe (HH)")),
                              onChanged: (value) {
                                widget.storeEstimativaEsforco
                                        .produtividadeEquipe =
                                    "Informado - " +
                                        (value == "" ? "0" : value);

                                widget.storeEstimativaEsforco
                                    .validarProdutividadeEquipe();
                              })
                          : TextField(
                              controller: controllerProdutividade,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  errorText: widget.storeEstimativaEsforco
                                      .erroProdutividadePropria,
                                  label: const Text(
                                      "Produtividade a Equipe (HH)")),
                              onChanged: (value) {
                                widget.storeEstimativaEsforco
                                        .produtividadeEquipe =
                                    "Informado - " +
                                        (value == "" ? "0" : value);

                                widget.storeEstimativaEsforco
                                    .validarProdutividadeEquipe();
                              });
                    })
                  : const SizedBox();
            }),
            SizedBox(
              child: !widget.storeEstimativaEsforco.isVisualizacao
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    corDeFundoBotaoSecundaria),
                              ),
                              onPressed: () {
                                widget.storeEstimativaEsforco
                                    .adicionarEsforco(context);
                              },
                              child: const Text("Adicionar")),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (context) {
              widget.storeEstimativaEsforco.tamanhoListaEsforco;

              return ConteudoEsforco(
                scrollController: widget.scroll,
                projetoEntitie: widget.projetoEntitie,
                storeEstimativaEsforco: widget.storeEstimativaEsforco,
              );
            }),
            Observer(builder: (context) {
              return widget.storeEstimativaEsforco.tamanhoListaEsforco > 0 &&
                      !widget.storeEstimativaEsforco.isVisualizacao
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          widget.storeEstimativaEsforco.esforcos =
                              <EsforcoEntity>[];

                          widget.storeEstimativaEsforco.tamanhoListaEsforco =
                              widget.storeEstimativaEsforco.esforcos.length;
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text("Excluir"),
                      ),
                    )
                  : const SizedBox();
            }),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Observer(builder: (context) {
                return widget.storeEstimativaEsforco.alteracores
                    ? const Text(
                        "Continue para salvar!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: Fontes.weightTextoNormal),
                      )
                    : const SizedBox();
              }),
            ),
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
