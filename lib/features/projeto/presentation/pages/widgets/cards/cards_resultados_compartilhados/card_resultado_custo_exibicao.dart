import 'package:estimasoft/core/shared/utils/formatadores.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/linha_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/componente_estimativa_padrao.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExibicaoCardCusto extends StatelessWidget {
  final ScrollController scrollController;
  final List<ResultadoEntity> resultados;
  final List<CustoEntity> custos;
  const ExibicaoCardCusto(
      {Key? key,
      required this.custos,
      required this.resultados,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: custos.length,
      itemBuilder: ((context, index) {
        CustoEntity custo = custos[index];

        if (resultados[index].uidMembro == custo.uidUsuario) {
          return ComponenteEstimativasPadrao(
            resultadoEntity: resultados[index],
            corpoEstimativas: [
              LinhaEstimativas(
                nome: "Tipo Contagem",
                resultado: custo.tipoContagem,
              ),
              LinhaEstimativas(
                quantidadeLinhas: false,
                nome: "Equipe",
                resultado: custo.equipe.join("\n"),
              ),
              LinhaEstimativas(
                  quantidadeLinhas: false,
                  nome: "Custos",
                  resultado: custo.custosVariaisFixos.join("\n")),
              LinhaEstimativas(
                  nome: "Disp. Equipe",
                  resultado: custo.disponibilidadeEquipe + " HH"),
              LinhaEstimativas(
                nome: "Custo da hora",
                resultado: Formatadores.formatadorMonetario(
                    custo.custoHora.toString()),
              ),
              LinhaEstimativas(
                  nome: "Custo TotalMensal",
                  resultado:
                      Formatadores.formatadorMonetario(custo.custoTotalMensal)),
              LinhaEstimativas(
                  nome: "Custo Total Projeto",
                  resultado: Formatadores.formatadorMonetario(
                      (custo.custoTotalProjeto).toStringAsFixed(2))),
              LinhaEstimativas(
                  nome: "Valor Total Projeto",
                  resultado: Formatadores.formatadorMonetario(
                      (custo.valorTotalProjeto).toStringAsFixed(2))),
            ],
            membro: Modular.get<ProjetoController>()
                .membrosProjetoAtual
                .singleWhere((element) {
              return element.uid == custo.uidUsuario;
            }),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
