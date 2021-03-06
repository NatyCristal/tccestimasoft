import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/cards/card_custo.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConteudoCusto extends StatelessWidget {
  final ScrollController scrollController;
  final StoreEstimativaCusto custo;
  final ProjetoEntitie projetoEntitie;
  final ProjetoController controller = Modular.get<ProjetoController>();
  ConteudoCusto(
      {Key? key,
      required this.projetoEntitie,
      required this.custo,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: custo.custos.length,
      itemBuilder: (context, index) {
        CustoEntity custoEntity = custo.custos[index];

        return CardCustoEstimativa(custoEntity: custoEntity, store: custo);
      },
    );
  }
}
