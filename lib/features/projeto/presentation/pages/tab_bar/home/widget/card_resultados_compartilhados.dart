import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/home/widget/componente_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardEsforcosCompartilhados extends StatelessWidget {
  final ScrollController scrollController;
  final String uidProjeto;
  final ProjetoController controller = Modular.get<ProjetoController>();
  CardEsforcosCompartilhados({
    Key? key,
    required this.uidProjeto,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: arredondamentoBordas,
      ),
      width: TamanhoTela.width(context, 1),
      child: Column(
        children: [
          controller.resultadoController.contagens.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed("visualizar-estimativa", arguments: [
                      controller.resultadoController.contagens,
                      "Contagem",
                      uidProjeto
                    ]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.5),
                        borderRadius: arredondamentoBordas),
                    child: Column(
                      children: [
                        const Text(
                          "Estimativas de Contagem",
                          style: TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: arredondamentoBordas),
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount:
                                controller.resultadoController.contagens.length,
                            itemBuilder: ((context, index) {
                              ResultadoEntity resultadoEntity = controller
                                  .resultadoController.contagens[index];

                              return ComponenteEstimativas(
                                resultadoEntity: resultadoEntity,
                                valor: "PF",
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          controller.resultadoController.esforcosCompartilhados.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed("visualizar-estimativa", arguments: [
                      controller.resultadoController.contagens,
                      "Esforco",
                      uidProjeto
                    ]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.lime.withOpacity(0.5),
                        borderRadius: arredondamentoBordas),
                    child: Column(
                      children: [
                        const Text(
                          "Estimativas de Esforço",
                          style: TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: arredondamentoBordas),
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: controller.resultadoController
                                .esforcosCompartilhados.length,
                            itemBuilder: ((context, index) {
                              ResultadoEntity resultadoEntity = controller
                                  .resultadoController
                                  .esforcosCompartilhados[index];

                              return ComponenteEstimativas(
                                resultadoEntity: resultadoEntity,
                                valor: "HH",
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          controller.resultadoController.prazosCompartilhados.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed("visualizar-estimativa", arguments: [
                      controller.resultadoController.contagens,
                      "Prazo",
                      uidProjeto
                    ]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: arredondamentoBordas,
                        color: Colors.amber.withOpacity(0.4)),
                    child: Column(
                      children: [
                        const Text(
                          "Estimativas de Prazo",
                          style: TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: arredondamentoBordas,
                              color: Colors.white),
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: controller.resultadoController
                                .prazosCompartilhados.length,
                            itemBuilder: ((context, index) {
                              ResultadoEntity resultadoEntity = controller
                                  .resultadoController
                                  .prazosCompartilhados[index];

                              return ComponenteEstimativas(
                                resultadoEntity: resultadoEntity,
                                valor: "Dias",
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          controller.resultadoController.equipesCompartilhados.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed("visualizar-estimativa", arguments: [
                      controller.resultadoController.contagens,
                      "Equipe",
                      uidProjeto
                    ]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.5),
                        borderRadius: arredondamentoBordas),
                    child: Column(
                      children: [
                        const Text(
                          "Estimativas de Equipe",
                          style: TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: arredondamentoBordas,
                              color: Colors.white),
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: controller.resultadoController
                                .equipesCompartilhados.length,
                            itemBuilder: ((context, index) {
                              ResultadoEntity resultadoEntity = controller
                                  .resultadoController
                                  .equipesCompartilhados[index];

                              return ComponenteEstimativas(
                                resultadoEntity: resultadoEntity,
                                valor: "recur.",
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          controller.resultadoController.custosCompartilhados.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed("visualizar-estimativa", arguments: [
                      controller.resultadoController.contagens,
                      "Custo",
                      uidProjeto
                    ]);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: corDeFundoBotaoPrimaria.withOpacity(0.3),
                        borderRadius: arredondamentoBordas),
                    child: Column(
                      children: [
                        const Text(
                          "Estimativas de Custos",
                          style: TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: arredondamentoBordas,
                          ),
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: controller.resultadoController
                                .custosCompartilhados.length,
                            itemBuilder: ((context, index) {
                              ResultadoEntity resultadoEntity = controller
                                  .resultadoController
                                  .custosCompartilhados[index];

                              return ComponenteEstimativas(
                                dinheiro: true,
                                resultadoEntity: resultadoEntity,
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
