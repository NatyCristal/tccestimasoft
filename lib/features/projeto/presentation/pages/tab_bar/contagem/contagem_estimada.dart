import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/cards/card_adicao_contagem.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../../../core/shared/utils/tamanho_tela.dart';
import 'widgets/cards/exibicao_card_contagem_estimada.dart';
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
    return SingleChildScrollView(
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
          Observer(builder: (context) {
            return TextField(
              controller: store.descricaoController,
              onChanged: (value) {
                store.descricao = value.toString();
              },
              decoration:
                  const InputDecoration(labelText: "Descrição da função"),
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
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            width: 120,
                          ),
                        ],
                      ).show();
                    },
                    icon: Icon(
                      Icons.info,
                      size: 20,
                      color: corDeAcao.withOpacity(0.8),
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
            thickness: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: TamanhoTela.width(context, 1),
            child: const Text(
              "Função De Dados",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
            ),
          ),
          ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: storeIndicativa.contagemIndicativaValida.ali.length,
            itemBuilder: (context, index) {
              String nomeFuncao = storeIndicativa
                  .contagemIndicativaValida.ali[index].nomeFuncao;
              String descricao =
                  storeIndicativa.contagemIndicativaValida.ali[index].descricao;

              return ExibicaoCardEstimada(
                complexidade: "Baixa",
                descricao: descricao,
                nome: nomeFuncao,
                pontoDeFuncao: 7,
                tipo: "ALI",
              );
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: storeIndicativa.contagemIndicativaValida.aie.length,
            itemBuilder: (context, index) {
              String nomeFuncao = storeIndicativa
                  .contagemIndicativaValida.aie[index].nomeFuncao;
              String descricao =
                  storeIndicativa.contagemIndicativaValida.aie[index].descricao;

              return ExibicaoCardEstimada(
                complexidade: "Baixa",
                descricao: descricao,
                nome: nomeFuncao,
                pontoDeFuncao: 7,
                tipo: "AIE",
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: TamanhoTela.width(context, 1),
            child: const Text(
              "Função Transacional",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Funções - Entrada Externa (EE)",
            style: TextStyle(color: corCorpoTexto),
          ),
          Observer(builder: (context) {
            return store.tamanhoListaEE == 0
                ? SizedBox(
                    height: 30,
                    child: Text(
                      "Não existe nenhuma função cadastrada",
                      style: TextStyle(color: corCorpoTexto.withOpacity(0.5)),
                    ),
                  )
                : Observer(builder: (context) {
                    return ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: store.tamanhoListaEE,
                      itemBuilder: (context, index) {
                        String nomeFuncao = store.ee[index].nomeFuncao;
                        String descricao = store.ee[index].descricao;

                        return store.contagemEstimadaValida.totalPF > 0
                            ? CardAdicaoContagem(
                                ehExibicao: true,
                                descricao: descricao,
                                complexidade: "Média",
                                editar: () =>
                                    store.editar(nomeFuncao, "EE", descricao),
                                remover: () => store.removerFuncao(
                                  nomeFuncao,
                                  "EE",
                                ),
                                tipoFuncao: "EE",
                                nomeFuncao: nomeFuncao,
                                pontosDeFuncao: 4,
                              )
                            : CardAdicaoContagem(
                                descricao: descricao,
                                complexidade: "Média",
                                editar: () =>
                                    store.editar(nomeFuncao, "EE", descricao),
                                remover: () => store.removerFuncao(
                                  nomeFuncao,
                                  "EE",
                                ),
                                tipoFuncao: "EE",
                                nomeFuncao: nomeFuncao,
                                pontosDeFuncao: 4,
                              );
                      },
                    );
                  });
          }),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Funções - Consulta Externa (CE)",
            style: TextStyle(color: corCorpoTexto),
          ),
          Observer(builder: (context) {
            return store.tamanhoListaCE == 0
                ? SizedBox(
                    height: 30,
                    child: Text(
                      "Não existe nenhuma função cadastrada",
                      style: TextStyle(color: corCorpoTexto.withOpacity(0.5)),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: store.tamanhoListaCE,
                    itemBuilder: (context, index) {
                      String nomeFuncao = store.ce[index].nomeFuncao;
                      String descricao = store.ce[index].descricao;

                      return store.contagemEstimadaValida.totalPF > 0
                          ? CardAdicaoContagem(
                              ehExibicao: true,
                              descricao: descricao,
                              complexidade: "Média",
                              editar: () =>
                                  store.editar(nomeFuncao, "CE", descricao),
                              remover: () =>
                                  store.removerFuncao(nomeFuncao, "CE"),
                              tipoFuncao: "CE",
                              nomeFuncao: nomeFuncao,
                              pontosDeFuncao: 4,
                            )
                          : CardAdicaoContagem(
                              descricao: descricao,
                              complexidade: "Média",
                              editar: () =>
                                  store.editar(nomeFuncao, "CE", descricao),
                              remover: () =>
                                  store.removerFuncao(nomeFuncao, "CE"),
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
            "Funções - Saída Externa (SE)",
            style: TextStyle(color: corCorpoTexto),
          ),
          Observer(builder: (context) {
            return store.tamanhoListaSE == 0
                ? SizedBox(
                    height: 30,
                    child: Text(
                      "Não existe nenhuma função cadastrada",
                      style: TextStyle(color: corCorpoTexto.withOpacity(0.5)),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: store.tamanhoListaSE,
                    itemBuilder: (context, index) {
                      String nomeFuncao = store.se[index].nomeFuncao;
                      String descricao = store.se[index].descricao;

                      return store.contagemEstimadaValida.totalPF > 0
                          ? CardAdicaoContagem(
                              ehExibicao: true,
                              descricao: descricao,
                              complexidade: "Média",
                              editar: () =>
                                  store.editar(nomeFuncao, "SE", descricao),
                              remover: () =>
                                  store.removerFuncao(nomeFuncao, "SE"),
                              tipoFuncao: "SE",
                              nomeFuncao: nomeFuncao,
                              pontosDeFuncao: 5,
                            )
                          : CardAdicaoContagem(
                              descricao: descricao,
                              complexidade: "Média",
                              editar: () =>
                                  store.editar(nomeFuncao, "SE", descricao),
                              remover: () =>
                                  store.removerFuncao(nomeFuncao, "SE"),
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
        ],
      ),
    );
  }
}
