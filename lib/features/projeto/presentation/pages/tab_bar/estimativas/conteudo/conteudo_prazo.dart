import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/cards/card_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConteudoPrazo extends StatelessWidget {
  final StoreEstimativaPrazo storeEstimativaPrazo;
  final ScrollController scrollController;
  final ProjetoEntitie projetoEntitie;
  final ProjetoController controller = Modular.get<ProjetoController>();
  ConteudoPrazo(
      {Key? key,
      required this.scrollController,
      required this.projetoEntitie,
      required this.storeEstimativaPrazo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: storeEstimativaPrazo.prazos.length,
      itemBuilder: (context, index) {
        PrazoEntity prazo = storeEstimativaPrazo.prazos[index];

        return CardPrazo(prazoEntity: prazo, store: storeEstimativaPrazo);
      },
    );
  }
}
