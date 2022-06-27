import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/cards_resultados_compartilhados/card_resultado_estimada_exibicao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/cards_resultados_compartilhados/card_resultado_indicativa_exibicao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExibicaoContagensCompartilhadas extends StatelessWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ScrollController scrollController;
  final List<ResultadoEntity> resultados;

  ExibicaoContagensCompartilhadas(
      {Key? key, required this.resultados, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Indicativas",
          style:
              TextStyle(color: corDeAcao, fontWeight: Fontes.weightTextoTitulo),
        ),
        ExibicaoCardContagemIndicativa(
          scrollController: scrollController,
          resultados: resultados,
        ),
        controller.contagemController.contagenEstimadas.isNotEmpty
            ? const Text(
                "Estimadas",
                style: TextStyle(
                    color: corDeAcao, fontWeight: Fontes.weightTextoTitulo),
              )
            : const SizedBox(),
        Expanded(
          child: ExibicaoCardContagemEstimada(
              scrollController: scrollController, resultados: resultados),
        ),
        const Text(
          "Detalhadas",
          style:
              TextStyle(color: corDeAcao, fontWeight: Fontes.weightTextoTitulo),
        ),
      ],
    );
  }
}
