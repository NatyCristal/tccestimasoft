import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_adicao_contagem.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/conteudo/conteudo_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'store/store_contagem_indicativa.dart';

class ContagemIndicativa extends StatelessWidget {
  final String projetoUid;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final StoreContagemIndicativa store;
  final ScrollController scrollController = ScrollController();
  ContagemIndicativa({Key? key, required this.projetoUid, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!store.carregou) {
      store.iniciarSessao(controller.contagemController.contagemIndicativa);
      store.carregou = true;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                    Observer(builder: (context) {
                      return TextField(
                        controller: store.descricaoController,
                        onChanged: (value) {
                          store.descricao = value.toString();
                        },
                        decoration: const InputDecoration(
                            labelText: "Descrição da função"),
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
                                color: corDeAcao.withOpacity(0.7),
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
                              store.adicionarFuncao(context, store.tipoFuncao);
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
                                "Clique em continuar!",
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
                    SizedBox(
                      width: TamanhoTela.width(context, 1),
                      child: const Text(
                        "Função De Dados",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: tamanhoSubtitulo, color: corTituloTexto),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Funções - Arquivo Lógico Interno (ALI)",
                      style: TextStyle(
                        color: corCorpoTexto,
                      ),
                    ),
                    Observer(builder: (context) {
                      return store.tamanhoListaALI == 0
                          ? SizedBox(
                              height: 30,
                              child: Text(
                                "Não existe nenhuma função cadastrada",
                                style: TextStyle(
                                    color: corCorpoTexto.withOpacity(0.5)),
                              ),
                            )
                          : Observer(builder: (context) {
                              return ListView.builder(
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: store.tamanhoListaALI,
                                itemBuilder: (context, index) {
                                  String nomeFuncao =
                                      store.alis[index].nomeFuncao;

                                  String descricao =
                                      store.alis[index].descricao;
                                  return store.contagemIndicativaValida
                                              .totalPf >
                                          0
                                      ? CardAdicaoContagem(
                                          ehIndicativa: true,
                                          ehExibicao: true,
                                          descricao: descricao,
                                          editar: () {
                                            store.editar(
                                                nomeFuncao, "ALI", descricao);
                                          },
                                          remover: () {
                                            store.removerFuncao(
                                                nomeFuncao, "ALI");
                                          },
                                          tipoFuncao: "ALI",
                                          nomeFuncao: nomeFuncao,
                                          pontosDeFuncao: 35,
                                        )
                                      : CardAdicaoContagem(
                                          ehIndicativa: true,
                                          descricao: descricao,
                                          editar: () {
                                            store.editar(
                                                nomeFuncao, "ALI", descricao);
                                          },
                                          remover: () {
                                            store.removerFuncao(
                                                nomeFuncao, "ALI");
                                          },
                                          tipoFuncao: "ALI",
                                          nomeFuncao: nomeFuncao,
                                          pontosDeFuncao: 35,
                                        );
                                },
                              );
                            });
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Funções - Arquivo Interface Externa (AIE)",
                      style: TextStyle(color: corCorpoTexto),
                    ),
                    Observer(builder: (context) {
                      return store.tamanhoListaAIE == 0
                          ? SizedBox(
                              height: 30,
                              child: Text(
                                "Não existe nenhuma função cadastrada",
                                style: TextStyle(
                                    color: corCorpoTexto.withOpacity(0.5)),
                              ),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: store.tamanhoListaAIE,
                              itemBuilder: (context, index) {
                                String nomeFuncao =
                                    store.aies[index].nomeFuncao;
                                String descricao = store.aies[index].descricao;
                                return CardAdicaoContagem(
                                  ehIndicativa: true,
                                  descricao: descricao,
                                  editar: () {
                                    store.editar(nomeFuncao, "AIE", descricao);
                                  },
                                  remover: () {
                                    store.removerFuncao(nomeFuncao, "AIE");
                                  },
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
                  ],
                );
        }),
      ),
    );
  }
}
