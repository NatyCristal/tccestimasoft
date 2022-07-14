// import 'package:estimasoft/core/shared/utils.dart';
// import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
// import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
// import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/home/widget/componente_estimativas.dart';
// import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
// import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';

// class CardEsforcosCompartilhados extends StatelessWidget {
//   final ScrollController scrollController;
//   final String uidProjeto;
//   final ProjetoController controller = Modular.get<ProjetoController>();
//   CardEsforcosCompartilhados({
//     Key? key,
//     required this.uidProjeto,
//     required this.scrollController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: arredondamentoBordas,
//       ),
//       width: TamanhoTela.width(context, 1),
//       child: Column(
//         children: [
//           controller.resultadoController.contagensIndicativas.isNotEmpty
//               ? GestureDetector(
//                   onTap: () {
//                     Modular.to.pushNamed("visualizar-estimativa", arguments: [
//                       controller.resultadoController.contagensIndicativas,
//                       "Indicativa",
//                       uidProjeto
//                     ]);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.5),
//                         borderRadius: arredondamentoBordas),
//                     child: Column(
//                       children: [
//                         const Text(
//                           "Estimativas de Contagem Indicativa",
//                           style: TextStyle(
//                               color: corCorpoTexto,
//                               fontWeight: Fontes.weightTextoNormal),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: arredondamentoBordas),
//                           child: ListView.builder(
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             itemCount: controller.resultadoController
//                                 .contagensIndicativas.length,
//                             itemBuilder: ((context, index) {
//                               ResultadoEntity resultadoEntity = controller
//                                   .resultadoController
//                                   .contagensIndicativas[index];

//                               return ComponenteEstimativas(
//                                 resultadoEntity: resultadoEntity,
//                                 valor: "PF",
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//           const SizedBox(
//             height: 10,
//           ),
//           controller.resultadoController.contagensEstimadas.isNotEmpty
//               ? GestureDetector(
//                   onTap: () {
//                     Modular.to.pushNamed("visualizar-estimativa", arguments: [
//                       controller.resultadoController.contagensEstimadas,
//                       "Estimada",
//                       uidProjeto
//                     ]);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: Colors.green.withOpacity(0.5),
//                         borderRadius: arredondamentoBordas),
//                     child: Column(
//                       children: [
//                         const Text(
//                           "Estimativas de Contagem Estimada",
//                           style: TextStyle(
//                               color: corCorpoTexto,
//                               fontWeight: Fontes.weightTextoNormal),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: arredondamentoBordas),
//                           child: ListView.builder(
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             itemCount: controller
//                                 .resultadoController.contagensEstimadas.length,
//                             itemBuilder: ((context, index) {
//                               ResultadoEntity resultadoEntity = controller
//                                   .resultadoController
//                                   .contagensEstimadas[index];

//                               return ComponenteEstimativas(
//                                 resultadoEntity: resultadoEntity,
//                                 valor: "PF",
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//           const SizedBox(
//             height: 10,
//           ),
//           controller.resultadoController.contagensDetalhadas.isNotEmpty
//               ? GestureDetector(
//                   onTap: () {
//                     Modular.to.pushNamed("visualizar-estimativa", arguments: [
//                       controller.resultadoController.contagensDetalhadas,
//                       "Detalhada",
//                       uidProjeto
//                     ]);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: Colors.red.withOpacity(0.5),
//                         borderRadius: arredondamentoBordas),
//                     child: Column(
//                       children: [
//                         const Text(
//                           "Estimativas de Contagem Detalhada",
//                           style: TextStyle(
//                               color: corCorpoTexto,
//                               fontWeight: Fontes.weightTextoNormal),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: arredondamentoBordas),
//                           child: ListView.builder(
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             itemCount: controller
//                                 .resultadoController.contagensDetalhadas.length,
//                             itemBuilder: ((context, index) {
//                               ResultadoEntity resultadoEntity = controller
//                                   .resultadoController
//                                   .contagensDetalhadas[index];

//                               return ComponenteEstimativas(
//                                 resultadoEntity: resultadoEntity,
//                                 valor: "PF",
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//           const SizedBox(
//             height: 10,
//           ),
//           controller.resultadoController.esforcosCompartilhados.isNotEmpty
//               ? GestureDetector(
//                   onTap: () {
//                     Modular.to.pushNamed("visualizar-estimativa", arguments: [
//                       controller.resultadoController.esforcosCompartilhados,
//                       "Esforco",
//                       uidProjeto
//                     ]);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: Colors.pink.withOpacity(0.4),
//                         borderRadius: arredondamentoBordas),
//                     child: Column(
//                       children: [
//                         const Text(
//                           "Estimativas de Esforço",
//                           style: TextStyle(
//                               color: corCorpoTexto,
//                               fontWeight: Fontes.weightTextoNormal),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: arredondamentoBordas),
//                           child: ListView.builder(
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             itemCount: controller.resultadoController
//                                 .esforcosCompartilhados.length,
//                             itemBuilder: ((context, index) {
//                               ResultadoEntity resultadoEntity = controller
//                                   .resultadoController
//                                   .esforcosCompartilhados[index];

//                               return ComponenteEstimativas(
//                                 resultadoEntity: resultadoEntity,
//                                 valor: "HH",
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//           const SizedBox(
//             height: 10,
//           ),
//           controller.resultadoController.prazosCompartilhados.isNotEmpty
//               ? GestureDetector(
//                   onTap: () {
//                     Modular.to.pushNamed("visualizar-estimativa", arguments: [
//                       controller.resultadoController.prazosCompartilhados,
//                       "Prazo",
//                       uidProjeto
//                     ]);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         borderRadius: arredondamentoBordas,
//                         color: Colors.amber.withOpacity(0.4)),
//                     child: Column(
//                       children: [
//                         const Text(
//                           "Estimativas de Prazo",
//                           style: TextStyle(
//                               color: corCorpoTexto,
//                               fontWeight: Fontes.weightTextoNormal),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: arredondamentoBordas,
//                               color: Colors.white),
//                           child: ListView.builder(
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             itemCount: controller.resultadoController
//                                 .prazosCompartilhados.length,
//                             itemBuilder: ((context, index) {
//                               ResultadoEntity resultadoEntity = controller
//                                   .resultadoController
//                                   .prazosCompartilhados[index];

//                               return ComponenteEstimativas(
//                                 resultadoEntity: resultadoEntity,
//                                 valor: "Dias",
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//           const SizedBox(
//             height: 10,
//           ),
//           controller.resultadoController.equipesCompartilhados.isNotEmpty
//               ? GestureDetector(
//                   onTap: () {
//                     Modular.to.pushNamed("visualizar-estimativa", arguments: [
//                       controller.resultadoController.equipesCompartilhados,
//                       "Equipe",
//                       uidProjeto
//                     ]);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: Colors.cyan.withOpacity(0.5),
//                         borderRadius: arredondamentoBordas),
//                     child: Column(
//                       children: [
//                         const Text(
//                           "Estimativas de Equipe",
//                           style: TextStyle(
//                               color: corCorpoTexto,
//                               fontWeight: Fontes.weightTextoNormal),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               borderRadius: arredondamentoBordas,
//                               color: Colors.white),
//                           child: ListView.builder(
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             itemCount: controller.resultadoController
//                                 .equipesCompartilhados.length,
//                             itemBuilder: ((context, index) {
//                               ResultadoEntity resultadoEntity = controller
//                                   .resultadoController
//                                   .equipesCompartilhados[index];

//                               return ComponenteEstimativas(
//                                 resultadoEntity: resultadoEntity,
//                                 valor: "recur.",
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//           const SizedBox(
//             height: 10,
//           ),
//           controller.resultadoController.custosCompartilhados.isNotEmpty
//               ? GestureDetector(
//                   onTap: () {
//                     Modular.to.pushNamed("visualizar-estimativa", arguments: [
//                       controller.resultadoController.custosCompartilhados,
//                       "Custo",
//                       uidProjeto
//                     ]);
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         color: corDeFundoBotaoPrimaria.withOpacity(0.3),
//                         borderRadius: arredondamentoBordas),
//                     child: Column(
//                       children: [
//                         const Text(
//                           "Estimativas de Custos",
//                           style: TextStyle(
//                               color: corCorpoTexto,
//                               fontWeight: Fontes.weightTextoNormal),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: arredondamentoBordas,
//                           ),
//                           child: ListView.builder(
//                             controller: scrollController,
//                             shrinkWrap: true,
//                             itemCount: controller.resultadoController
//                                 .custosCompartilhados.length,
//                             itemBuilder: ((context, index) {
//                               ResultadoEntity resultadoEntity = controller
//                                   .resultadoController
//                                   .custosCompartilhados[index];

//                               return ComponenteEstimativas(
//                                 dinheiro: true,
//                                 resultadoEntity: resultadoEntity,
//                               );
//                             }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }
// }
//TODO DELETAR
