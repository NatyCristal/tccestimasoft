import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutter_modular/flutter_modular.dart';

class IndexHome extends StatelessWidget {
  final StoreContagemIndicativa indicativa;
  final StoreContagemEstimada estimada;
  final StoreContagemDetalhada detalhada;

  final StoreEstimativaPrazo prazo;
  final StoreEstimativaEsforco esforco;
  final StoreEstimativaEquipe equipe;
  final StoreEstimativaCusto custo;

  final StoreProjetosIndexMenu store;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ProjetoEntitie projeto;
  final ScrollController scrollControllerLateral = ScrollController();
  IndexHome(
      {Key? key,
      required this.projeto,
      required this.store,
      required this.indicativa,
      required this.estimada,
      required this.detalhada,
      required this.prazo,
      required this.esforco,
      required this.equipe,
      required this.custo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    store.descricaoProjetoController.text = projeto.descricao;

    return !store.carregou
        ? FutureBuilder(
            future: controller.carregarTodosDados(projeto.uidProjeto,
                Modular.get<UsuarioAutenticado>().store.uid),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    store.carregou = true;
                    return const Text("Erro");
                  }
                  if (snapshot.hasData && !store.carregou) {
                    indicativa.iniciarSessao(
                        controller.contagemController.contagemIndicativa);
                    estimada.iniciarSessao(
                        controller.contagemController.contagemEstimada);
                    detalhada.iniciarSessao(
                        controller.contagemController.contagemDetalhada);
                    detalhada.receberDados(
                      estimada.contagemEstimadaValida,
                      indicativa.contagemIndicativaValida,
                    );

                    esforco.buscarListaEsforc(
                        controller.estimativasController.esforcos);
                    prazo.buscarListaPrazp(
                        controller.estimativasController.prazos);
                    equipe.buscarListaEquipe(
                        controller.estimativasController.equipe);
                    custo.buscarListaCusto(
                        controller.estimativasController.custos);

                    controller.resultadoController
                        .recuperarResultados(projeto.uidProjeto);
                    controller.recuperarArquivos(projeto.uidProjeto);

                    store.carregou = true;

                    if (snapshot.hasData) {
                      return newMethod(context);
                    }
                  }

                  break;
                case ConnectionState.active:
                  return const Carregando();
                case ConnectionState.none:
                  return const Text("Erro nenhum");
                case ConnectionState.waiting:
                  return const Carregando();
              }
              return const SizedBox();
            },
          )
        : newMethod(context);
  }

  Container newMethod(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      width: double.infinity,
      child: SingleChildScrollView(
        controller: scrollControllerLateral,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Projeto criado por:",
                  style: TextStyle(
                    color: corCorpoTexto,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    controller.membrosProjetoAtual.singleWhere((element) {
                      return element.uid == projeto.admin;
                    }).nome,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Data criação",
                  style: TextStyle(
                    color: corCorpoTexto,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    projeto.dataCriacao,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: corCorpoTexto,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("Descrição do projeto",
                style: TextStyle(
                    color: corTituloTexto,
                    fontWeight: Fontes.weightTextoNormal)),
            Modular.get<UsuarioAutenticado>().store.uid == projeto.admin
                ? Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          store.descricaoProjeto = value.toString();
                        },
                        controller: store.descricaoProjetoController,
                        maxLines: 8,
                        decoration: const InputDecoration.collapsed(
                            filled: true,
                            fillColor: corDeFundoBotaoSecundaria,
                            hintText: "Adicione uma descrição ao projeto."),
                      ),
                      Observer(builder: (context) {
                        return !store.carregandoSalvarDescri
                            ? TextButton.icon(
                                icon: Icon(
                                  Icons.save_outlined,
                                  color: corDeAcao.withOpacity(0.8),
                                ),
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        corDeFundoBotaoPrimaria)),
                                onPressed: () async {
                                  store.carregandoSalvarDescri = true;
                                  var resultado = await controller
                                      .adicionarDescricaoProjeto(
                                          projeto.uidProjeto,
                                          store.descricaoProjeto);

                                  projeto.descricao = store.descricaoProjeto;

                                  AlertaSnack.exbirSnackBar(context, resultado);
                                  store.carregandoSalvarDescri = false;
                                },
                                label: Text(
                                  "Salvar Descrição",
                                  style: TextStyle(
                                      color: corDeAcao.withOpacity(0.8),
                                      fontWeight: Fontes.weightTextoNormal),
                                ),
                              )
                            : TextButton.icon(
                                icon: Icon(
                                  Icons.save_outlined,
                                  color: corDeAcao.withOpacity(0.8),
                                ),
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        corDeFundoBotaoPrimaria)),
                                onPressed: () {},
                                label: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: corDeAcao.withOpacity(0.8),
                                  ),
                                ),
                              );
                      })
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: corDeFundoBotaoSecundaria,
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            projeto.descricao,
                            style: const TextStyle(
                              color: corTituloTexto,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Modular.to.pushNamed("visualizar-estimativas", arguments: [
                  projeto,
                ]);
              },
              child: const Text(
                "Visualizar Estimativas do projeto",
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(corTituloTexto)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Modular.to
                    .pushNamed("inserir-arquivos", arguments: [projeto, store]);
              },
              child: const Text(
                "Visualizar Arquivos do projeto",
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(corTituloTexto)),
            ),
            TextButton(
                onPressed: () {
                  Modular.to
                      .pushNamed("visualizar-membros", arguments: [projeto]);
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(corDeAcao)),
                child: const Text("Veja os membros do projeto")),
          ],
        ),
      ),
    );
  }
}
