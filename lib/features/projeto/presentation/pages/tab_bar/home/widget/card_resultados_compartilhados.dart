import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardEsforcosCompartilhados extends StatelessWidget {
  final String uidProjeto;
  final ProjetoController controller = Modular.get<ProjetoController>();
  CardEsforcosCompartilhados({
    Key? key,
    required this.uidProjeto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background.withOpacity(0.2),
        borderRadius: arredondamentoBordas,
      ),
      height: 500,
      width: TamanhoTela.width(context, 1),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Estimativas de Esforço",
            style: TextStyle(
                color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: corDeFundoCards, borderRadius: arredondamentoBordas),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  controller.resultadoController.esforcosCompartilhados.length,
              itemBuilder: ((context, index) {
                ResultadoEntity resultadoEntity = controller
                    .resultadoController.esforcosCompartilhados[index];

                return GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed("visualizar-estimativa",
                        arguments: [resultadoEntity, "Esforco", uidProjeto]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        resultadoEntity.anonimo
                            ? const Text("Anônimo")
                            : Text(resultadoEntity.uidMembro),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(resultadoEntity.nome),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("${resultadoEntity.valor} HH"),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Divider(
            color: corDeAcao.withOpacity(0.5),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Estimativas de Prazo",
            style: TextStyle(
                color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: corDeFundoCards, borderRadius: arredondamentoBordas),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  controller.resultadoController.prazosCompartilhados.length,
              itemBuilder: ((context, index) {
                ResultadoEntity resultadoEntity =
                    controller.resultadoController.prazosCompartilhados[index];

                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      resultadoEntity.anonimo
                          ? const Text("Anônimo")
                          : Text(resultadoEntity.uidMembro),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(resultadoEntity.nome),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${resultadoEntity.valor} HH"),
                    ],
                  ),
                );
              }),
            ),
          ),
          Divider(
            color: corDeAcao.withOpacity(0.5),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Estimativas de Equipe",
            style: TextStyle(
                color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: corDeFundoCards, borderRadius: arredondamentoBordas),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  controller.resultadoController.equipesCompartilhados.length,
              itemBuilder: ((context, index) {
                ResultadoEntity resultadoEntity =
                    controller.resultadoController.equipesCompartilhados[index];

                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      resultadoEntity.anonimo
                          ? const Text("Anônimo")
                          : Text(resultadoEntity.uidMembro),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(resultadoEntity.nome),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${resultadoEntity.valor} Recursos"),
                    ],
                  ),
                );
              }),
            ),
          ),
          Divider(
            color: corDeAcao.withOpacity(0.5),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Estimativas de Custos",
            style: TextStyle(
                color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: corDeFundoCards, borderRadius: arredondamentoBordas),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  controller.resultadoController.custosCompartilhados.length,
              itemBuilder: ((context, index) {
                ResultadoEntity resultadoEntity =
                    controller.resultadoController.custosCompartilhados[index];

                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      resultadoEntity.anonimo
                          ? const Text("Anônimo")
                          : SizedBox(
                              width: 150,
                              child: Text(resultadoEntity.uidMembro)),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(resultadoEntity.nome),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${resultadoEntity.valor} "),
                    ],
                  ),
                );
              }),
            ),
          ),
          Divider(
            color: corDeAcao.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
