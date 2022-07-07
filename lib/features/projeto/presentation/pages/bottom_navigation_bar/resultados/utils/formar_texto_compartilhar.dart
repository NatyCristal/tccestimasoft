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
  static compartilharTexto(
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

    String nomeDoProjeto = 'Nome do projeto: ${projetoEntitie.nomeProjeto}\n';
    String descricaoProjeto = 'Descrição: ${projetoEntitie.descricao}\n';
    String responsavelPelaContagem =
        'Responsável pela contagem: ${Modular.get<UsuarioAutenticado>().store.nome}\n\n';

    String contagemDetalhada = "\t1. Contagem Detalhada\n\n";
    String funcoesDeDados = "1.1 Funções de dados\n\n";

    // List<List<String>> dadosFuncoes = [];
    // dadosFuncoes.add([
    //   'Tipo',
    //   'Nome',
    //   'Descrição',
    //   '#TRs',
    //   '#TDs',
    //   'Complexidade',
    //   'Contribuição',
    // ]);

    // for (var element in storeDetalhada.contagemDetalhadaValida.funcaoDados) {
    //   dadosFuncoes.add([
    //     element.tipo,
    //     element.nome,
    //     element.descricao,
    //     element.quantidadeTrsEArs.toString(),
    //     element.quantidadeTDs.toString(),
    //     element.complexidade,
    //     element.pontoDeFuncao.toString(),
    //   ]);
    // }

    final _dadosFuncaoDeDados =
        storeDetalhada.contagemDetalhadaValida.funcaoDados.map((item) {
      storeDetalhada.contagemDetalhadaValida.totalFuncaoDados.toString() +
          " PF";

      return [
        item.tipo,
        item.nome,
        item.descricao,
        item.quantidadeTrsEArs,
        item.quantidadeTDs,
        item.complexidade,
        item.pontoDeFuncao.toString() + " PF"
      ];
    }).toList();

    // dadosFuncoes.add([
    //   "Contribuição Total: " +
    //       storeDetalhada.contagemDetalhadaValida.totalFuncaoDados.toString() +
    //       " PF"
    // ]);

    String funcaoTransacional = "\n\n1.2 Funções Transacionais\n\n";

    List<List<String>> funcoesTransacionais = [];
    funcoesTransacionais.add([
      'Tipo',
      'Nome',
      'Descrição',
      '#ARs',
      '#TDs',
      'Complexidade',
      'Contribuição',
    ]);

    for (var element
        in storeDetalhada.contagemDetalhadaValida.funcaoTransacional) {
      funcoesTransacionais.add([
        element.tipo,
        element.nome,
        element.descricao,
        element.quantidadeTrsEArs.toString(),
        element.quantidadeTDs.toString(),
        element.complexidade,
        element.pontoDeFuncao.toString(),
      ]);
    }

    funcoesTransacionais.add([
      "Contribuição Total: " +
          storeDetalhada.contagemDetalhadaValida.totalFuncaoTransacional
              .toString() +
          " PF"
    ]);

    // final columns = dolumnify(
    //   dadosFuncoes,
    //   columnSplitter: ' | ',
    //   headerIncluded: true,
    //   headerSeparator: '=',
    // );

    final columns2 = dolumnify(
      funcoesTransacionais,
      columnSplitter: ' | ',
      headerIncluded: true,
      headerSeparator: '=',
    );

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
        "Estimada",
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
      ['Prazo (em meses)', prazoDetalhado.prazoTotal / 30],
      ['Prazo (em semanas)', prazoDetalhado.prazoTotal / 30 * 4],
      ['Prazo (em dias)', prazoDetalhado.prazoTotal],
      [
        'Região do impossível (75%) (em semanas)',
        double.parse(prazoDetalhado.prazoMinimo) / 4
      ],
      ['Tamanho da Equipe', equipeDetalhada.equipeEstimada],
      [
        'Valor do rateio de despesas para o projeto por mês',
        Formatadores.formatadorMonetario(
            custoDetalhado.despesasTotaisDurantePrazoProjeto.toStringAsFixed(2))
      ],
    ]);

    final colums6 = dolumnify([
      [
        'Tamanho funcional (PF)',
        storeDetalhada.contagemDetalhadaValida.totalPf
      ],
      ['Custo básico (CP)', custoDetalhado.custoBasico],
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
        'Despesas Rateadas para o projeto furante o\n prazo do seu desenvolvimento',
        Formatadores.formatadorMonetario(
            custoDetalhado.despesasTotaisDurantePrazoProjeto.toStringAsFixed(2))
      ],
      [
        'Custo estimado total',
        Formatadores.formatadorMonetario(
            custoDetalhado.valorTotalProjeto.toStringAsFixed(2))
      ],
    ]);

    final columns7 = dolumnify(
      [
        [
          'Etapa',
          'Percentual',
          'R\$/Etapa',
          'Esforço(horas)/Etapa',
          'Semanas/Etapa',
        ],
        [
          "Requisitos",
          "25%",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.25).toStringAsFixed(2)),
          (double.parse(esforcoDetalhada.esforcoTotal) * 0.25)
              .toStringAsFixed(2),
          (prazoDetalhado.prazoTotal / 30 * 0.25 * 4).toStringAsFixed(2)
        ],
        [
          "Design",
          "10%",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.10).toStringAsFixed(2)),
          (double.parse(esforcoDetalhada.esforcoTotal) * 0.10)
              .toStringAsFixed(2),
          (prazoDetalhado.prazoTotal / 30 * 0.10 * 4).toStringAsFixed(2)
        ],
        [
          "Codificação",
          "40%",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.40).toStringAsFixed(2)),
          (double.parse(esforcoDetalhada.esforcoTotal) * 0.40)
              .toStringAsFixed(2),
          (prazoDetalhado.prazoTotal / 30 * 0.40 * 4).toStringAsFixed(2)
        ],
        [
          "Testes",
          "15%",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.15).toStringAsFixed(2)),
          (double.parse(esforcoDetalhada.esforcoTotal) * 0.15)
              .toStringAsFixed(2),
          (prazoDetalhado.prazoTotal / 30 * 0.15 * 4).toStringAsFixed(2)
        ],
        [
          "Homologação",
          "5%",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2)),
          (double.parse(esforcoDetalhada.esforcoTotal) * 0.05)
              .toStringAsFixed(2),
          (prazoDetalhado.prazoTotal / 30 * 0.050 * 4).toStringAsFixed(2)
        ],
        [
          "Implantação",
          "5%",
          Formatadores.formatadorMonetario(
              (custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2)),
          (double.parse(esforcoDetalhada.esforcoTotal) * 0.05)
              .toStringAsFixed(2),
          (prazoDetalhado.prazoTotal / 30 * 0.050 * 4).toStringAsFixed(2)
        ]
      ],
      columnSplitter: ' | ',
      headerIncluded: true,
      headerSeparator: '=',
    );

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
        storeDetalhada.contagemDetalhadaValida.funcaoDados.join("\n\n") +
        "\nContribuição total das funções de dados: " +
        storeDetalhada.contagemDetalhadaValida.totalFuncaoDados.toString() +
        " PF\n\n" +
        storeDetalhada.contagemDetalhadaValida.funcaoTransacional.join("\n\n") +
        "\nContribuição total das funções transacionais: " +
        storeDetalhada.contagemDetalhadaValida.totalFuncaoTransacional
            .toString() +
        // columns2.toString() +
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
        "\n\n\t6. Distribuição do custom esforço e prazo por etapa\n\n" +
        columns7.toString() +
        "\n\n\t7. Orçamento do projeto para o cliente\n\n" +
        colum8.toString();

    return textoFinal;
  }
}
