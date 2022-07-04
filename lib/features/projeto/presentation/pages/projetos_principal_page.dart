import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/seach_bar_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/builders/projetos_conteudo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/builders/projetos_conteudo_pesquisa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/projeto_drawer.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProjetosPrincipalPage extends StatelessWidget {
  final StoreProjetos store = StoreProjetos();
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ScrollController scroll = ScrollController();
  ProjetosPrincipalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          store: store,
          tituloPagina: "EstimaSoft",
        ),
        //  AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   title: const Text("EstimaSoft"),
        //   shape: const Border(
        //     bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        //   ),
        // ),

        drawer: Drawer(
          child: ProjetoDrawer(),
        ),
        body: Container(
          padding: paddingPagePrincipal,
          height: TamanhoTela.height(context, 1),
          width: TamanhoTela.width(context, 1),
          child: Column(
            children: [
              Observer(builder: (context) {
                return !store.temPesquisa
                    ? Expanded(
                        child: ProjetosConteudo(store: store, scroll: scroll),
                      )
                    : Expanded(
                        child: ProjetosConteudoPesquisa(
                            projetosStore: store,
                            valorPesquisa: store.valorPesquisa,
                            scroll: scroll),
                      );
              })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: corDeFundoBotaoPrimaria,
          onPressed: () {
            Alert(
              closeFunction: () => {
                Navigator.of(context, rootNavigator: true).pop(),
                store.nomeProjetoErro = "",
              },
              context: context,
              title: "Dê um nome para o projeto",
              style: const AlertStyle(
                titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
              ),
              content: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Observer(builder: (context) {
                    return store.nomeProjetoErro == ""
                        ? TextField(
                            onChanged: (value) {
                              store.nomeProjeto = value.toString();
                              store.validarNomeProjeto();
                            },
                            decoration: const InputDecoration(
                              icon: Icon(Icons.account_tree_rounded),
                              labelText: 'Nome',
                            ),
                          )
                        : TextField(
                            onChanged: (value) {
                              store.nomeProjeto = value.toString();
                              store.validarNomeProjeto();
                            },
                            decoration: InputDecoration(
                              errorText: store.nomeProjetoErro,
                              icon: const Icon(Icons.account_tree_rounded),
                              labelText: 'Nome',
                            ),
                          );
                  }),
                ],
              ),
              buttons: [
                DialogButton(
                  color: corDeFundoBotaoSecundaria,
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                        fontWeight: Fontes.weightTextoNormal,
                        color: corDeTextoBotaoSecundaria,
                        fontSize: 14),
                  ),
                  onPressed: () async {
                    if (store.validarNomeProjeto()) {
                      var resultado =
                          await controller.criarProjeto(store.nomeProjeto);
                      Navigator.of(context, rootNavigator: true).pop();
                      AlertaSnack.exbirSnackBar(context, resultado);
                    }
                  },
                  width: 120,
                ),
                DialogButton(
                  color: Colors.indigo,
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      fontWeight: Fontes.weightTextoNormal,
                      color: corTextoSobCorPrimaria,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () => {
                    Navigator.of(context, rootNavigator: true).pop(),
                    store.nomeProjetoErro = "",
                  },
                  width: 120,
                )
              ],
            ).show();
          },
          child: const Icon(
            Icons.add,
            color: corTextoSobCorPrimaria,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        )

        // FloatingSearchBar(
        //   actions: [
        //     const Icon(Icons.search),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     GestureDetector(
        //         onTap: () {
        //           Alert(
        //             closeFunction: () => {
        //               Navigator.of(context, rootNavigator: true).pop(),
        //               store.erroCodEntrarProjeto = "",
        //             },
        //             context: context,
        //             title: "Digite o código do projeto que deseja entrar",
        //             style: const AlertStyle(
        //               titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
        //             ),
        //             content: Column(
        //               children: [
        //                 const SizedBox(
        //                   height: 20,
        //                 ),
        //                 Observer(builder: (context) {
        //                   return store.erroCodEntrarProjeto == ""
        //                       ? TextField(
        //                           onChanged: (value) {
        //                             store.codEntrarProjeto = value.toString();
        //                             store.validarCodProjeto();
        //                           },
        //                           decoration: const InputDecoration(
        //                             icon: Icon(Icons.account_tree_rounded),
        //                             labelText: 'Código Projeto',
        //                           ),
        //                         )
        //                       : TextField(
        //                           onChanged: (value) {
        //                             store.codEntrarProjeto = value.toString();
        //                             store.validarCodProjeto();
        //                           },
        //                           decoration: InputDecoration(
        //                             errorText: store.erroCodEntrarProjeto,
        //                             icon: const Icon(Icons.account_tree_rounded),
        //                             labelText: 'Código Projeto',
        //                           ),
        //                         );
        //                 }),
        //               ],
        //             ),
        //             buttons: [
        //               DialogButton(
        //                 color: corDeFundoBotaoSecundaria,
        //                 child: const Text(
        //                   "Entrar",
        //                   style: TextStyle(
        //                       fontWeight: Fontes.weightTextoNormal,
        //                       color: corDeTextoBotaoSecundaria,
        //                       fontSize: 14),
        //                 ),
        //                 onPressed: () async {
        //                   if (store.validarCodProjeto()) {
        //                     var resultado = await controller
        //                         .entrarProjetos(store.codEntrarProjeto);
        //                     Navigator.of(context, rootNavigator: true).pop();
        //                     AlertaSnack.exbirSnackBar(context, resultado);
        //                   }
        //                 },
        //                 width: 120,
        //               ),
        //               DialogButton(
        //                 color: Colors.indigo,
        //                 child: const Text(
        //                   "Cancelar",
        //                   style: TextStyle(
        //                     fontWeight: Fontes.weightTextoNormal,
        //                     color: corTextoSobCorPrimaria,
        //                     fontSize: 14,
        //                   ),
        //                 ),
        //                 onPressed: () => {
        //                   Navigator.of(context, rootNavigator: true).pop(),
        //                   store.nomeProjetoErro = "",
        //                 },
        //                 width: 120,
        //               )
        //             ],
        //           ).show();
        //         },
        //         child: const Icon(Icons.group_add_rounded))
        //   ],
        //   transitionCurve: Curves.linear,
        //   scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        //   isScrollControlled: false,
        //   backgroundColor: corDeFundoBotaoSecundaria,
        //   hint: "Pesquise....",
        //   title: const Text(
        //     "Pesquise em Projetos",
        //     style: TextStyle(color: corCorpoTexto),
        //   ),
        //   // onFocusChanged: (value) {},
        //   // onQueryChanged: (value) {
        //   //   store.pesquisa = value.toString();
        //   // },
        //   borderRadius: arredondamentoBordas,
        //   body: FloatingSearchBarScrollNotifier(
        //     child: SingleChildScrollView(
        //       controller: scroll,
        //       physics: const BouncingScrollPhysics(),
        //       child: Container(
        //         height: TamanhoTela.height(context, 1),
        //         padding: paddingPagePrincipal,
        //         child: Column(
        //           children: [
        //             const SizedBox(
        //               height: 30,
        //             ),
        //             Expanded(
        //               child: ProjetosConteudo(store: store, scroll: scroll),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        //   builder: (BuildContext context, Animation<double> transition) {
        //     return const SingleChildScrollView(
        //         child:
        //             SizedBox()); //ProjetosConteudoPesquisa(scroll: scroll, store: store));
        //   },
        // ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: corDeFundoBotaoPrimaria,
        //   onPressed: () {
        //     Alert(
        //       closeFunction: () => {
        //         Navigator.of(context, rootNavigator: true).pop(),
        //         store.nomeProjetoErro = "",
        //       },
        //       context: context,
        //       title: "Dê um nome para o projeto",
        //       style: const AlertStyle(
        //         titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
        //       ),
        //       content: Column(
        //         children: [
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           Observer(builder: (context) {
        //             return store.nomeProjetoErro == ""
        //                 ? TextField(
        //                     onChanged: (value) {
        //                       store.nomeProjeto = value.toString();
        //                       store.validarNomeProjeto();
        //                     },
        //                     decoration: const InputDecoration(
        //                       icon: Icon(Icons.account_tree_rounded),
        //                       labelText: 'Nome',
        //                     ),
        //                   )
        //                 : TextField(
        //                     onChanged: (value) {
        //                       store.nomeProjeto = value.toString();
        //                       store.validarNomeProjeto();
        //                     },
        //                     decoration: InputDecoration(
        //                       errorText: store.nomeProjetoErro,
        //                       icon: const Icon(Icons.account_tree_rounded),
        //                       labelText: 'Nome',
        //                     ),
        //                   );
        //           }),
        //         ],
        //       ),
        //       buttons: [
        //         DialogButton(
        //           color: corDeFundoBotaoSecundaria,
        //           child: const Text(
        //             "Salvar",
        //             style: TextStyle(
        //                 fontWeight: Fontes.weightTextoNormal,
        //                 color: corDeTextoBotaoSecundaria,
        //                 fontSize: 14),
        //           ),
        //           onPressed: () async {
        //             if (store.validarNomeProjeto()) {
        //               var resultado =
        //                   await controller.criarProjeto(store.nomeProjeto);
        //               Navigator.of(context, rootNavigator: true).pop();
        //               AlertaSnack.exbirSnackBar(context, resultado);
        //             }
        //           },
        //           width: 120,
        //         ),
        //         DialogButton(
        //           color: Colors.indigo,
        //           child: const Text(
        //             "Cancelar",
        //             style: TextStyle(
        //               fontWeight: Fontes.weightTextoNormal,
        //               color: corTextoSobCorPrimaria,
        //               fontSize: 14,
        //             ),
        //           ),
        //           onPressed: () => {
        //             Navigator.of(context, rootNavigator: true).pop(),
        //             store.nomeProjetoErro = "",
        //           },
        //           width: 120,
        //         )
        //       ],
        //     ).show();
        //   },
        //   child: const Icon(
        //     Icons.add,
        //     color: corTextoSobCorPrimaria,
        //   ),
        //   shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(15.0))),
        // ),
        );
  }
}
