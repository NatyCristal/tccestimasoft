import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'store/store_contagem_indicativa.dart';
import 'widgets/conteudo/conteudo_contagem_indicativa.dart';

class ContagemIndicativa extends StatelessWidget {
  final String projetoUid;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final StoreContagemIndicativa store;
  final ScrollController scrollController = ScrollController();
  ContagemIndicativa({Key? key, required this.projetoUid, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Observer(builder: (context) {
          return !store.carregou
              ? ConteudoContagemIndicativa(uidProjeto: projetoUid, store: store)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Observer(builder: (context) {
                      return TextField(
                        controller: store.nomeDaFuncaoController,
                        onChanged: (value) {
                          store.nomeDafuncao = value.toString();
                        },
                        decoration:
                            const InputDecoration(labelText: "Nome da função"),
                      );
                    }),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Observer(builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton(
                                hint: const Text("Espaço botao"),
                                value: store.tipoFuncao,
                                items: <String>[
                                  'ALI',
                                  'AIE',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? novoValor) {
                                  store.tipoFuncao = novoValor.toString();
                                }),
                            IconButton(
                              onPressed: () {
                                Alert(
                                  context: context,
                                  title: "Significado das siglas",
                                  style: const AlertStyle(
                                    titleStyle: TextStyle(
                                        color: corTituloTexto, fontSize: 18),
                                  ),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "ALI: Arquivo Lógico Interno",
                                        style: TextStyle(
                                            fontWeight: Fontes.weightTextoLeve,
                                            color: corCorpoTexto,
                                            fontSize: tamanhoSubtitulo),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "AIE: Arquivo de Interface externa",
                                        style: TextStyle(
                                            fontWeight: Fontes.weightTextoLeve,
                                            color: corCorpoTexto,
                                            fontSize: tamanhoSubtitulo),
                                      ),
                                    ],
                                  ),
                                  buttons: [
                                    DialogButton(
                                      color: corDeFundoBotaoSecundaria,
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(
                                            fontWeight:
                                                Fontes.weightTextoNormal,
                                            color: corDeTextoBotaoSecundaria,
                                            fontSize: 14),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      width: 120,
                                    ),
                                  ],
                                ).show();
                              },
                              icon: Icon(
                                Icons.info,
                                size: 20,
                                color: Colors.indigo.withOpacity(0.8),
                              ),
                            )
                          ],
                        );
                      }),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  corDeFundoBotaoSecundaria)),
                          onPressed: () {
                            if (store.tipoFuncao != "" &&
                                store.nomeDafuncao != "") {
                              store.adicionarFuncao(context);
                              store.nomeDafuncao = "";
                            }
                          },
                          child: const Text(
                            "Adicionar Função",
                            style: TextStyle(color: corDeTextoBotaoSecundaria),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Total  ",
                              style: TextStyle(
                                color: corTituloTexto,
                              ),
                            ),
                            Observer(builder: (context) {
                              return Text(
                                "${store.totalPf} PF",
                                style: const TextStyle(
                                  color: corTituloTexto,
                                ),
                              );
                            }),
                          ],
                        ),
                        Observer(builder: (context) {
                          return Text(
                              "Quantidade de funções  ${(store.tamanhoListaAIE + store.tamanhoListaALI).toString()}");
                        })
                      ],
                    ),
                    store.alteracoes
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Salve as alterações!",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: Fontes.weightTextoNormal,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: corDeAcao.withOpacity(0.3),
                      thickness: 0.5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Funções ALI",
                      style: TextStyle(color: corCorpoTexto),
                    ),
                    Observer(builder: (context) {
                      return store.tamanhoListaALI == 0
                          ? SizedBox(
                              height: 30,
                              child: Text(
                                "Não nenhum ALI cadastrado",
                                style: TextStyle(
                                    color: corCorpoTexto.withOpacity(0.5)),
                              ),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: store.alis.length,
                              itemBuilder: (context, index) {
                                String nomeFuncao = store.alis[index];
                                return CardContagemIndicativa(
                                  store: store,
                                  tipoFuncao: "ALI",
                                  nomeFuncao: nomeFuncao,
                                  pontosDeFuncao: 35,
                                );
                              },
                            );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Funções AIE",
                      style: TextStyle(color: corCorpoTexto),
                    ),
                    Observer(builder: (context) {
                      return store.tamanhoListaAIE == 0
                          ? SizedBox(
                              height: 30,
                              child: Text(
                                "Não nenhum AIE cadastrado",
                                style: TextStyle(
                                    color: corCorpoTexto.withOpacity(0.5)),
                              ),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: store.aies.length,
                              itemBuilder: (context, index) {
                                String nomeFuncao = store.aies[index];

                                return CardContagemIndicativa(
                                  store: store,
                                  tipoFuncao: "AIE",
                                  nomeFuncao: nomeFuncao,
                                  pontosDeFuncao: 15,
                                );
                              },
                            );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    BotaoPadrao(
                        corDeTextoBotao: corTextoSobCorPrimaria,
                        acao: () async {
                          var retorno = await controller.salvarContagem(
                            "Indicativa",
                            store.alis,
                            store.aies,
                            projetoUid,
                            store.totalPf,
                          );
                          store.alteracoes = false;
                          AlertaSnack.exbirSnackBar(context, retorno);
                        },
                        tituloBotao: "Salvar",
                        corBotao: corDeFundoBotaoPrimaria,
                        carregando: false),
                  ],
                );
        }),
      ),
    );
  }
}
