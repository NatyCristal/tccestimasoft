import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/cards/card_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConteudoEsforco extends StatelessWidget {
  final ScrollController scrollController;
  final StoreEstimativaEsforco storeEstimativaEsforco;
  final ProjetoEntitie projetoEntitie;
  final ProjetoController controller = Modular.get<ProjetoController>();
  ConteudoEsforco(
      {Key? key,
      required this.projetoEntitie,
      required this.storeEstimativaEsforco,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: storeEstimativaEsforco.esforcos.length,
      itemBuilder: (context, index) {
        EsforcoEntity esforco = storeEstimativaEsforco.esforcos[index];

        return CardEsforco(
            esforcoEntity: esforco, store: storeEstimativaEsforco);
      },
    );
    // return FutureBuilder(
    //   future: controller.recuperarEstimativa(projetoEntitie.uidProjeto,
    //       Modular.get<UsuarioAutenticado>().store.uid, "Esforco"),
    //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         if (snapshot.hasError) {
    //           return const Text(
    //               "Não foi possível recuperar os esforços cadastrados");
    //         } else if (snapshot.hasData) {
    //           storeEstimativaEsforco.esforcosValidos =
    //               controller.estimativasController.esforcos;
    //           return ListView.builder(
    //             controller: scrollController,
    //             shrinkWrap: true,
    //             itemCount: storeEstimativaEsforco.esforcos.length,
    //             itemBuilder: (context, index) {
    //               EsforcoEntity esforco =
    //                   storeEstimativaEsforco.esforcos[index];

    //               return CardEsforco(
    //                   esforcoEntity: esforco, store: storeEstimativaEsforco);
    //             },
    //           );
    //         }

    //         break;
    //       case ConnectionState.active:
    //         return const Carregando();
    //       case ConnectionState.none:
    //         return const Text("Erro");
    //       case ConnectionState.waiting:
    //         return const Carregando();
    //     }
    //     return const SizedBox();
    //   },
    // );
  }
}
