// ignore_for_file: avoid_init_to_null

import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class IndexResultado extends StatelessWidget {
  final StoreContagemIndicativa storeContagemIndicativa;
  final StoreContagemEstimada storeContagemEstimada;
  final StoreContagemDetalhada storeContagemDetalhada;
  final StoreEstimativaEsforco storeEstimativaEsforco;
  final StoreEstimativaPrazo storeEstimativaPrazo;
  final StoreEstimativaEquipe storeEstimativaEquipe;
  final StoreEstimativaCusto storeEstimativaCusto;
  final StoreProjetosIndexMenu store;
  final ProjetoEntitie projeto;
  const IndexResultado(
      {Key? key,
      required this.storeContagemIndicativa,
      required this.storeContagemEstimada,
      required this.storeContagemDetalhada,
      required this.storeEstimativaEsforco,
      required this.storeEstimativaPrazo,
      required this.storeEstimativaEquipe,
      required this.storeEstimativaCusto,
      required this.store,
      required this.projeto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Para compartilhar as estimativas realize as contagens: Indicativa, Estimada e Detalhada. \n\n\nApós a contagem estime: Esforço, Prazo, Equipe e Custo para gerar o PDF e o texto para compartilhar",
              style: TextStyle(fontSize: tamanhoSubtitulo),
            ),
            Observer(builder: (context) {
              return storeContagemDetalhada.contagemDetalhadaValida.totalPf >
                          0 &&
                      podeCompartilhar(
                              context,
                              storeEstimativaEsforco,
                              storeEstimativaEquipe,
                              storeEstimativaPrazo,
                              storeEstimativaCusto) ==
                          true
                  ? SizedBox(
                      height: 200,
                      child: Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    const Color(0xFF71B4EC).withOpacity(0.3),
                                radius: 40,
                                child: const Icon(Icons.check_circle_sharp,
                                    color: Color(0xFF71B4EC), size: 80),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Estimativas prontas para compartilhar",
                                style: TextStyle(color: corCorpoTexto),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      child: Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red.withOpacity(0.4),
                                radius: 40,
                                child: const Icon(Icons.cancel,
                                    color: Colors.red, size: 80),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Finalize as estimativas para compartilhar",
                                style: TextStyle(color: corCorpoTexto),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}

podeCompartilhar(context, storeEstimativaEsforco, storeEstimativaEquipe,
    storeEstimativaPrazo, storeEstimativaCusto) {
  var esforcoDetalhada = null;
  var equipeDetalhada = null;
  var prazoDetalhado = null;
  var custoDetalhado = null;
  for (var element in storeEstimativaEsforco.esforcosValidos) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      esforcoDetalhada = element;
    }
  }

  for (var element in storeEstimativaEquipe.equipesValidas) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      equipeDetalhada = element;
    }
  }

  for (var element in storeEstimativaPrazo.prazosValidos) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      prazoDetalhado = element;
    }
  }

  for (var element in storeEstimativaCusto.custosValidos) {
    if (element.tipoContagem.contains("Detalhada")) {
      custoDetalhado = element;
    }
  }

  if (esforcoDetalhada == null ||
      prazoDetalhado == null ||
      equipeDetalhada == null ||
      custoDetalhado == null) {
    return false;
  } else if (esforcoDetalhada != null &&
      equipeDetalhada != null &&
      prazoDetalhado != null &&
      custoDetalhado != null) {
    return true;
  }
}

validarContagens(context, storeEstimativaEsforco, storeEstimativaEquipe,
    storeEstimativaPrazo, storeEstimativaCusto) {
  var esforcoDetalhada = null;
  var equipeDetalhada = null;
  var prazoDetalhado = null;
  var custoDetalhado = null;
  for (var element in storeEstimativaEsforco.esforcosValidos) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      esforcoDetalhada = element;
    }
  }

  for (var element in storeEstimativaEquipe.equipesValidas) {
    if (element.esforco.contains("Detalhada")) {
      equipeDetalhada = element;
    }
  }

  for (var element in storeEstimativaPrazo.prazosValidos) {
    if (element.contagemPontoDeFuncao.contains("Detalhada")) {
      prazoDetalhado = element;
    }
  }

  for (var element in storeEstimativaCusto.custosValidos) {
    if (element.tipoContagem.contains("Detalhada")) {
      custoDetalhado = element;
    }
  }

  if (esforcoDetalhada == null) {
    AlertaSnack.exbirSnackBar(context,
        "Realize a estimativa de esforço com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (prazoDetalhado == null) {
    AlertaSnack.exbirSnackBar(context,
        "Realize a estimativa de prazo com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (equipeDetalhada == null) {
    AlertaSnack.exbirSnackBar(context,
        "Realize a estimativa de equipe com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (custoDetalhado == null) {
    AlertaSnack.exbirSnackBar(context,
        "Realize a estimativa de custo com a contagem detalhada para compartihar o PDF");
    return false;
  } else if (esforcoDetalhada != null &&
      equipeDetalhada != null &&
      prazoDetalhado != null &&
      custoDetalhado != null) {
    return true;
  } else {
    AlertaSnack.exbirSnackBar(
        context, "Finalize suas estimativas  para compartihar o PDF");
    return false;
  }
}
