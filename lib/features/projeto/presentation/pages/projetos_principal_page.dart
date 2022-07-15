import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/seach_bar_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/builders/projetos_conteudo_pesquisa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/projeto_card.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/projeto_drawer.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../domain/entitie/projeto_entitie.dart';

class ProjetosPrincipalPage extends StatelessWidget {
  final StoreProjetos store;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ScrollController scroll = ScrollController();
  ProjetosPrincipalPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    store.carregandoEntrarProjetos = false;
    store.carregandoCriarPRojetos = false;
    return Scaffold(
      appBar: DefaultAppBar(
        notificacao: true,
        store: store,
        tituloPagina: "EstimaSoft",
      ),
      drawer: Drawer(
        child: ProjetoDrawer(
          storeProjetos: store,
        ),
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
                      child: Observer(builder: (context) {
                        return store.projetos.isEmpty
                            ? FutureBuilder(
                                future: controller.recuperarProjetos(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.done:
                                      store.exibirNotificacao = controller
                                          .notificacoesController
                                          .notificacao
                                          .notificacaoLida;
                                      if (snapshot.hasError) {
                                        return const Text("Erro");
                                      } else if (snapshot.hasData) {
                                        if (controller.projetos.isEmpty) {
                                          return SizedBox(
                                            height: TamanhoTela.height(
                                                context, 0.9),
                                            child: const Center(
                                                child: Text(
                                                    "Não possui nenhum projeto")),
                                          );
                                        } else {
                                          return ListView.builder(
                                            controller: scroll,
                                            shrinkWrap: false,
                                            itemCount:
                                                controller.projetos.length,
                                            itemBuilder: (context, index) {
                                              store.projetos.isEmpty
                                                  ? store.projetos.addAll(
                                                      controller.projetos)
                                                  : store.projetos;
                                              ProjetoEntitie projeto =
                                                  controller.projetos[index];

                                              return ProjetoCard(
                                                storeProjetos: store,
                                                projeto: projeto,
                                              );
                                            },
                                          );
                                        }
                                      }

                                      store.carregou = true;
                                      break;
                                    case ConnectionState.active:
                                      store.carregou = true;
                                      return const Carregando();
                                    case ConnectionState.none:
                                      store.carregou = true;
                                      return const Text("Erro");
                                    case ConnectionState.waiting:
                                      return const Carregando();
                                  }
                                  return const Text("Erro");
                                },
                              )
                            : ListView.builder(
                                controller: scroll,
                                shrinkWrap: false,
                                itemCount: controller.projetos.length,
                                itemBuilder: (context, index) {
                                  ProjetoEntitie projeto =
                                      controller.projetos[index];

                                  return ProjetoCard(
                                    storeProjetos: store,
                                    projeto: projeto,
                                  );
                                },
                              );
                      }),
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
      floatingActionButton: SpeedDial(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        icon: Icons.add,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: corDeAcao,
        children: [
          SpeedDialChild(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              label: "Entrar em um projeto",
              child: const Icon(Icons.group_add),
              onTap: () {
                Alert(
                  closeFunction: () => {
                    Navigator.of(context, rootNavigator: true).pop(),
                    store.erroCodEntrarProjeto = "",
                  },
                  context: context,
                  title: "Digite o código do projeto que deseja entrar",
                  style: const AlertStyle(
                    titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
                  ),
                  content: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Observer(builder: (context) {
                        return store.erroCodEntrarProjeto == ""
                            ? TextField(
                                onChanged: (value) {
                                  store.codEntrarProjeto = value.toString();
                                  store.validarCodProjeto();
                                },
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.account_tree_rounded),
                                  labelText: 'Código Projeto',
                                ),
                              )
                            : TextField(
                                onChanged: (value) {
                                  store.codEntrarProjeto = value.toString();
                                  store.validarCodProjeto();
                                },
                                decoration: InputDecoration(
                                  errorText: store.erroCodEntrarProjeto,
                                  icon: const Icon(Icons.account_tree_rounded),
                                  labelText: 'Código Projeto',
                                ),
                              );
                      }),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      color: corDeAcao.withOpacity(0.7),
                      child: Observer(builder: (context) {
                        return store.carregandoEntrarProjetos
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : const Text(
                                "Entrar",
                                style: TextStyle(
                                    fontWeight: Fontes.weightTextoNormal,
                                    color: corDeTextoBotaoSecundaria,
                                    fontSize: 14),
                              );
                      }),
                      onPressed: () async {
                        if (store.validarCodProjeto() &&
                            !store.carregandoEntrarProjetos) {
                          store.carregandoEntrarProjetos = true;
                          var resultado = await controller
                              .entrarProjetos(store.codEntrarProjeto);
                          Navigator.of(context, rootNavigator: true).pop();
                          AlertaSnack.exbirSnackBar(context, resultado);
                          store.carregandoEntrarProjetos = false;
                        }
                      },
                      width: 120,
                    ),
                    DialogButton(
                      color: corDeFundoBotaoSecundaria,
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(
                          fontWeight: Fontes.weightTextoNormal,
                          color: corTextoSobSecundaria,
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
              }),
          SpeedDialChild(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              label: "Criar novo projeto",
              child: const Icon(Icons.file_open_rounded),
              onTap: () {
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
                      color: corDeAcao.withOpacity(0.7),
                      child: Observer(builder: (context) {
                        return store.carregandoCriarPRojetos
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : const Text(
                                "Salvar",
                                style: TextStyle(
                                    fontWeight: Fontes.weightTextoNormal,
                                    color: corDeTextoBotaoSecundaria,
                                    fontSize: 14),
                              );
                      }),
                      onPressed: () async {
                        if (store.validarNomeProjeto() &&
                            !store.carregandoCriarPRojetos) {
                          store.carregandoCriarPRojetos = true;
                          var resultado =
                              await controller.criarProjeto(store.nomeProjeto);
                          Navigator.of(context, rootNavigator: true).pop();
                          AlertaSnack.exbirSnackBar(context, resultado);
                          store.exibirNotificacao = true;
                          store.carregandoCriarPRojetos = false;
                        }
                      },
                      width: 120,
                    ),
                    DialogButton(
                      color: corDeFundoBotaoSecundaria,
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(
                          fontWeight: Fontes.weightTextoNormal,
                          color: corDeTextoBotaoSecundaria,
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
              }),
        ],
      ),
    );
  }
}
