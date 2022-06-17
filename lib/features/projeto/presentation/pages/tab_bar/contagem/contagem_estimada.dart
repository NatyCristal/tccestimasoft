import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_adicao_contagem.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_exibicao_contagem.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../../../core/shared/utils.dart';
import '../../../../../../core/shared/utils/snackbar.dart';
import '../../../../../../core/shared/utils/tamanho_tela.dart';
import 'widgets/conteudo/conteudo_contagem_estimada.dart';

class ContagemEstimada extends StatelessWidget {
  final StoreContagemIndicativa storeIndicativa;
  final String projetoUid;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final StoreContagemEstimada store;
  final ScrollController scrollController = ScrollController();
  ContagemEstimada(
      {Key? key,
      required this.projetoUid,
      required this.store,
      required this.storeIndicativa})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // store.totalIndicativa =
    //     storeIndicativa.contagemIndicativaValida.aie.length * 7 +
    //         storeIndicativa.contagemIndicativaValida.ali.length * 7;

    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConteudoContagemEstimada(
                storeContagemIndicativa: storeIndicativa,
                uidProjeto: projetoUid,
                store: store),
            Observer(builder: (context) {
              return TextField(
                controller: store.nomeDaFuncaoController,
                onChanged: (value) {
                  store.nomeDafuncao = value.toString();
                },
                decoration: const InputDecoration(labelText: "Nome da função"),
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
                        items: <String>['CE', 'EE', 'SE']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
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
                            titleStyle:
                                TextStyle(color: corTituloTexto, fontSize: 18),
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "EE: Entrada externa",
                                style: TextStyle(
                                    fontWeight: Fontes.weightTextoLeve,
                                    color: corCorpoTexto,
                                    fontSize: tamanhoSubtitulo),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "CE: Consulta externa",
                                style: TextStyle(
                                    fontWeight: Fontes.weightTextoLeve,
                                    color: corCorpoTexto,
                                    fontSize: tamanhoSubtitulo),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "SE: Saída externa",
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
                                    fontWeight: Fontes.weightTextoNormal,
                                    color: corDeTextoBotaoSecundaria,
                                    fontSize: 14),
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
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
                      backgroundColor:
                          MaterialStateProperty.all(corDeFundoBotaoSecundaria)),
                  onPressed: () {
                    if (store.tipoFuncao != "" && store.nomeDafuncao != "") {
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                      "${store.totalPf + storeIndicativa.contagemIndicativaValida.aie.length * 7 + storeIndicativa.contagemIndicativaValida.ali.length * 7} PF",
                      style: const TextStyle(
                        color: corTituloTexto,
                      ),
                    );
                  }),
                ],
              ),
              Observer(builder: (context) {
                return Text(
                    "Quantidade de funções  ${(store.tamanhoListaEE + store.tamanhoListaCE + store.tamanhoListaSE + storeIndicativa.tamanhoListaAIE + storeIndicativa.tamanhoListaALI).toString()}");
              }),
            ]),
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
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              child: Container(
                decoration: BoxDecoration(
                    color: storeIndicativa
                                .contagemIndicativaValida.aie.isEmpty &&
                            storeIndicativa.contagemIndicativaValida.ali.isEmpty
                        ? Colors.transparent
                        : Colors.yellow.withOpacity(0.2),
                    borderRadius: arredondamentoBordas),
                padding: EdgeInsets.symmetric(
                  horizontal: storeIndicativa.aies.isEmpty &&
                          storeIndicativa.alis.isEmpty
                      ? 0
                      : 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    storeIndicativa.contagemIndicativaValida.ali.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Funções ALI",
                                  style: TextStyle(color: corCorpoTexto)),
                              SizedBox(
                                height: 30,
                                child: Text(
                                  "Não nenhum ALI cadastrado",
                                  style: TextStyle(
                                      color: corCorpoTexto.withOpacity(0.5)),
                                ),
                              )
                            ],
                          )
                        : storeIndicativa
                                    .contagemIndicativaValida.aie.isNotEmpty ||
                                storeIndicativa
                                    .contagemIndicativaValida.ali.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: TamanhoTela.width(context, 0.9),
                                    child: const Text(
                                      "Função de Dados",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: const [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          "Nome",
                                          style: TextStyle(
                                            color: corCorpoTexto,
                                            fontWeight: Fontes.weightTextoLeve,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        child: Text(
                                          "Tipo",
                                          style: TextStyle(
                                            color: corCorpoTexto,
                                            fontWeight: Fontes.weightTextoLeve,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          "Complexidade",
                                          style: TextStyle(
                                            color: corCorpoTexto,
                                            fontWeight: Fontes.weightTextoLeve,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                        child: Text(
                                          "PF",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: corCorpoTexto,
                                            fontWeight: Fontes.weightTextoLeve,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: TamanhoTela.width(context, 1),
                                    child: const Divider(
                                      color: corDeLinhaAppBar,
                                      thickness: 1,
                                    ),
                                  ),
                                  CardExibicaoContagem(
                                    tipo: "ALI",
                                    tituloCard: "Funções ALI",
                                    storeIndicativa: storeIndicativa
                                        .contagemIndicativaValida.ali,
                                  )
                                ],
                              )
                            : const SizedBox(),
                    storeIndicativa.contagemIndicativaValida.aie.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Funções AIE",
                                  style: TextStyle(color: corCorpoTexto)),
                              SizedBox(
                                height: 30,
                                child: Text(
                                  "Não nenhum AIE cadastrado",
                                  style: TextStyle(
                                      color: corCorpoTexto.withOpacity(0.5)),
                                ),
                              )
                            ],
                          )
                        : CardExibicaoContagem(
                            tipo: "AIE",
                            tituloCard: "Funções AIE",
                            storeIndicativa:
                                storeIndicativa.contagemIndicativaValida.aie,
                          ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: TamanhoTela.width(context, 1),
              child: const Text(
                "Função Transacional",
                textAlign: TextAlign.center,
                style: TextStyle(color: corTituloTexto),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Funções EE",
              style: TextStyle(color: corCorpoTexto),
            ),
            Observer(builder: (context) {
              return store.tamanhoListaEE == 0
                  ? SizedBox(
                      height: 30,
                      child: Text(
                        "Não existe EE cadastrado",
                        style: TextStyle(color: corCorpoTexto.withOpacity(0.5)),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: store.tamanhoListaEE,
                      itemBuilder: (context, index) {
                        String nomeFuncao = store.ee[index];

                        return CardAdicaoContagem(
                          complexidade: "Média",
                          editar: () => store.editar(nomeFuncao, "EE"),
                          remover: () => store.removerFuncao(nomeFuncao, "EE"),
                          tipoFuncao: "EE",
                          nomeFuncao: nomeFuncao,
                          pontosDeFuncao: 4,
                        );
                      },
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Funções CE",
              style: TextStyle(color: corCorpoTexto),
            ),
            Observer(builder: (context) {
              return store.tamanhoListaCE == 0
                  ? SizedBox(
                      height: 30,
                      child: Text(
                        "Não existe CE cadastrado",
                        style: TextStyle(color: corCorpoTexto.withOpacity(0.5)),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: store.tamanhoListaCE,
                      itemBuilder: (context, index) {
                        String nomeFuncao = store.ce[index];

                        return CardAdicaoContagem(
                          complexidade: "Média",
                          editar: () => store.editar(nomeFuncao, "CE"),
                          remover: () => store.removerFuncao(nomeFuncao, "CE"),
                          tipoFuncao: "CE",
                          nomeFuncao: nomeFuncao,
                          pontosDeFuncao: 4,
                        );
                      },
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Funções SE",
              style: TextStyle(color: corCorpoTexto),
            ),
            Observer(builder: (context) {
              return store.tamanhoListaSE == 0
                  ? SizedBox(
                      height: 30,
                      child: Text(
                        "Não exite SE cadastrado",
                        style: TextStyle(color: corCorpoTexto.withOpacity(0.5)),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: store.tamanhoListaSE,
                      itemBuilder: (context, index) {
                        String nomeFuncao = store.se[index];

                        return CardAdicaoContagem(
                          complexidade: "Média",
                          editar: () => store.editar(nomeFuncao, "SE"),
                          remover: () => store.removerFuncao(nomeFuncao, "SE"),
                          tipoFuncao: "SE",
                          nomeFuncao: nomeFuncao,
                          pontosDeFuncao: 5,
                        );
                      },
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (context) {
              return BotaoPadrao(
                  corDeTextoBotao: corTextoSobCorPrimaria,
                  acao: () async {
                    if (store.alteracoes) {
                      store.carregouBotao = true;
                      var retorno = await controller.salvarContagem(
                        "Estimada",
                        [],
                        [],
                        store.ce,
                        store.ee,
                        store.se,
                        projetoUid,
                        store.totalPf,
                      );

                      store.salvar(
                          controller.contagemController.contagemEstimada);
                      store.alteracoes = false;
                      store.carregouBotao = false;
                      AlertaSnack.exbirSnackBar(context, retorno);
                    }
                  },
                  tituloBotao: "Salvar",
                  corBotao: corDeFundoBotaoPrimaria,
                  carregando: store.carregouBotao);
            }),
          ],
        ),
        //  }),
      ),
    );
  }
}
