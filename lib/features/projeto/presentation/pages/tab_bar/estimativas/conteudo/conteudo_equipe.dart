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
  }
}
