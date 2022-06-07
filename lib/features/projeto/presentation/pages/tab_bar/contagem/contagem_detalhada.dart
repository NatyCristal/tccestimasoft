import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/conteudo/conteudo_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../../../core/shared/utils.dart';
import '../../../../../../core/shared/utils/tamanho_tela.dart';

class ContagemDetalhada extends StatelessWidget {
  final StoreContagemIndicativa storeIndicativa;
  final String projetoUid;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final StoreContagemEstimada store;
  final ScrollController scrollController = ScrollController();
  ContagemDetalhada(
      {Key? key,
      required this.projetoUid,
      required this.store,
      required this.storeIndicativa})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    store.totalIndicativa = storeIndicativa.totalPf;

    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Observer(builder: (context) {
          return !store.carregou
              ? ConteudoContagemEstimada(uidProjeto: projetoUid, store: store)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
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
                                return const Text(
                                  "0 PF",
                                  style: TextStyle(
                                    color: corTituloTexto,
                                  ),
                                );
                              }),
                            ],
                          ),
                          Observer(builder: (context) {
                            return Text(
                                "Quantidade de funções  ${(store.tamanhoListaCE + store.tamanhoListaEE + store.tamanhoListaSE + storeIndicativa.tamanhoListaAIE + storeIndicativa.tamanhoListaALI).toString()}");
                          }),
                        ]),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Alert(
                            context: context,
                            title: "Significado das siglas",
                            style: const AlertStyle(
                              titleStyle: TextStyle(
                                  color: corTituloTexto, fontSize: 18),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "AR: Arquivos Referenciados.",
                                  style: TextStyle(
                                      fontWeight: Fontes.weightTextoLeve,
                                      color: corCorpoTexto,
                                      fontSize: tamanhoSubtitulo),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "TR: Tipo de registro",
                                  style: TextStyle(
                                      fontWeight: Fontes.weightTextoLeve,
                                      color: corCorpoTexto,
                                      fontSize: tamanhoSubtitulo),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "TD: Tipo de dado.",
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
                      ),
                    ),
                    //   store.alteracoes
                    // ?
                    //  Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: const [
                    //       SizedBox(
                    //         height: 20,
                    //       ),
                    //       Text(
                    //         "Salve as alterações!",
                    //         style: TextStyle(
                    //           color: Colors.red,
                    //           fontWeight: Fontes.weightTextoNormal,
                    //         ),
                    //       ),
                    //     ],
                    //   )
                    //const SizedBox(),

                    Divider(
                      color: corDeAcao.withOpacity(0.3),
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Column(
                      children: const [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Função de Dados",
                            textAlign: TextAlign.center,
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),

                    BotaoPadrao(
                        corDeTextoBotao: corTextoSobCorPrimaria,
                        acao: () async {
                          // var retorno = await controller.salvarContagem(
                          //   "Indicativa",
                          //   store.alis,
                          //   store.aies,
                          //   projetoUid,
                          //   store.totalPf,
                          // );
                          // store.alteracoes = false;
                          // AlertaSnack.exbirSnackBar(context, retorno);
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
