import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/linha_contagens.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/linha_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/componente_estimativa_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExibicaoCardContagemEstimada extends StatelessWidget {
  final ScrollController scrollController;
  final ProjetoController projetoController = Modular.get<ProjetoController>();
  final List<ResultadoEntity> resultados;

  ExibicaoCardContagemEstimada({
    Key? key,
    required this.resultados,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: projetoController.contagemController.contagenEstimadas.length,
      itemBuilder: ((context, index) {
        ContagemEstimadaEntitie custo =
            projetoController.contagemController.contagenEstimadas[index];

        for (var element in resultados) {
          if (element.uidMembro == custo.uidUsuario &&
              element.nome == "Estimada") {
            return ComponenteEstimativasPadrao(
              resultadoEntity: resultados[index],
              corpoEstimativas: [
                const LinhaEstimativas(
                  nome: "Tipo Contagem",
                  resultado: "Estimada",
                ),
                LinhaContagens(
                    nome: "AIEs",
                    resultado: custo.aie.join("\n"),
                    complexidade: custo.aie.isEmpty ? "" : "7 PF | Baixa"),
                LinhaContagens(
                    nome: "ALIs",
                    resultado: custo.ali.join("\n"),
                    complexidade: custo.ali.isEmpty ? "" : "7 PF | Baixa"),
                LinhaContagens(
                    nome: "CEs",
                    resultado: custo.ce.join("\n"),
                    complexidade: custo.ce.isEmpty ? "" : "4 PF | Media"),
                LinhaContagens(
                    nome: "EEs",
                    resultado: custo.ee.join("\n"),
                    complexidade: custo.ee.isEmpty ? "" : "4 PF | Media"),
                LinhaContagens(
                    nome: "SEs",
                    resultado: custo.se.join("\n"),
                    complexidade: custo.se.isEmpty ? "" : "5 PF | Media"),
                const SizedBox(
                  height: 10,
                ),
                LinhaContagens(
                    nome: "Funções",
                    resultado: "",
                    complexidade: (custo.se.length +
                            custo.ee.length +
                            custo.ce.length +
                            custo.aie.length +
                            custo.aie.length)
                        .toString()),
                LinhaContagens(
                    nome: "Total PF",
                    resultado: "",
                    complexidade: custo.totalPF.toString() + " PF"),
              ],
              membro: Modular.get<ProjetoController>()
                  .membrosProjetoAtual
                  .singleWhere((element) {
                return element.uid == custo.uidUsuario;
              }),
            );
          }
        }

        return const SizedBox();
      }),
    );
  }
}
