import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/home/widget/card_resultados_compartilhados.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/membros/lista_membros.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    return Observer(builder: (context) {
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

                      store.carregou = true;
                    }

                    break;
                  case ConnectionState.active:
                    return const Carregando();
                  case ConnectionState.none:
                    store.carregou = true;
                    return const Text("Erro nenhum");
                  case ConnectionState.waiting:
                    return const Carregando();
                }
                return const SizedBox();
              },
            )
          : Container(
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
                            controller.membrosProjetoAtual
                                .singleWhere((element) {
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
                      height: 20,
                    ),
                    const Text(
                      "Compartilhados",
                      style: TextStyle(
                        color: corCorpoTexto,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Observer(builder: (context) {
                      store.houveMudancaEmResultado;

                      return controller
                                  .resultadoController.contagensIndicativas.isEmpty &&
                              controller.resultadoController.custosCompartilhados
                                  .isEmpty &&
                              controller.resultadoController.equipesCompartilhados
                                  .isEmpty &&
                              controller.resultadoController
                                  .esforcosCompartilhados.isEmpty &&
                              controller.resultadoController
                                  .prazosCompartilhados.isEmpty
                          ? const Center(
                              child: SizedBox(
                                  child: Text(
                                      "Não tem Estimativas Compartilhadas")))
                          : const SizedBox();
                      // CardEsforcosCompartilhados(
                      //     uidProjeto: projeto.uidProjeto,
                      //     scrollController: scrollControllerLateral);
                    }),
                    const Text(
                      "Arquivos e Documentos",
                      style: TextStyle(
                        color: corCorpoTexto,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: background.withOpacity(0.5),
                          borderRadius: arredondamentoBordas),
                      height: 70,
                      width: TamanhoTela.width(context, 1),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            height: 30,
                            width: 30,
                            child: GestureDetector(
                              onTap: () {
                                Modular.to.pushNamed("inserir-arquivos",
                                    arguments: [projeto, store]);
                              },
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Observer(builder: (context) {
                            store.houveMudancaEmArquivosEdocumentos;

                            return SizedBox(
                                width: TamanhoTela.width(context, 0.8),
                                child: FutureBuilder<ListResult>(
                                  future: controller
                                      .recuperarArquivos(projeto.uidProjeto),
                                  builder: (BuildContext context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          return const Text("Erro");
                                        }
                                        if (snapshot.hasData) {
                                          final arquivosConcretos =
                                              snapshot.data!.items;
                                          return arquivosConcretos.isNotEmpty
                                              ? ListView.builder(
                                                  controller:
                                                      scrollControllerLateral,
                                                  shrinkWrap: false,
                                                  itemCount: controller
                                                      .arquivos.items.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final arquivo =
                                                        arquivosConcretos[
                                                            index];
                                                    return GestureDetector(
                                                      onTap: () => Modular.to
                                                          .pushNamed(
                                                              "inserir-arquivos",
                                                              arguments: [
                                                            projeto,
                                                            store
                                                          ]),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                            width: 80,
                                                            child: Icon(
                                                              Icons
                                                                  .drive_file_move,
                                                              size: 40,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: 60,
                                                                child: Text(
                                                                  arquivo
                                                                      .fullPath
                                                                      .split(
                                                                          "/")
                                                                      .last
                                                                      .split(
                                                                          ".")[0],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: (const TextStyle(
                                                                      fontSize:
                                                                          tamanhoTextoCorpoTexto,
                                                                      color:
                                                                          corCorpoTexto)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 40,
                                                                child: Text(
                                                                  "." +
                                                                      arquivo
                                                                          .fullPath
                                                                          .split(
                                                                              ".")[1],
                                                                  maxLines: 1,
                                                                  style: (const TextStyle(
                                                                      fontSize:
                                                                          tamanhoTextoCorpoTexto,
                                                                      color:
                                                                          corCorpoTexto)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    Modular.to.pushNamed(
                                                      "inserir-arquivos",
                                                      arguments: [
                                                        projeto,
                                                        store
                                                      ],
                                                    );
                                                  },
                                                  child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: const Text(
                                                          "Clique para adicionar arquivos",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  tamanhoTextoCorpoTexto,
                                                              color:
                                                                  corCorpoTexto))),
                                                );
                                        }

                                        break;
                                      case ConnectionState.active:
                                        return const SizedBox();
                                      case ConnectionState.none:
                                        return const Text("Erro nenhum");
                                      case ConnectionState.waiting:
                                        return const SizedBox(); // Carregando();
                                    }
                                    return const SizedBox();
                                  },
                                ));
                          })
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
