import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/componente_estimativa_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardExibicaoResultadoDetalhada extends StatelessWidget {
  final ScrollController scrollController;
  final ProjetoController projetoController = Modular.get<ProjetoController>();
  final List<ResultadoEntity> resultados;
  CardExibicaoResultadoDetalhada(
      {Key? key, required this.scrollController, required this.resultados})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          projetoController.contagemController.contagensDetakgadas.length,
      itemBuilder: ((context, index) {
        ContagemDetalhadaEntitie custo =
            projetoController.contagemController.contagensDetakgadas[index];

        for (var element in resultados) {
          if (element.uidMembro == custo.uidUsuario &&
              element.nome == "Detalhada") {
            return ComponenteEstimativasPadrao(
              resultadoEntity: resultados[index],
              corpoEstimativas: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Função de Dados",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue.withOpacity(0.5),
                        fontWeight: Fontes.weightTextoNormal),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  custo.funcaoDados.join("\n"),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: corCorpoTexto),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Função Transacional",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue.withOpacity(0.5),
                        fontWeight: Fontes.weightTextoNormal),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  custo.funcaoTransacional.join("\n"),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: corCorpoTexto),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 180,
                      child: Text(
                        "Total Função de Dados",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: corCorpoTexto),
                      ),
                    ),
                    Text(
                      custo.totalFuncaoDados.toString() + " PF",
                      style: const TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 180,
                      child: Text(
                        "Total Função Transacional",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: corCorpoTexto),
                      ),
                    ),
                    Text(
                      custo.totalFuncaoTransacional.toString() + " PF",
                      style: const TextStyle(
                          color: corCorpoTexto,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 180,
                      child: Text(
                        "Total:",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: corCorpoTexto,
                            fontWeight: Fontes.weightTextoNormal),
                      ),
                    ),
                    Text(
                      custo.totalPf.toString() + " PF",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: corDeAcao,
                          fontWeight: Fontes.weightTextoNormal),
                    ),
                  ],
                ),
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
