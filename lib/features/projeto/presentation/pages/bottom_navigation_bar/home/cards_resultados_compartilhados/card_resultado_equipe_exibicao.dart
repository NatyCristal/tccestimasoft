import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/linha_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/componente_estimativa_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExibicaoCardEquipes extends StatelessWidget {
  final ScrollController scrollController;
  final List<ResultadoEntity> resultados;
  final List<EquipeEntity> equipes;
  const ExibicaoCardEquipes(
      {Key? key,
      required this.equipes,
      required this.resultados,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: equipes.length,
      itemBuilder: ((context, index) {
        EquipeEntity equipe = equipes[index];
        if (resultados[index].uidMembro == equipe.uidUsuario) {
          return SizedBox(
            height: 250,
            child: ComponenteEstimativasPadrao(
              resultadoEntity: resultados[index],
              corpoEstimativas: [
                LinhaEstimativas(
                    nome: "Tipo Contagem",
                    resultado: equipe.esforco.split(" - ").last),
                LinhaEstimativas(nome: "Esforço", resultado: equipe.esforco),
                LinhaEstimativas(
                    nome: "Prazo", resultado: "${equipe.prazo} Dias"),
                LinhaEstimativas(
                    nome: "Produção Diária",
                    resultado: "${equipe.producaoDiaria} Horas"),
                LinhaEstimativas(
                    nome: "Equipe Estimada",
                    resultado: "${equipe.equipeEstimada} Recursos"),
              ],
              membro: Modular.get<ProjetoController>()
                  .membrosProjetoAtual
                  .singleWhere((element) {
                return element.uid == equipe.uidUsuario;
              }),
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
