import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/card_equipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CardCustosVariaveisFixos extends StatelessWidget {
  final ScrollController scroll;
  final StoreEstimativaCusto storeEstimativaCusto;
  const CardCustosVariaveisFixos(
      {Key? key, required this.storeEstimativaCusto, required this.scroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Custos Fixos e variados",
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
                return storeEstimativaCusto.textoErroNomeCusto == ""
                    ? TextField(
                        onChanged: (value) {
                          storeEstimativaCusto.nomeCusto = value.toString();
                          storeEstimativaCusto.validarAdicaoCusto();
                        },
                        decoration: const InputDecoration(
                          hintText: "Nome custo",
                        ),
                      )
                    : TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            errorText: storeEstimativaCusto.textoErroNomeCusto,
                            hintText: "Nome custo"),
                        onChanged: (value) {
                          storeEstimativaCusto.nomeCusto = value.toString();
                          storeEstimativaCusto.validarAdicaoCusto();
                        },
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              Observer(builder: (context) {
                return storeEstimativaCusto.textoErrovalorCusto == ""
                    ? TextField(
                        onChanged: (value) {
                          storeEstimativaCusto.valorCusto = value.toString();
                          storeEstimativaCusto.validarAdicaoCusto();
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Valor",
                        ),
                      )
                    : TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            errorText: storeEstimativaCusto.textoErrovalorCusto,
                            hintText: "Valor"),
                        onChanged: (value) {
                          storeEstimativaCusto.valorCusto = value.toString();
                          storeEstimativaCusto.validarAdicaoCusto();
                        },
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (() => storeEstimativaCusto.adicionarCusto(context)),
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
          return storeEstimativaCusto.tamanhoCustos == 0
              ? const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Nenhum custo cadastrado",
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
                          controller: scroll,
                          shrinkWrap: true,
                          itemCount:
                              storeEstimativaCusto.custosVariaveis.length,
                          itemBuilder: ((context, index) {
                            String chave = storeEstimativaCusto
                                .custosVariaveis.keys
                                .elementAt(index);
                            String valor = storeEstimativaCusto
                                .custosVariaveis.values
                                .elementAt(index);

                            return CardEquipe(
                              custo: true,
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
              "Total de custos ${storeEstimativaCusto.tamanhoCustos.toString()}",
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
