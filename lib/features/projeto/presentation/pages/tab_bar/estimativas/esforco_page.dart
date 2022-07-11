import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/conteudo/conteudo_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
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
                    return DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: widget.storeEstimativaEsforco.pontoFuncaoHora,
                      dropdownSearchDecoration: const InputDecoration(
                        labelText: "Produtividade da Equipe",
                      ),
                      selectedItem: widget
                              .storeEstimativaEsforco.pontoFuncaoHora.isNotEmpty
                          ? widget.storeEstimativaEsforco.pontoFuncaoHora[1]
                          : "",
                      onChanged: (value) {
                        widget.storeEstimativaEsforco.produtividadeEquipe =
                            value.toString();
                        widget.storeEstimativaEsforco.validarContagem();
                      },
                    );
                  }),
                if (!widget.storeEstimativaEsforco.isVisualizacao)
                  const SizedBox(
                    height: 20,
                  ),
                // const Text(
                //   "Distribuição De Esforço",
                //   style: TextStyle(
                //       fontWeight: Fontes.weightTextoNormal,
                //       fontSize: tamanhoSubtitulo),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   decoration: BoxDecoration(
                //       color: Colors.blue.withOpacity(0.2),
                //       borderRadius: arredondamentoBordas),
                //   child:
                //       GraficoHorizontal(store: widget.storeEstimativaEsforco),
                // )
              ],
            ),
            Observer(
              builder: (_) {
                if (!widget.storeEstimativaEsforco.isVisualizacao) {
                  return Column(
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
                  );
                } else {
                  return const SizedBox();
                }
              },
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
