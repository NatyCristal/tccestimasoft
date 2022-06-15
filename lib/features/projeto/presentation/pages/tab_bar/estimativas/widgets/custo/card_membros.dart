import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/card_equipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CardMembros extends StatelessWidget {
  final ScrollController scrollController;
  final StoreEstimativaCusto storeEstimativaCusto;
  const CardMembros(
      {Key? key,
      required this.storeEstimativaCusto,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Equipe",
          style: TextStyle(color: corTituloTexto, fontSize: tamanhoSubtitulo),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: arredondamentoBordas,
            color: Colors.blue.withOpacity(0.2),
          ),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Observer(builder: (context) {
                return storeEstimativaCusto.textoErroCargoMembro == ""
                    ? TextField(
                        onChanged: (value) {
                          storeEstimativaCusto.cargoMembro = value.toString();
                          storeEstimativaCusto.validarAdicaoEquipe();
                        },
                        decoration: const InputDecoration(
                          hintText: "Cargo",
                        ),
                      )
                    : TextField(
                        decoration: InputDecoration(
                            errorText:
                                storeEstimativaCusto.textoErroCargoMembro,
                            hintText: "Cargo"),
                        onChanged: (value) {
                          storeEstimativaCusto.cargoMembro = value.toString();
                          storeEstimativaCusto.validarAdicaoEquipe();
                        },
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              Observer(builder: (context) {
                return storeEstimativaCusto.textoErroSalarioMembro == ""
                    ? TextField(
                        onChanged: (value) {
                          storeEstimativaCusto.salarioMembro = value.toString();
                          storeEstimativaCusto.validarAdicaoEquipe();
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Salário",
                        ),
                      )
                    : TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            errorText:
                                storeEstimativaCusto.textoErroSalarioMembro,
                            hintText: "Salário"),
                        onChanged: (value) {
                          storeEstimativaCusto.salarioMembro = value.toString();
                          storeEstimativaCusto.validarAdicaoEquipe();
                        },
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => storeEstimativaCusto.adicionarEquipe(context),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: arredondamentoBordas,
                            color: corDeAcao.withOpacity(0.2)),
                        height: 30,
                        width: 30,
                        child: const Icon(
                          Icons.add,
                          color: corDeAcao,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Observer(builder: (context) {
          return storeEstimativaCusto.tamanhoEquipe == 0
              ? const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Nenhum membro cadastrado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: corCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 200,
                  child: Column(
                    children: [
                      const Text(
                        "Equipe Cadastrada",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: corCorpoTexto,
                            fontWeight: Fontes.weightTextoNormal),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount: storeEstimativaCusto.equipe.length,
                          itemBuilder: ((context, index) {
                            String chave = storeEstimativaCusto.equipe.keys
                                .elementAt(index);
                            String valor = storeEstimativaCusto.equipe.values
                                .elementAt(index);

                            return CardEquipe(
                              valor: valor,
                              chave: chave,
                              store: storeEstimativaCusto,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
        }),
        const SizedBox(
          height: 20,
        ),
        Observer(builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Text(
              "Total de membros ${storeEstimativaCusto.tamanhoEquipe}",
              style: const TextStyle(color: corCorpoTexto),
            ),
          );
        }),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          color: corDeLinhaAppBar,
        ),
      ],
    );
  }
}
