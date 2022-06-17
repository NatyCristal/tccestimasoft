import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/cards/card_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConteudoEquipe extends StatelessWidget {
  final ScrollController scrollController;
  final StoreEstimativaEquipe equipe;
  final ProjetoEntitie projetoEntitie;
  final ProjetoController controller = Modular.get<ProjetoController>();
  ConteudoEquipe(
      {Key? key,
      required this.projetoEntitie,
      required this.equipe,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: equipe.equipes.length,
      itemBuilder: (context, index) {
        EquipeEntity equipeEntity = equipe.equipes[index];

        return CardEquipeEstimativa(equipeEntity: equipeEntity, store: equipe);
      },
    );

    // FutureBuilder(
    //   future: controller.recuperarEstimativa(projetoEntitie.uidProjeto,
    //       Modular.get<UsuarioAutenticado>().store.uid, "Equipe"),
    //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         if (snapshot.hasError) {
    //           return const Text(
    //               "Não foi possível recuperar os esforços cadastrados");
    //         } else if (snapshot.hasData) {
    //           if (controller.estimativasController.equipe.isEmpty) {
    //             return const Text("Vazio");
    //           } else {
    //             return ListView.builder(
    //               controller: scrollController,
    //               shrinkWrap: true,
    //               itemCount: equipe.equipes.length,
    //               itemBuilder: (context, index) {
    //                 EquipeEntity equipeEntity = equipe.equipes[index];

    //                 return CardEquipeEstimativa(
    //                     equipeEntity: equipeEntity, store: equipe);
    //               },
    //             );
    //           }
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
