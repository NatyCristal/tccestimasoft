import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/componentes/card_funcao_dados_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/componentes/card_funcao_transacional_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/conteudo/conteudo_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../../../core/shared/utils.dart';

class ContagemDetalhada extends StatelessWidget {
  final StoreContagemIndicativa storeIndicativa;
  final String projetoUid;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final StoreContagemEstimada storeEstimada;
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerLateral = ScrollController();
  final StoreContagemDetalhada storeContagemDetalhada;
  ContagemDetalhada(
      {Key? key,
      required this.projetoUid,
      required this.storeEstimada,
      required this.storeIndicativa,
      required this.storeContagemDetalhada})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    storeEstimada.totalIndicativa = storeIndicativa.totalPf;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConteudoContagemDetalhada(
              storeContagemDetalhada: storeContagemDetalhada,
              uidProjeto: projetoUid,
              store: storeEstimada,
              storeContagemIndicativa: storeIndicativa),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Altere os valores de TDs, TRr e ARs",
            style: TextStyle(
                color: corCorpoTexto, fontWeight: Fontes.weightTextoNormal),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Alert(
                  context: context,
                  title: "Significado das siglas",
                  style: const AlertStyle(
                    titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "AR: Arquivos Referenciados.",
                        style: TextStyle(
                            fontWeight: Fontes.weightTextoLeve,
                            color: corCorpoTexto,
                            fontSize: tamanhoSubtitulo),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "TR: Tipo de registro",
                        style: TextStyle(
                            fontWeight: Fontes.weightTextoLeve,
                            color: corCorpoTexto,
                            fontSize: tamanhoSubtitulo),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "TD: Tipo de dado.",
                        style: TextStyle(
                            fontWeight: Fontes.weightTextoLeve,
                            color: corCorpoTexto,
                            fontSize: tamanhoSubtitulo),
                      ),
                    ],
                  ),
                  buttons: [
                    DialogButton(
                      color: corDeFundoBotaoSecundaria,
                      child: const Text(
                        "OK",
                        style: TextStyle(
                            fontWeight: Fontes.weightTextoNormal,
                            color: corDeTextoBotaoSecundaria,
                            fontSize: 14),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      width: 120,
                    ),
                  ],
                ).show();
              },
              icon: Icon(
                Icons.info,
                size: 24,
                color: corDeAcao.withOpacity(0.7),
              ),
            ),
          ),
          Column(
            children: const [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Função de Dados",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Observer(builder: (context) {
            return storeContagemDetalhada.tamanhoFuncaoDeDados > 0
                ? FuncaoDeDadosDetalhada(
                    storeContagemDetalhada: storeContagemDetalhada,
                    scrollController: scrollControllerLateral)
                : SizedBox(
                    child: Text(
                      "Não possui nenhuma função de dados cadastrada",
                      style: TextStyle(color: corCorpoTexto.withOpacity(0.5)),
                    ),
                  );
          }),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Função Transacional",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Observer(builder: (context) {
            return storeContagemDetalhada.tamanhoFuncaoTransacional > 0
                ? CardFuncaoTransacionalDetalhada(
                    contagemDetalhada: storeContagemDetalhada,
                    scrollController: scrollControllerLateral)
                : SizedBox(
                    height: 30,
                    child: Text(
                      "Não possui nenhuma função Transacional cadastrada",
                      style: TextStyle(color: corCorpoTexto.withOpacity(0.5)),
                    ),
                  );
          }),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: arredondamentoBordas),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Observer(builder: (context) {
                  return Text(
                      "${storeContagemDetalhada.totalPfFuncaoDeDados} PF em Função de dados");
                }),
                const SizedBox(
                  height: 10,
                ),
                Observer(builder: (context) {
                  return Text(
                      "${storeContagemDetalhada.totalPfFuncaTransacional}  PF em Função Transacional");
                }),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Total  ",
                  style: TextStyle(
                    color: corTituloTexto,
                  ),
                ),
                Observer(builder: (context) {
                  return Text(
                    "${storeContagemDetalhada.totalPf} PF",
                    style: const TextStyle(
                      color: corTituloTexto,
                    ),
                  );
                }),
              ],
            ),
            Observer(builder: (context) {
              return Text(
                  "Quantidade de funções  ${(storeEstimada.contagemEstimadaValida.ce.length + storeEstimada.contagemEstimadaValida.ee.length + storeEstimada.contagemEstimadaValida.se.length + storeIndicativa.contagemIndicativaValida.aie.length + storeIndicativa.contagemIndicativaValida.ali.length).toString()}");
            }),
          ]),
          const SizedBox(
            height: 20,
          ),
          Observer(builder: (context) {
            return storeContagemDetalhada.alteracoes
                ? const Text(
                    "Clique em continuar!",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: Fontes.weightTextoNormal,
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  );
          }),
        ],
      ),
    );
  }
}
