import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/componente_estimativa_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/linha_estimativas.dart';

class ExibicaoCardPrazo extends StatelessWidget {
  final ScrollController scrollController;
  final List<ResultadoEntity> resultados;
  final List<PrazoEntity> esforcos;
  const ExibicaoCardPrazo(
      {Key? key,
      required this.esforcos,
      required this.resultados,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: esforcos.length,
      itemBuilder: ((context, index) {
        PrazoEntity esforco = esforcos[index];
        if (resultados[index].uidMembro == esforco.uidUsuario) {
          return ComponenteEstimativasPadrao(
            resultadoEntity: resultados[index],
            corpoEstimativas: [
              LinhaEstimativas(
                  nome: "Tipo Contagem",
                  resultado: esforco.contagemPontoDeFuncao.split(" - ").first),
              LinhaEstimativas(
                  nome: "Tipo Sistema", resultado: esforco.tipoSistema),
              LinhaEstimativas(
                  nome: "Prazo Mínimo",
                  resultado: "${esforco.prazoMinimo} Dias"),
              LinhaEstimativas(
                  nome: "Prazo Total", resultado: "${esforco.prazoTotal} Dias"),
            ],
            membro: Modular.get<ProjetoController>()
                .membrosProjetoAtual
                .singleWhere((element) {
              return element.uid == esforco.uidUsuario;
            }),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
