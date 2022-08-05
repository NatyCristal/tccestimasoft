// ignore_for_file: avoid_init_to_null

import 'package:dolumns/dolumns.dart';
import 'package:estimasoft/core/shared/utils/formatadores.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';

class FormarTextoCompartilhar {
  static textoCompartilharComOprojeto(
      bool anonimo,
      ProjetoEntitie projetoEntitie,
      storeEstimativaEsforco,
      storeEstimativaEquipe,
      storeEstimativaPrazo,
      storeEstimativaCusto,
      StoreContagemIndicativa storeIndicativa,
      StoreContagemEstimada storeEstimada,
      StoreContagemDetalhada storeDetalhada) {
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

    String responsavelPelaContagem = anonimo
        ? 'Responsável pela contagem: Anônimo\n\n'
        : 'Responsável pela contagem: ${Modular.get<UsuarioAutenticado>().store.nome}\n\n';

    String contagemDetalhada = "\t1. Contagem Detalhada\n\n";

    final columns3 = [
      'Produtividade (H/PF):' + esforcoDetalhada.produtividadeEquipe,
      'Dias úteis no mês: '
          "21",
      'Produtividade diária (horas/dia): ' +
          equipeDetalhada.producaoDiaria +
          "Expoente t ${prazoDetalhado.tipoSistema}:" +
          storeEstimativaPrazo
              .buscarExpoenteT(prazoDetalhado.tipoSistema)
              .toString(),
      "Custo unitário (R\$/PF): " +
          Formatadores.formatadorMonetario(custoDetalhado.custoPF)
    ];

    final colums4 = dolumnify([
      [
        "Indicativa",
        storeIndicativa.contagemIndicativaValida.totalPf.toString(),
        Formatadores.formatadorMonetario(
            (double.parse(custoDetalhado.custoPF) * storeIndicativa.totalPf)
                .toStringAsFixed(2)),
      ],
      [
        "Estimativa",
        storeEstimada.contagemEstimadaValida.totalPF.toString(),
        Formatadores.formatadorMonetario((double.parse(custoDetalhado.custoPF) *
                storeEstimada.contagemEstimadaValida.totalPF)
            .toStringAsFixed(2)),
      ],
      [
        "Detalhada",
        storeDetalhada.contagemDetalhadaValida.totalPf.toString(),
        Formatadores.formatadorMonetario((double.parse(custoDetalhado.custoPF) *
                storeDetalhada.contagemDetalhadaValida.totalPf)
            .toStringAsFixed(2)),
      ]
    ]);

    final List<String> colums5 = [
      'Esforço (horas) ',
      esforcoDetalhada.esforcoTotal +
          "\n"
              'Prazo (em meses) ',
      (prazoDetalhado.prazoTotal / 30).toStringAsFixed(2) +
          "\n"
              'Prazo (em semanas) ',
      (prazoDetalhado.prazoTotal / 30 * 4).toStringAsFixed(2) +
          "\n"
              'Prazo (em dias) ',
      prazoDetalhado.prazoTotal.toString() + "\n",
      'Região do impossível (75%) (em semanas) ',
      (double.parse(prazoDetalhado.prazoMinimo) / 30 * 4).toStringAsFixed(2) +
          "\n"
              'Tamanho da Equipe: ',
      equipeDetalhada.equipeEstimada + "\n",
      'Valor do rateio de despesas para o projeto por mês ',
      Formatadores.formatadorMonetario(custoDetalhado.custoTotalMensal) + "\n"
    ];

    final List<String> colums6 = [
      'Tamanho funcional (PF): ' +
          storeDetalhada.contagemDetalhadaValida.totalPf.toString() +
          "\n",
      'Custo básico (CP): ' +
          Formatadores.formatadorMonetario(
              custoDetalhado.custoBasico.toStringAsFixed(2)) +
          "\n"
              'Percentual de reserva técnica do projeto: ' +
          custoDetalhado.porcentagemLucro +
          "%\n"
              'Valor reserva técnica:' +
          Formatadores.formatadorMonetario(
              custoDetalhado.valorPorcentagem.toStringAsFixed(2)) +
          "\n"
              'Custo + Reserva técnica: ' +
          Formatadores.formatadorMonetario(
              (custoDetalhado.custoBasico + custoDetalhado.valorPorcentagem)
                  .toStringAsFixed(2)) +
          "\n"
              'Despesas Rateadas para o projeto durante o\n prazo do seu desenvolvimento: ' +
          Formatadores.formatadorMonetario(custoDetalhado
              .despesasTotaisDurantePrazoProjeto
              .toStringAsFixed(2)) +
          "\n"
              'Custo estimado total: ' +
          Formatadores.formatadorMonetario(
              custoDetalhado.valorTotalProjeto.toStringAsFixed(2)) +
          "\n"
    ];

    List<String> linhaColuna = [
      "Etapa: Requisitos\nPercentual: 25%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.25).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.25).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.25)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Design\nPercentual: 10%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.10).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.10).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.10)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Codificação\nPercentual: 40%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.40).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.40).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.40)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Testes\nPercentual: 15%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.15).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.15).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.15)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Homologação\nPercentual: 5%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.05).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.05)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Implantação\nPercentual: 5%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.05).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.05)).roundToDouble().toStringAsFixed(2)}\n\n"
    ];

    final List<String> colum8 = [
      'Percentual de Lucro desejado: ',
      '50%\n',
      "Lucro Esperado: ",
      Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.5).toStringAsFixed(2)) +
          "\n"
              "Preço final ao cliente: ",
      Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 1.5).toStringAsFixed(2)) +
          "\n"
    ];

    String textoFinal = responsavelPelaContagem +
        contagemDetalhada +
        storeDetalhada.contagemDetalhadaValida.funcaoDados.join("\n\n") +
        "\nContribuição total das funções de dados: " +
        storeDetalhada.contagemDetalhadaValida.totalFuncaoDados.toString() +
        " PF\n\n" +
        storeDetalhada.contagemDetalhadaValida.funcaoTransacional.join("\n\n") +
        "\nContribuição total das funções transacionais: " +
        storeDetalhada.contagemDetalhadaValida.totalFuncaoTransacional
            .toString() +
        "\n\n1.3 Pontos de função não ajustados (brutos)\n\n" +
        "Tamanho funcional estimado = ${storeDetalhada.contagemDetalhadaValida.totalPf} PF" +
        "\n\n\t2. Parâmetros de entrada\n\n" +
        columns3.join("\n") +
        "\n\n\t3. Resumo por tipo de contagem\n\n" +
        colums4.toString() +
        "\n\n\t4. Estimativas baseadas na contagem Detalhada\n\n" +
        colums5.join("") +
        "\n\n\t5. Estimativas de Custo para contagem detalhada\n\n" +
        colums6.join("\n") +
        "\n\n\t6. Distribuição do custo, esforço e prazo por etapa\n\n" +
        linhaColuna.join() +
        "\n\t7. Orçamento do projeto para o cliente\n\n" +
        colum8.join();

    return textoFinal;
  }

  static compartilharTextoDetalhado(
      ProjetoEntitie projetoEntitie,
      storeEstimativaEsforco,
      storeEstimativaEquipe,
      storeEstimativaPrazo,
      storeEstimativaCusto,
      StoreContagemIndicativa storeIndicativa,
      StoreContagemEstimada storeEstimada,
      StoreContagemDetalhada storeDetalhada) {
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

    String descricao =
        projetoEntitie.descricao.isNotEmpty ? projetoEntitie.descricao : "";

    String nomeDoProjeto = 'Nome do projeto: ${projetoEntitie.nomeProjeto}\n';
    String descricaoProjeto = 'Descrição: $descricao\n';
    String responsavelPelaContagem =
        'Responsável pela contagem: ${Modular.get<UsuarioAutenticado>().store.nome}\n\n';

    String contagemDetalhada = "\t1. Contagem Detalhada\n\n";

    final columns3 = dolumnify(
      [
        ['Produtividade (H/PF)', esforcoDetalhada.produtividadeEquipe],
        ['Dias úteis no mês', "21"],
        ['Produtividade diária (horas/dia)', equipeDetalhada.producaoDiaria],
        [
          "Expoente t ${prazoDetalhado.tipoSistema}",
          storeEstimativaPrazo.buscarExpoenteT(prazoDetalhado.tipoSistema),
        ],
        [
          "Custo unitário (R\$/PF)",
          Formatadores.formatadorMonetario(custoDetalhado.custoPF)
        ]
      ],
      headerIncluded: false,
    );

    final colums4 = dolumnify([
      [
        'Tipo de contagem',
        'Tamanho (PF)',
        'Custo estimado',
      ],
      [
        "Indicativa",
        storeIndicativa.contagemIndicativaValida.totalPf.toString(),
        Formatadores.formatadorMonetario(
            (double.parse(custoDetalhado.custoPF) * storeIndicativa.totalPf)
                .toStringAsFixed(2)),
      ],
      [
        "Estimativa",
        storeEstimada.contagemEstimadaValida.totalPF.toString(),
        Formatadores.formatadorMonetario((double.parse(custoDetalhado.custoPF) *
                storeEstimada.contagemEstimadaValida.totalPF)
            .toStringAsFixed(2)),
      ],
      [
        "Detalhada",
        storeDetalhada.contagemDetalhadaValida.totalPf.toString(),
        Formatadores.formatadorMonetario((double.parse(custoDetalhado.custoPF) *
                storeDetalhada.contagemDetalhadaValida.totalPf)
            .toStringAsFixed(2)),
      ]
    ]);

    final colums5 = dolumnify([
      ['Esforço (horas)', esforcoDetalhada.esforcoTotal],
      ['Prazo (em meses)', (prazoDetalhado.prazoTotal / 30).toStringAsFixed(2)],
      [
        'Prazo (em semanas)',
        (prazoDetalhado.prazoTotal / 30 * 4).toStringAsFixed(2)
      ],
      ['Prazo (em dias)', prazoDetalhado.prazoTotal],
      [
        'Região do impossível (75%) (em semanas)',
        (double.parse(prazoDetalhado.prazoMinimo) / 30 * 4).toStringAsFixed(2)
      ],
      ['Tamanho da Equipe', equipeDetalhada.equipeEstimada],
      [
        'Valor do rateio de despesas para o projeto por mês',
        Formatadores.formatadorMonetario(custoDetalhado.custoTotalMensal)
      ],
    ]);

    final colums6 = dolumnify([
      [
        'Tamanho funcional (PF)',
        storeDetalhada.contagemDetalhadaValida.totalPf
      ],
      [
        'Custo básico (CP)',
        Formatadores.formatadorMonetario(
            custoDetalhado.custoBasico.toStringAsFixed(2))
      ],
      [
        'Percentual de reserva técnica do projeto',
        custoDetalhado.porcentagemLucro + "%"
      ],
      [
        'Valor reserva técnica',
        Formatadores.formatadorMonetario(
            custoDetalhado.valorPorcentagem.toStringAsFixed(2))
      ],
      [
        'Custo + Reserva técnica',
        Formatadores.formatadorMonetario(
            (custoDetalhado.custoBasico + custoDetalhado.valorPorcentagem)
                .toStringAsFixed(2))
      ],
      [
        'Despesas Rateadas para o projeto durante o\n prazo do seu desenvolvimento',
        Formatadores.formatadorMonetario(
            custoDetalhado.despesasTotaisDurantePrazoProjeto.toStringAsFixed(2))
      ],
      [
        'Custo estimado total',
        Formatadores.formatadorMonetario(
            custoDetalhado.valorTotalProjeto.toStringAsFixed(2))
      ],
    ]);

    List<String> linhaColuna = [
      "Etapa: Requisitos\nPercentual: 25%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.25).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.25).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.25)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Design\nPercentual: 10%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.10).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.10).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.10)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Codificação\nPercentual: 40%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.40).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.40).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.40)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Testes\nPercentual: 15%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.15).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.15).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.15)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Homologação\nPercentual: 5%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.05).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.05)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Implantação\nPercentual: 5%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.05).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.05)).roundToDouble().toStringAsFixed(2)}\n\n"
    ];
    final colum8 = dolumnify(
      [
        [
          'Percentual de Lucro desejado',
          '50%',
        ],
        [
          "Lucro Esperado",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.5).toStringAsFixed(2))
        ],
        [
          "Preço final ao cliente",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 1.5).toStringAsFixed(2))
        ]
      ],
      headerIncluded: false,
    );

    String textoFinal = nomeDoProjeto +
        descricaoProjeto +
        responsavelPelaContagem +
        contagemDetalhada +
        "\nFunções de dados\n\n" +
        storeDetalhada.contagemDetalhadaValida.funcaoDados.join("\n\n") +
        "\nContribuição total das funções de dados: " +
        storeDetalhada.contagemDetalhadaValida.totalFuncaoDados.toString() +
        " PF\n\n" +
        "\nFunções transacionais\n\n" +
        storeDetalhada.contagemDetalhadaValida.funcaoTransacional.join("\n\n") +
        "\nContribuição total das funções transacionais: " +
        storeDetalhada.contagemDetalhadaValida.totalFuncaoTransacional
            .toString() +
        "\n\n1.3 Pontos de função não ajustados (brutos)\n\n" +
        "Tamanho funcional estimado = ${storeDetalhada.contagemDetalhadaValida.totalPf} PF" +
        "\n\n\t2. Parâmetros de entrada\n\n" +
        columns3.toString() +
        "\n\n\t3. Resumo por tipo de contagem\n\n" +
        colums4.toString() +
        "\n\n\t4. Estimativas baseadas na contagem Detalhada\n\n" +
        colums5.toString() +
        "\n\n\t5. Estimativas de Custo para contagem detalhada\n\n" +
        colums6.toString() +
        "\n\n\t6. Distribuição do custo, esforço e prazo por etapa\n\n" +
        linhaColuna.join("\n\n") +
        // columns7.toString() +
        "\n\n\t7. Orçamento do projeto para o cliente\n\n" +
        colum8.toString();

    return textoFinal;
  }

  static compartilharTextoEstimado(
      ProjetoEntitie projetoEntitie,
      storeEstimativaEsforco,
      storeEstimativaEquipe,
      storeEstimativaPrazo,
      storeEstimativaCusto,
      StoreContagemIndicativa storeIndicativa,
      StoreContagemEstimada storeEstimada,
      StoreContagemDetalhada storeDetalhada) {
    var esforcoDetalhada = null;
    var equipeDetalhada = null;
    var prazoDetalhado = null;
    var custoDetalhado = null;
    for (var element in storeEstimativaEsforco.esforcosValidos) {
      if (element.contagemPontoDeFuncao.contains("Estimada")) {
        esforcoDetalhada = element;
      }
    }

    for (var element in storeEstimativaEquipe.equipesValidas) {
      if (element.contagemPontoDeFuncao.contains("Estimada")) {
        equipeDetalhada = element;
      }
    }

    for (var element in storeEstimativaPrazo.prazosValidos) {
      if (element.contagemPontoDeFuncao.contains("Estimada")) {
        prazoDetalhado = element;
      }
    }

    for (var element in storeEstimativaCusto.custosValidos) {
      if (element.tipoContagem.contains("Estimada")) {
        custoDetalhado = element;
      }
    }
    String descricao =
        projetoEntitie.descricao.isNotEmpty ? projetoEntitie.descricao : "";

    String nomeDoProjeto = 'Nome do projeto: ${projetoEntitie.nomeProjeto}\n';
    String descricaoProjeto = 'Descrição: $descricao\n';
    String responsavelPelaContagem =
        'Responsável pela contagem: ${Modular.get<UsuarioAutenticado>().store.nome}\n\n';

    String contagemDetalhada = "\t1. Contagem Estimativa\n\n";

    final columns3 = dolumnify(
      [
        ['Produtividade (H/PF)', esforcoDetalhada.produtividadeEquipe],
        ['Dias úteis no mês', "21"],
        ['Produtividade diária (horas/dia)', equipeDetalhada.producaoDiaria],
        [
          "Expoente t ${prazoDetalhado.tipoSistema}",
          storeEstimativaPrazo.buscarExpoenteT(prazoDetalhado.tipoSistema),
        ],
        [
          "Custo unitário (R\$/PF)",
          Formatadores.formatadorMonetario(custoDetalhado.custoPF)
        ]
      ],
      headerIncluded: false,
    );

    final colums4 = dolumnify([
      [
        'Tipo de contagem',
        'Tamanho (PF)',
        'Custo estimado',
      ],
      [
        "Indicativa",
        storeIndicativa.contagemIndicativaValida.totalPf.toString(),
        Formatadores.formatadorMonetario(
            (double.parse(custoDetalhado.custoPF) * storeIndicativa.totalPf)
                .toStringAsFixed(2)),
      ],
      [
        "Estimativa",
        storeEstimada.contagemEstimadaValida.totalPF.toString(),
        Formatadores.formatadorMonetario((double.parse(custoDetalhado.custoPF) *
                storeEstimada.contagemEstimadaValida.totalPF)
            .toStringAsFixed(2)),
      ],
      [
        "Detalhada",
        storeDetalhada.contagemDetalhadaValida.totalPf.toString(),
        Formatadores.formatadorMonetario((double.parse(custoDetalhado.custoPF) *
                storeDetalhada.contagemDetalhadaValida.totalPf)
            .toStringAsFixed(2)),
      ]
    ]);

    final colums5 = dolumnify([
      ['Esforço (horas)', esforcoDetalhada.esforcoTotal],
      ['Prazo (em meses)', (prazoDetalhado.prazoTotal / 30).toStringAsFixed(2)],
      [
        'Prazo (em semanas)',
        (prazoDetalhado.prazoTotal / 30 * 4).toStringAsFixed(2)
      ],
      ['Prazo (em dias)', prazoDetalhado.prazoTotal],
      [
        'Região do impossível (75%) (em semanas)',
        (double.parse(prazoDetalhado.prazoMinimo) / 30 * 4).toStringAsFixed(2)
      ],
      ['Tamanho da Equipe', equipeDetalhada.equipeEstimada],
      [
        'Valor do rateio de despesas para o projeto por mês',
        Formatadores.formatadorMonetario(custoDetalhado.custoTotalMensal)
      ],
    ]);

    final colums6 = dolumnify([
      ['Tamanho funcional (PF)', storeEstimada.contagemEstimadaValida.totalPF],
      [
        'Custo básico (CP)',
        Formatadores.formatadorMonetario(
            custoDetalhado.custoBasico.toStringAsFixed(2))
      ],
      [
        'Percentual de reserva técnica do projeto',
        custoDetalhado.porcentagemLucro + "%"
      ],
      [
        'Valor reserva técnica',
        Formatadores.formatadorMonetario(
            custoDetalhado.valorPorcentagem.toStringAsFixed(2))
      ],
      [
        'Custo + Reserva técnica',
        Formatadores.formatadorMonetario(
            (custoDetalhado.custoBasico + custoDetalhado.valorPorcentagem)
                .toStringAsFixed(2))
      ],
      [
        'Despesas Rateadas para o projeto durante o\n prazo do seu desenvolvimento',
        Formatadores.formatadorMonetario(
            custoDetalhado.despesasTotaisDurantePrazoProjeto.toStringAsFixed(2))
      ],
      [
        'Custo estimado total',
        Formatadores.formatadorMonetario(
            custoDetalhado.valorTotalProjeto.toStringAsFixed(2))
      ],
    ]);

    List<String> linhaColuna = [
      "Etapa: Requisitos\nPercentual: 25%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.25).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.25).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.25)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Design\nPercentual: 10%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.10).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.10).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.10)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Codificação\nPercentual: 40%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.40).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.40).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.40)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Testes\nPercentual: 15%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.15).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.15).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.15)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Homologação\nPercentual: 5%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.05).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.05)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Implantação\nPercentual: 5%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.05).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.05)).roundToDouble().toStringAsFixed(2)}\n\n"
    ];

    final colum8 = dolumnify(
      [
        [
          'Percentual de Lucro desejado',
          '50%',
        ],
        [
          "Lucro Esperado",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.5).toStringAsFixed(2))
        ],
        [
          "Preço final ao cliente",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 1.5).toStringAsFixed(2))
        ]
      ],
      headerIncluded: false,
    );

    int totalFuncaoDados = 0;
    for (var element in storeEstimada.contagemEstimadaValida.ali) {
      totalFuncaoDados += element.quantidadePF;
    }

    for (var element in storeEstimada.contagemEstimadaValida.aie) {
      totalFuncaoDados += element.quantidadePF;
    }

    int totalFunaoTransacional = 0;

    for (var element in storeEstimada.contagemEstimadaValida.ce) {
      totalFunaoTransacional += element.quantidadePF;
    }

    for (var element in storeEstimada.contagemEstimadaValida.ee) {
      totalFunaoTransacional += element.quantidadePF;
    }

    for (var element in storeEstimada.contagemEstimadaValida.se) {
      totalFunaoTransacional += element.quantidadePF;
    }

    String textoFinal = nomeDoProjeto +
        descricaoProjeto +
        responsavelPelaContagem +
        contagemDetalhada +
        "\nFunções de dados\n\n" +
        storeEstimada.contagemEstimadaValida.ali.join("\n") +
        storeEstimada.contagemEstimadaValida.aie.join("\n\n") +
        "\nContribuição total das funções de dados: " +
        totalFuncaoDados.toString() +
        " PF\n\n" +
        "\nFunções transacionais\n\n" +
        storeEstimada.contagemEstimadaValida.ce.join("\n") +
        storeEstimada.contagemEstimadaValida.ee.join("\n") +
        storeEstimada.contagemEstimadaValida.se.join("\n\n") +
        "\nContribuição total das funções transacionais: " +
        totalFunaoTransacional.toString() +
        "\n\n1.3 Pontos de função não ajustados (brutos)\n\n" +
        "Tamanho funcional estimado = ${storeEstimada.contagemEstimadaValida.totalPF} PF" +
        "\n\n\t2. Parâmetros de entrada\n\n" +
        columns3.toString() +
        "\n\n\t3. Resumo por tipo de contagem\n\n" +
        colums4.toString() +
        "\n\n\t4. Estimativas baseadas na contagem estimativa\n\n" +
        colums5.toString() +
        "\n\n\t5. Estimativas de Custo para contagem estimativa\n\n" +
        colums6.toString() +
        "\n\n\t6. Distribuição do custo, esforço e prazo por etapa\n\n" +
        linhaColuna.join("\n\n") +
        "\n\n\t7. Orçamento do projeto para o cliente\n\n" +
        colum8.toString();

    return textoFinal;
  }

  static compartilharTextoIndicativo(
      ProjetoEntitie projetoEntitie,
      storeEstimativaEsforco,
      storeEstimativaEquipe,
      storeEstimativaPrazo,
      storeEstimativaCusto,
      StoreContagemIndicativa storeIndicativa,
      StoreContagemEstimada storeEstimada,
      StoreContagemDetalhada storeDetalhada) {
    var esforcoDetalhada = null;
    var equipeDetalhada = null;
    var prazoDetalhado = null;
    var custoDetalhado = null;
    for (var element in storeEstimativaEsforco.esforcosValidos) {
      if (element.contagemPontoDeFuncao.contains("Indicativa")) {
        esforcoDetalhada = element;
      }
    }

    for (var element in storeEstimativaEquipe.equipesValidas) {
      if (element.contagemPontoDeFuncao.contains("Indicativa")) {
        equipeDetalhada = element;
      }
    }

    for (var element in storeEstimativaPrazo.prazosValidos) {
      if (element.contagemPontoDeFuncao.contains("Indicativa")) {
        prazoDetalhado = element;
      }
    }

    for (var element in storeEstimativaCusto.custosValidos) {
      if (element.tipoContagem.contains("Indicativa")) {
        custoDetalhado = element;
      }
    }
    String descricao =
        projetoEntitie.descricao.isNotEmpty ? projetoEntitie.descricao : "";

    String nomeDoProjeto = 'Nome do projeto: ${projetoEntitie.nomeProjeto}\n';
    String descricaoProjeto = 'Descrição: $descricao\n';
    String responsavelPelaContagem =
        'Responsável pela contagem: ${Modular.get<UsuarioAutenticado>().store.nome}\n\n';

    String contagemDetalhada = "\t1. Contagem Indicativa\n\n";

    final columns3 = dolumnify(
      [
        ['Produtividade (H/PF)', esforcoDetalhada.produtividadeEquipe],
        ['Dias úteis no mês', "21"],
        ['Produtividade diária (horas/dia)', equipeDetalhada.producaoDiaria],
        [
          "Expoente t ${prazoDetalhado.tipoSistema}",
          storeEstimativaPrazo.buscarExpoenteT(prazoDetalhado.tipoSistema),
        ],
        [
          "Custo unitário (R\$/PF)",
          Formatadores.formatadorMonetario(custoDetalhado.custoPF)
        ]
      ],
      headerIncluded: false,
    );

    final colums4 = dolumnify([
      [
        'Tipo de contagem',
        'Tamanho (PF)',
        'Custo estimado',
      ],
      [
        "Indicativa",
        storeIndicativa.contagemIndicativaValida.totalPf.toString(),
        Formatadores.formatadorMonetario(
            (double.parse(custoDetalhado.custoPF) * storeIndicativa.totalPf)
                .toStringAsFixed(2)),
      ],
      [
        "Estimativa",
        storeEstimada.contagemEstimadaValida.totalPF.toString(),
        Formatadores.formatadorMonetario((double.parse(custoDetalhado.custoPF) *
                storeEstimada.contagemEstimadaValida.totalPF)
            .toStringAsFixed(2)),
      ],
      [
        "Detalhada",
        storeDetalhada.contagemDetalhadaValida.totalPf.toString(),
        Formatadores.formatadorMonetario((double.parse(custoDetalhado.custoPF) *
                storeDetalhada.contagemDetalhadaValida.totalPf)
            .toStringAsFixed(2)),
      ]
    ]);

    final colums5 = dolumnify([
      ['Esforço (horas)', esforcoDetalhada.esforcoTotal],
      ['Prazo (em meses)', (prazoDetalhado.prazoTotal / 30).toStringAsFixed(2)],
      [
        'Prazo (em semanas)',
        (prazoDetalhado.prazoTotal / 30 * 4).toStringAsFixed(2)
      ],
      ['Prazo (em dias)', prazoDetalhado.prazoTotal],
      [
        'Região do impossível (75%) (em semanas)',
        (double.parse(prazoDetalhado.prazoMinimo) / 30 * 4).toStringAsFixed(2)
      ],
      ['Tamanho da Equipe', equipeDetalhada.equipeEstimada],
      [
        'Valor do rateio de despesas para o projeto por mês',
        Formatadores.formatadorMonetario(
            Formatadores.formatadorMonetario(custoDetalhado.custoTotalMensal))
      ],
    ]);

    final colums6 = dolumnify([
      [
        'Tamanho funcional (PF)',
        storeIndicativa.contagemIndicativaValida.totalPf
      ],
      [
        'Custo básico (CP)',
        Formatadores.formatadorMonetario(
            custoDetalhado.custoBasico.toStringAsFixed(2))
      ],
      [
        'Percentual de reserva técnica do projeto',
        custoDetalhado.porcentagemLucro + "%"
      ],
      [
        'Valor reserva técnica',
        Formatadores.formatadorMonetario(
            custoDetalhado.valorPorcentagem.toStringAsFixed(2))
      ],
      [
        'Custo + Reserva técnica',
        Formatadores.formatadorMonetario(
            (custoDetalhado.custoBasico + custoDetalhado.valorPorcentagem)
                .toStringAsFixed(2))
      ],
      [
        'Despesas Rateadas para o projeto durante o\n prazo do seu desenvolvimento',
        Formatadores.formatadorMonetario(
            custoDetalhado.despesasTotaisDurantePrazoProjeto.toStringAsFixed(2))
      ],
      [
        'Custo estimado total',
        Formatadores.formatadorMonetario(
            custoDetalhado.valorTotalProjeto.toStringAsFixed(2))
      ],
    ]);

    List<String> linhaColuna = [
      "Etapa: Requisitos\nPercentual: 25%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.25).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.25).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.25)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Design\nPercentual: 10%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.10).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.10).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.10)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Codificação\nPercentual: 40%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.40).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.40).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.40)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Testes\nPercentual: 15%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.15).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.15).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.15)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Homologação\nPercentual: 5%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.05).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.05)).roundToDouble().toStringAsFixed(2)}\n\n"
          "Etapa: Implantação\nPercentual: 5%\nR\$/Etapa: ${Formatadores.formatadorMonetario((custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2))}\nEsforço(horas)/Etapa: ${(double.parse(esforcoDetalhada.esforcoTotal) * 0.05).toStringAsFixed(2)}\nDias/Etapa: ${((prazoDetalhado.prazoTotal * 0.05)).roundToDouble().toStringAsFixed(2)}\n\n"
    ];

    final colum8 = dolumnify(
      [
        [
          'Percentual de Lucro desejado',
          '50%',
        ],
        [
          "Lucro Esperado",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.5).toStringAsFixed(2))
        ],
        [
          "Preço final ao cliente",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 1.5).toStringAsFixed(2))
        ]
      ],
      headerIncluded: false,
    );

    int totalFuncaoDados = 0;
    for (var element in storeIndicativa.contagemIndicativaValida.ali) {
      totalFuncaoDados += element.quantidadePF;
    }

    for (var element in storeIndicativa.contagemIndicativaValida.aie) {
      totalFuncaoDados += element.quantidadePF;
    }

    String textoFinal = nomeDoProjeto +
        descricaoProjeto +
        responsavelPelaContagem +
        contagemDetalhada +
        "\nFunções de dados\n\n" +
        storeIndicativa.contagemIndicativaValida.ali.join("\n") +
        storeIndicativa.contagemIndicativaValida.aie.join("\n\n") +
        "\nContribuição total das funções de dados: " +
        totalFuncaoDados.toString() +
        " PF\n\n" +
        "\n\n1.3 Pontos de função não ajustados (brutos)\n\n" +
        "Tamanho funcional estimado = ${storeIndicativa.contagemIndicativaValida.totalPf} PF" +
        "\n\n\t2. Parâmetros de entrada\n\n" +
        columns3.toString() +
        "\n\n\t3. Resumo por tipo de contagem\n\n" +
        colums4.toString() +
        "\n\n\t4. Estimativas baseadas na contagem indicativa\n\n" +
        colums5.toString() +
        "\n\n\t5. Estimativas de Custo para contagem indicativa\n\n" +
        colums6.toString() +
        "\n\n\t6. Distribuição do custo, esforço e prazo por etapa\n\n" +
        linhaColuna.join("\n\n") +
        "\n\n\t7. Orçamento do projeto para o cliente\n\n" +
        colum8.toString();

    return textoFinal;
  }
}
