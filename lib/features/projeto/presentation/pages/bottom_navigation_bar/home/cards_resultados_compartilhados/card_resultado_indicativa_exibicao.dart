import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/widgets/linha_contagens.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/widgets/linha_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/componente_estimativa_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExibicaoCardContagemIndicativa extends StatelessWidget {
  final ScrollController scrollController;
  final ProjetoController projetoController = Modular.get<ProjetoController>();
  final List<ResultadoEntity> resultados;

  ExibicaoCardContagemIndicativa({
    Key? key,
    required this.resultados,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          projetoController.contagemController.contagensIndicativas.length,
      itemBuilder: ((context, index) {
        ContagemIndicativaEntitie custo =
            projetoController.contagemController.contagensIndicativas[index];
        for (var element in resultados) {
          if (element.uidMembro == custo.uidUsuario &&
              element.nome == "Indicativa") {
            return ComponenteEstimativasPadrao(
              resultadoEntity: resultados[index],
              corpoEstimativas: [
                const LinhaEstimativas(
                  nome: "Tipo Contagem",
                  resultado: "Indicativa",
                ),
                LinhaContagens(
                    nome: "AIEs",
                    resultado: custo.aie.join("\n"),
                    complexidade: custo.aie.isEmpty ? "" : "15 PF | Baixa"),
                LinhaContagens(
                    nome: "ALIs",
                    resultado: custo.ali.join("\n"),
                    complexidade: custo.ali.isEmpty ? "" : "35 PF | Baixa"),
                const SizedBox(
                  height: 10,
                ),
                LinhaContagens(
                    nome: "Qtd Funções",
                    resultado: "",
                    complexidade:
                        (custo.aie.length + custo.ali.length).toString()),
                LinhaContagens(
                    nome: "Total PF",
                    resultado: "",
                    complexidade: custo.totalPf.toString() + " PF"),
              ],
              membro: Modular.get<ProjetoController>()
                  .membrosProjetoAtual
                  .singleWhere((element) {
                return element.uid == custo.uidUsuario;
              }),
            );
          }
        }
        if (resultados[index].uidMembro == custo.uidUsuario) {}
        return const SizedBox();
      }),
    );
  }
}
