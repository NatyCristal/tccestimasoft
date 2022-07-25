// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/pdf/construtor_pdf.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../../../core/auth/usuario_autenticado.dart';
import '../../../../../../../core/shared/utils/cores_fontes.dart';
import '../../../../../../../core/shared/utils/formatadores.dart';

class GeradorPdf {
  final StoreContagemDetalhada _storeDetalhada;
  final StoreContagemEstimada _storeEstimada;
  final StoreContagemIndicativa _storeIndicativa;

  final StoreEstimativaEsforco _storeEsforco;
  final StoreEstimativaPrazo _storePrazo;
  final StoreEstimativaEquipe _storeEquipe;
  final StoreEstimativaCusto _storeCusto;

  late String data;
  late var imageAsset;
  late var _dadosFuncaoDeDados;
  late var _dadosFuncaoTransacional;
  late final _esforcoDetalhado;
  late final _prazoDetalhado;
  late final _equipeDetalhada;
  late final _custoDetalhado;

  int valorTotalTransacionalEstimada = 0;

  GeradorPdf(
      this._storeDetalhada,
      this._storeEstimada,
      this._storeIndicativa,
      this._storeEsforco,
      this._storePrazo,
      this._storeEquipe,
      this._storeCusto);

  gerarDocumentDetalhada(ProjetoEntitie projeto) async {
    await prepararDocumentoDetalhada();

    final pdf = pw.Document();

    Map<int, pw.FixedColumnWidth> mapTabela1 = {
      0: const pw.FixedColumnWidth(100),
      1: const pw.FixedColumnWidth(200),
      2: const pw.FixedColumnWidth(250),
      3: const pw.FixedColumnWidth(120),
      4: const pw.FixedColumnWidth(120),
      5: const pw.FixedColumnWidth(160),
      6: const pw.FixedColumnWidth(240),
    };

    Map<int, pw.FixedColumnWidth> mapTabela2 = {
      0: const pw.FixedColumnWidth(100),
      1: const pw.FixedColumnWidth(200),
      2: const pw.FixedColumnWidth(250),
      3: const pw.FixedColumnWidth(120),
      4: const pw.FixedColumnWidth(120),
      5: const pw.FixedColumnWidth(160),
      6: const pw.FixedColumnWidth(240),
    };

    Map<int, pw.FixedColumnWidth> mapTabela3 = {};
    Map<int, pw.FixedColumnWidth> mapTabela4 = {};

    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Header(child: ConstrutorPdf.cabecalho(data, imageAsset)),
        ConstrutorPdf.linha("Nome do projeto: ", projeto.nomeProjeto),
        ConstrutorPdf.linha("Descrição: ", projeto.descricao),
        ConstrutorPdf.linha("Responsável pela contagem: ",
            Modular.get<UsuarioAutenticado>().store.nome),
        ConstrutorPdf.tituloSessao("1. Contagem detalhada"),
        ConstrutorPdf.subtitulo("1.1. Função de Dados"),
        ConstrutorPdf.tabela([
          'Tipo',
          'Função',
          'Descrição',
          '# TRs',
          '# TDs',
          'Complex.',
          'Contribuição',
        ], _dadosFuncaoDeDados, mapTabela1),
        ConstrutorPdf.totalTabela(
            "Contribuição total das funções de dados: ",
            _storeDetalhada.contagemDetalhadaValida.totalFuncaoDados
                    .toString() +
                " PF"),
        ConstrutorPdf.subtitulo('1.2. Funções Transacionais'),
        ConstrutorPdf.tabela([
          'Tipo',
          'Função',
          'Descrição',
          '# ARs ',
          '# TDs',
          'Complex.',
          'Contribuição',
        ], _dadosFuncaoTransacional, mapTabela2),
        ConstrutorPdf.totalTabela(
            "Contribuição total das funções transacionais: ",
            _storeDetalhada.contagemDetalhadaValida.totalFuncaoTransacional
                    .toString() +
                " PF"),
        ConstrutorPdf.subtitulo(
            "1.3. Pontos de Função não ajustados (brutos)'"),
        ConstrutorPdf.linhaComun(
            "Tamanho funcional estimado ${_storeDetalhada.contagemDetalhadaValida.totalPf} PF"),
        ConstrutorPdf.tituloSessao('2. Parâmetros de entrada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            ['Produtividade (H/PF)', _esforcoDetalhado.produtividadeEquipe],
            ['Dias úteis no mês', "21"],
            [
              'Produtividade diária (horas/dia)',
              _equipeDetalhada.producaoDiaria
            ],
            [
              "Expoente t ${_prazoDetalhado.tipoSistema}",
              _storePrazo
                  .buscarExpoenteT(_prazoDetalhado.tipoSistema)
                  .toStringAsFixed(2),
            ],
            [
              "Custo unitário (R\$/PF)",
              Formatadores.formatadorMonetario(_custoDetalhado.custoPF)
            ]
          ],
        ),
        ConstrutorPdf.tituloSessao('3. Resumo por tipo de contagem'),
        ConstrutorPdf.tabela([
          'Tipo de contagem',
          'Tamanho (PF)',
          'Custo estimado',
        ], [
          [
            "Indicativa",
            _storeIndicativa.contagemIndicativaValida.totalPf.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeIndicativa.totalPf)
                    .toStringAsFixed(2)),
          ],
          [
            "Estimada",
            _storeEstimada.contagemEstimadaValida.totalPF.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeEstimada.contagemEstimadaValida.totalPF)
                    .toStringAsFixed(2)),
          ],
          [
            "Detalhada",
            _storeDetalhada.contagemDetalhadaValida.totalPf.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeDetalhada.contagemDetalhadaValida.totalPf)
                    .toStringAsFixed(2)),
          ]
        ], mapTabela3),
        ConstrutorPdf.tituloSessao(
            '4. Estimativas baseadas na contagem Detalhada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            ['Esforço (horas)', _esforcoDetalhado.esforcoTotal],
            [
              'Prazo (em meses)',
              (_prazoDetalhado.prazoTotal / 30).toStringAsFixed(2)
            ],
            [
              'Prazo (em semanas)',
              (_prazoDetalhado.prazoTotal / 30 * 4).toStringAsFixed(2)
            ],
            ['Prazo (em dias)', _prazoDetalhado.prazoTotal],
            [
              'Região do impossível (75%) (em semanas)',
              (double.parse(_prazoDetalhado.prazoMinimo) / 30 * 4)
                  .toStringAsFixed(2)
            ],
            ['Tamanho da Equipe', _equipeDetalhada.equipeEstimada],
            [
              'Valor do rateio de despesas para o projeto por mês',
              Formatadores.formatadorMonetario(_custoDetalhado.custoTotalMensal)
            ],
          ],
        ),
        ConstrutorPdf.tituloSessao(
            '5. Estimativas de Custo para contagem Detalhada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            [
              'Tamanho funcional (PF)',
              _storeDetalhada.contagemDetalhadaValida.totalPf
            ],
            [
              'Custo básico (CP)',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.custoBasico.toStringAsFixed(2))
            ],
            [
              'Percentual de reserva técnica do projeto',
              _custoDetalhado.porcentagemLucro + "%"
            ],
            [
              'Valor reserva técnica',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.valorPorcentagem.toStringAsFixed(2))
            ],
            [
              'Custo + Reserva técnica',
              Formatadores.formatadorMonetario((_custoDetalhado.custoBasico +
                      _custoDetalhado.valorPorcentagem)
                  .toStringAsFixed(2))
            ],
            [
              'Despesas Rateadas para o projeto durante o\n prazo do seu desenvolvimento',
              Formatadores.formatadorMonetario(_custoDetalhado
                  .despesasTotaisDurantePrazoProjeto
                  .toStringAsFixed(2))
            ],
            [
              'Custo estimado total',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.valorTotalProjeto.toStringAsFixed(2))
            ],
          ],
        ),
        ConstrutorPdf.tituloSessao(
            '6. Distribuição do custo, esforço e prazo por etapa'),
        ConstrutorPdf.tabela([
          'Etapa',
          'Percentual',
          'R\$/Etapa',
          'Esforço(horas)/Etapa',
          'Dias/Etapa',
        ], [
          [
            "Requisitos",
            "25%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.25).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.25)
                .toStringAsFixed(2),
            ((_prazoDetalhado.prazoTotal * 0.25).roundToDouble())
                .toStringAsFixed(2)
          ],
          [
            "Design",
            "10%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.10).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.10)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.10)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Codificação",
            "40%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.40).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.40)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.40)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Testes",
            "15%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.15).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.15)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.15)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Homologação",
            "5%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.05)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.050)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Implantação",
            "5%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.05)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.050)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
        ], mapTabela4),
        ConstrutorPdf.tituloSessao('7. Orçamento do projeto para o cliente'),
        ConstrutorPdf.tabelaSemTitulo([
          [],
          [
            'Percentual de Lucro desejado',
            '50%',
          ],
          [
            "Lucro Esperado",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.5).toStringAsFixed(2))
          ],
          [
            "Preço final ao cliente",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 1.5).toStringAsFixed(2))
          ]
        ]),
        pw.Column(children: [
          pw.SizedBox(height: 30),
          pw.Text("Referências",
              style: pw.TextStyle(
                  color: PdfColor.fromInt(
                    corCorpoTexto.value,
                  ),
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text(
              "Ministério do Planejamento, Desenvolvimento e Gestão (org.). Roteiro de Métricas de Software do SISP. 2.3 Brasília, 2018. Disponível em: https://www.gov.br/governodigital/pt-br/sisp/documentos/roteiro-de-metricas-de-software-do-sisp. Acesso em: 19 nov. 2021."),
        ]),
        pw.SizedBox(height: 100),
      ];
    }, footer: (context) {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Divider(),
            pw.Text(
              "Elaborado por EstimaSoft",
            )
          ]);
    }));

    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${projeto.nomeProjeto}_hhmmss.pdf');

    await file.writeAsBytes(bytes);

    final url = file.path;

    await OpenFile.open(url);
  }

  prepararDocumentoDetalhada() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(now);

    data = formattedDate.toString();
    imageAsset = pw.MemoryImage(
      (await rootBundle.load(
        'assets/imagens/logo_estatica.png',
      ))
          .buffer
          .asUint8List(),
    );

    _dadosFuncaoDeDados =
        _storeDetalhada.contagemDetalhadaValida.funcaoDados.map((item) {
      _storeDetalhada.contagemDetalhadaValida.totalFuncaoDados.toString() +
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

    _dadosFuncaoTransacional =
        _storeDetalhada.contagemDetalhadaValida.funcaoTransacional.map((item) {
      _storeDetalhada.contagemDetalhadaValida.totalFuncaoDados.toString() +
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

    _esforcoDetalhado = _storeEsforco.esforcosValidos.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Detalhada"));

    _equipeDetalhada = _storeEquipe.equipesValidas.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Detalhada"));

    _prazoDetalhado = _storePrazo.prazosValidos.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Detalhada"));

    _custoDetalhado = _storeCusto.custosValidos
        .singleWhere((element) => element.tipoContagem.contains("Detalhada"));
  }

  gerarDocumentoIndicativa(ProjetoEntitie projeto) async {
    await prepararDocumentoIndicativa();

    final pdf = pw.Document();

    Map<int, pw.FixedColumnWidth> mapTabela1 = {
      0: const pw.FixedColumnWidth(100),
      1: const pw.FixedColumnWidth(200),
      2: const pw.FixedColumnWidth(250),
      3: const pw.FixedColumnWidth(120),
      4: const pw.FixedColumnWidth(120),
      5: const pw.FixedColumnWidth(160),
      6: const pw.FixedColumnWidth(240),
    };

    Map<int, pw.FixedColumnWidth> mapTabela3 = {};
    Map<int, pw.FixedColumnWidth> mapTabela4 = {};

    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Header(child: ConstrutorPdf.cabecalho(data, imageAsset)),
        ConstrutorPdf.linha("Nome do projeto: ", projeto.nomeProjeto),
        ConstrutorPdf.linha("Descrição: ", projeto.descricao),
        ConstrutorPdf.linha("Responsável pela contagem: ",
            Modular.get<UsuarioAutenticado>().store.nome),
        ConstrutorPdf.tituloSessao("1. Contagem indicativa"),
        ConstrutorPdf.subtitulo("1.1. Função de Dados"),
        ConstrutorPdf.tabela([
          'Tipo',
          'Função',
          'Descrição',
          'Contribuição',
        ], _dadosFuncaoDeDados, mapTabela1),
        ConstrutorPdf.totalTabela(
            "Contribuição total das funções de dados: ",
            _storeIndicativa.contagemIndicativaValida.totalPf.toString() +
                " PF"),
        ConstrutorPdf.subtitulo(
            "1.2. Pontos de Função não ajustados (brutos)'"),
        ConstrutorPdf.linhaComun(
            "Tamanho funcional estimado ${_storeIndicativa.contagemIndicativaValida.totalPf} PF"),
        ConstrutorPdf.tituloSessao('2. Parâmetros de entrada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            ['Produtividade (H/PF)', _esforcoDetalhado.produtividadeEquipe],
            ['Dias úteis no mês', "21"],
            [
              'Produtividade diária (horas/dia)',
              _equipeDetalhada.producaoDiaria
            ],
            [
              "Expoente t ${_prazoDetalhado.tipoSistema}",
              _storePrazo
                  .buscarExpoenteT(_prazoDetalhado.tipoSistema)
                  .toStringAsFixed(2),
            ],
            [
              "Custo unitário (R\$/PF)",
              Formatadores.formatadorMonetario(_custoDetalhado.custoPF)
            ]
          ],
        ),
        ConstrutorPdf.tituloSessao('3. Resumo por tipo de contagem'),
        ConstrutorPdf.tabela([
          'Tipo de contagem',
          'Tamanho (PF)',
          'Custo estimado',
        ], [
          [
            "Indicativa",
            _storeIndicativa.contagemIndicativaValida.totalPf.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeIndicativa.totalPf)
                    .toStringAsFixed(2)),
          ],
          [
            "Estimada",
            _storeEstimada.contagemEstimadaValida.totalPF.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeEstimada.contagemEstimadaValida.totalPF)
                    .toStringAsFixed(2)),
          ],
          [
            "Detalhada",
            _storeDetalhada.contagemDetalhadaValida.totalPf.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeDetalhada.contagemDetalhadaValida.totalPf)
                    .toStringAsFixed(2)),
          ]
        ], mapTabela3),
        ConstrutorPdf.tituloSessao(
            '4. Estimativas baseadas na contagem Indicativa'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            ['Esforço (horas)', _esforcoDetalhado.esforcoTotal],
            [
              'Prazo (em meses)',
              (_prazoDetalhado.prazoTotal / 30).toStringAsFixed(2)
            ],
            [
              'Prazo (em semanas)',
              (_prazoDetalhado.prazoTotal / 30 * 4).toStringAsFixed(2)
            ],
            ['Prazo (em dias)', _prazoDetalhado.prazoTotal],
            [
              'Região do impossível (75%) (em semanas)',
              (double.parse(_prazoDetalhado.prazoMinimo) / 30 * 4)
                  .toStringAsFixed(2)
            ],
            ['Tamanho da Equipe', _equipeDetalhada.equipeEstimada],
            [
              'Valor do rateio de despesas para o projeto por mês',
              Formatadores.formatadorMonetario(_custoDetalhado.custoTotalMensal)
            ],
          ],
        ),
        ConstrutorPdf.tituloSessao(
            '5. Estimativas de Custo para contagem Indicativa'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            [
              'Tamanho funcional (PF)',
              _storeIndicativa.contagemIndicativaValida.totalPf
            ],
            [
              'Custo básico (CP)',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.custoBasico.toStringAsFixed(2))
            ],
            [
              'Percentual de reserva técnica do projeto',
              _custoDetalhado.porcentagemLucro + "%"
            ],
            [
              'Valor reserva técnica',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.valorPorcentagem.toStringAsFixed(2))
            ],
            [
              'Custo + Reserva técnica',
              Formatadores.formatadorMonetario((_custoDetalhado.custoBasico +
                      _custoDetalhado.valorPorcentagem)
                  .toStringAsFixed(2))
            ],
            [
              'Despesas Rateadas para o projeto durante o\n prazo do seu desenvolvimento',
              Formatadores.formatadorMonetario(_custoDetalhado
                  .despesasTotaisDurantePrazoProjeto
                  .toStringAsFixed(2))
            ],
            [
              'Custo estimado total',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.valorTotalProjeto.toStringAsFixed(2))
            ],
          ],
        ),
        ConstrutorPdf.tituloSessao(
            '6. Distribuição do custo, esforço e prazo por etapa'),
        ConstrutorPdf.tabela([
          'Etapa',
          'Percentual',
          'R\$/Etapa',
          'Esforço(horas)/Etapa',
          'Dias/Etapa',
        ], [
          [
            "Requisitos",
            "25%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.25).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.25)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.25)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Design",
            "10%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.10).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.10)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.10)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Codificação",
            "40%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.40).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.40)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.40)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Testes",
            "15%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.15).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.15)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.15)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Homologação",
            "5%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.05)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.050)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Implantação",
            "5%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.05)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.050)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
        ], mapTabela4),
        ConstrutorPdf.tituloSessao('7. Orçamento do projeto para o cliente'),
        ConstrutorPdf.tabelaSemTitulo([
          [],
          [
            'Percentual de Lucro desejado',
            '50%',
          ],
          [
            "Lucro Esperado",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.5).toStringAsFixed(2))
          ],
          [
            "Preço final ao cliente",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 1.5).toStringAsFixed(2))
          ]
        ]),
        pw.Column(children: [
          pw.SizedBox(height: 30),
          pw.Text("Referências",
              style: pw.TextStyle(
                  color: PdfColor.fromInt(
                    corCorpoTexto.value,
                  ),
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text(
              "Ministério do Planejamento, Desenvolvimento e Gestão (org.). Roteiro de Métricas de Software do SISP. 2.3 Brasília, 2018. Disponível em: https://www.gov.br/governodigital/pt-br/sisp/documentos/roteiro-de-metricas-de-software-do-sisp. Acesso em: 19 nov. 2021."),
        ]),
        pw.SizedBox(height: 100),
      ];
    }, footer: (context) {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Divider(),
            pw.Text(
              "Elaborado por EstimaSoft",
            )
          ]);
    }));

    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${projeto.nomeProjeto}_hhmmss.pdf');

    await file.writeAsBytes(bytes);

    final url = file.path;

    await OpenFile.open(url);
  }

  prepararDocumentoIndicativa() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(now);

    data = formattedDate.toString();
    imageAsset = pw.MemoryImage(
      (await rootBundle.load(
        'assets/imagens/logo_estatica.png',
      ))
          .buffer
          .asUint8List(),
    );

    var aie = _storeIndicativa.contagemIndicativaValida.aie.map((item) {
      return [
        item.tipoFuncao,
        item.nomeFuncao,
        item.descricao,
        item.quantidadePF.toString() + " PF"
      ];
    }).toList();
    var ali = _storeIndicativa.contagemIndicativaValida.ali.map((item) {
      return [
        item.tipoFuncao,
        item.nomeFuncao,
        item.descricao,
        item.quantidadePF.toString() + " PF"
      ];
    }).toList();

    _dadosFuncaoDeDados = ali.toList() + aie.toList();
    _esforcoDetalhado = _storeEsforco.esforcosValidos.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Indicativa"));

    _equipeDetalhada = _storeEquipe.equipesValidas.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Indicativa"));

    _prazoDetalhado = _storePrazo.prazosValidos.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Indicativa"));

    _custoDetalhado = _storeCusto.custosValidos
        .singleWhere((element) => element.tipoContagem.contains("Indicativa"));
  }

  gerarDocumentoEstimado(ProjetoEntitie projeto) async {
    await prepararDocumentoEstimado();

    final pdf = pw.Document();

    Map<int, pw.FixedColumnWidth> mapTabela1 = {
      0: const pw.FixedColumnWidth(100),
      1: const pw.FixedColumnWidth(200),
      2: const pw.FixedColumnWidth(250),
      3: const pw.FixedColumnWidth(120),
      4: const pw.FixedColumnWidth(120),
      5: const pw.FixedColumnWidth(160),
      6: const pw.FixedColumnWidth(240),
    };

    Map<int, pw.FixedColumnWidth> mapTabela2 = {
      0: const pw.FixedColumnWidth(100),
      1: const pw.FixedColumnWidth(200),
      2: const pw.FixedColumnWidth(250),
      3: const pw.FixedColumnWidth(120),
      4: const pw.FixedColumnWidth(120),
      5: const pw.FixedColumnWidth(160),
      6: const pw.FixedColumnWidth(240),
    };

    Map<int, pw.FixedColumnWidth> mapTabela3 = {};
    Map<int, pw.FixedColumnWidth> mapTabela4 = {};

    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Header(child: ConstrutorPdf.cabecalho(data, imageAsset)),
        ConstrutorPdf.linha("Nome do projeto: ", projeto.nomeProjeto),
        ConstrutorPdf.linha("Descrição: ", projeto.descricao),
        ConstrutorPdf.linha("Responsável pela contagem: ",
            Modular.get<UsuarioAutenticado>().store.nome),
        ConstrutorPdf.tituloSessao("1. Contagem estimada"),
        ConstrutorPdf.subtitulo("1.1. Função de Dados"),
        ConstrutorPdf.tabela([
          'Tipo',
          'Função',
          'Descrição',
          'Complex.',
          'Contribuição',
        ], _dadosFuncaoDeDados, mapTabela1),
        ConstrutorPdf.totalTabela(
            "Contribuição total das funções de dados: ",
            _storeIndicativa.contagemIndicativaValida.totalPf.toString() +
                " PF"),
        ConstrutorPdf.subtitulo('1.2. Funções Transacionais'),
        ConstrutorPdf.tabela([
          'Tipo',
          'Função',
          'Descrição',
          'Complex.',
          'Contribuição',
        ], _dadosFuncaoTransacional, mapTabela2),
        ConstrutorPdf.totalTabela(
            "Contribuição total das funções transacionais: ",
            valorTotalTransacionalEstimada.toString() + " PF"),
        ConstrutorPdf.subtitulo(
            "1.3. Pontos de Função não ajustados (brutos)'"),
        ConstrutorPdf.linhaComun(
            "Tamanho funcional estimado ${_storeEstimada.contagemEstimadaValida.totalPF} PF"),
        ConstrutorPdf.tituloSessao('2. Parâmetros de entrada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            ['Produtividade (H/PF)', _esforcoDetalhado.produtividadeEquipe],
            ['Dias úteis no mês', "21"],
            [
              'Produtividade diária (horas/dia)',
              _equipeDetalhada.producaoDiaria
            ],
            [
              "Expoente t ${_prazoDetalhado.tipoSistema}",
              _storePrazo.buscarExpoenteT(_prazoDetalhado.tipoSistema),
            ],
            [
              "Custo unitário (R\$/PF)",
              Formatadores.formatadorMonetario(_custoDetalhado.custoPF)
            ]
          ],
        ),
        ConstrutorPdf.tituloSessao('3. Resumo por tipo de contagem'),
        ConstrutorPdf.tabela([
          'Tipo de contagem',
          'Tamanho (PF)',
          'Custo estimado',
        ], [
          [
            "Indicativa",
            _storeIndicativa.contagemIndicativaValida.totalPf.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeIndicativa.totalPf)
                    .toStringAsFixed(2)),
          ],
          [
            "Estimada",
            _storeEstimada.contagemEstimadaValida.totalPF.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeEstimada.contagemEstimadaValida.totalPF)
                    .toStringAsFixed(2)),
          ],
          [
            "Detalhada",
            _storeDetalhada.contagemDetalhadaValida.totalPf.toString(),
            Formatadores.formatadorMonetario(
                (double.parse(_custoDetalhado.custoPF) *
                        _storeDetalhada.contagemDetalhadaValida.totalPf)
                    .toStringAsFixed(2)),
          ]
        ], mapTabela3),
        ConstrutorPdf.tituloSessao(
            '4. Estimativas baseadas na contagem Estimada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            ['Esforço (horas)', _esforcoDetalhado.esforcoTotal],
            [
              'Prazo (em meses)',
              (_prazoDetalhado.prazoTotal / 30).toStringAsFixed(2)
            ],
            [
              'Prazo (em semanas)',
              (_prazoDetalhado.prazoTotal / 30 * 4).toStringAsFixed(2)
            ],
            ['Prazo (em dias)', _prazoDetalhado.prazoTotal],
            [
              'Região do impossível (75%) (em semanas)',
              double.parse(_prazoDetalhado.prazoMinimo) / 30 * 4
            ],
            ['Tamanho da Equipe', _equipeDetalhada.equipeEstimada],
            [
              'Valor do rateio de despesas para o projeto por mês',
              Formatadores.formatadorMonetario(_custoDetalhado.custoTotalMensal)
            ],
          ],
        ),
        ConstrutorPdf.tituloSessao(
            '5. Estimativas de Custo para contagem Estimada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [],
            [
              'Tamanho funcional (PF)',
              _storeEstimada.contagemEstimadaValida.totalPF
            ],
            [
              'Custo básico (CP)',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.custoBasico.toStringAsFixed(2))
            ],
            [
              'Percentual de reserva técnica do projeto',
              _custoDetalhado.porcentagemLucro + "%"
            ],
            [
              'Valor reserva técnica',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.valorPorcentagem.toStringAsFixed(2))
            ],
            [
              'Custo + Reserva técnica',
              Formatadores.formatadorMonetario((_custoDetalhado.custoBasico +
                      _custoDetalhado.valorPorcentagem)
                  .toStringAsFixed(2))
            ],
            [
              'Despesas Rateadas para o projeto durante o\n prazo do seu desenvolvimento',
              Formatadores.formatadorMonetario(_custoDetalhado
                  .despesasTotaisDurantePrazoProjeto
                  .toStringAsFixed(2))
            ],
            [
              'Custo estimado total',
              Formatadores.formatadorMonetario(
                  _custoDetalhado.valorTotalProjeto.toStringAsFixed(2))
            ],
          ],
        ),
        ConstrutorPdf.tituloSessao(
            '6. Distribuição do custo, esforço e prazo por etapa'),
        ConstrutorPdf.tabela([
          'Etapa',
          'Percentual',
          'R\$/Etapa',
          'Esforço(horas)/Etapa',
          'Dias/Etapa',
        ], [
          [
            "Requisitos",
            "25%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.25).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.25)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.25)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Design",
            "10%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.10).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.10)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.10)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Codificação",
            "40%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.40).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.40)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.40)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Testes",
            "15%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.15).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.15)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.15)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Homologação",
            "5%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.05)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.050)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
          [
            "Implantação",
            "5%",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.05).toStringAsFixed(2)),
            (double.parse(_esforcoDetalhado.esforcoTotal) * 0.05)
                .toStringAsFixed(2),
            (_prazoDetalhado.prazoTotal * 0.050)
                .roundToDouble()
                .toStringAsFixed(2)
          ],
        ], mapTabela4),
        ConstrutorPdf.tituloSessao('7. Orçamento do projeto para o cliente'),
        ConstrutorPdf.tabelaSemTitulo([
          [],
          [
            'Percentual de Lucro desejado',
            '50%',
          ],
          [
            "Lucro Esperado",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 0.5).toStringAsFixed(2))
          ],
          [
            "Preço final ao cliente",
            Formatadores.formatadorMonetario(
                (_custoDetalhado.valorTotalProjeto * 1.5).toStringAsFixed(2))
          ]
        ]),
        pw.Column(children: [
          pw.SizedBox(height: 30),
          pw.Text("Referências",
              style: pw.TextStyle(
                  color: PdfColor.fromInt(
                    corCorpoTexto.value,
                  ),
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text(
              "Ministério do Planejamento, Desenvolvimento e Gestão (org.). Roteiro de Métricas de Software do SISP. 2.3 Brasília, 2018. Disponível em: https://www.gov.br/governodigital/pt-br/sisp/documentos/roteiro-de-metricas-de-software-do-sisp. Acesso em: 19 nov. 2021."),
        ]),
        pw.SizedBox(height: 100),
      ];
    }, footer: (context) {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Divider(),
            pw.Text(
              "Elaborado por EstimaSoft",
            )
          ]);
    }));

    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${projeto.nomeProjeto}_hhmmss.pdf');

    await file.writeAsBytes(bytes);

    final url = file.path;

    await OpenFile.open(url);
  }

  prepararDocumentoEstimado() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(now);

    data = formattedDate.toString();
    imageAsset = pw.MemoryImage(
      (await rootBundle.load(
        'assets/imagens/logo_estatica.png',
      ))
          .buffer
          .asUint8List(),
    );

    final funcaoAIE = _storeEstimada.contagemEstimadaValida.aie.map((item) {
      return [
        item.tipoFuncao,
        item.nomeFuncao,
        item.descricao,
        item.complexidade,
        item.quantidadePF.toString() + " PF"
      ];
    }).toList();

    final funcaoAli = _storeEstimada.contagemEstimadaValida.ali.map((item) {
      _storeIndicativa.contagemIndicativaValida.totalPf.toString() + " PF";

      return [
        item.tipoFuncao,
        item.nomeFuncao,
        item.descricao,
        item.complexidade,
        item.quantidadePF.toString() + " PF"
      ];
    }).toList();

    _dadosFuncaoDeDados = funcaoAli.toList() + funcaoAIE.toList();
    valorTotalTransacionalEstimada = 0;

    var se = _dadosFuncaoTransacional =
        _storeEstimada.contagemEstimadaValida.se.map((item) {
      valorTotalTransacionalEstimada += item.quantidadePF;

      return [
        item.tipoFuncao,
        item.nomeFuncao,
        item.descricao,
        item.complexidade,
        item.quantidadePF.toString() + " PF"
      ];
    }).toList();

    var ee = _dadosFuncaoTransacional =
        _storeEstimada.contagemEstimadaValida.ee.map((item) {
      valorTotalTransacionalEstimada += item.quantidadePF;

      return [
        item.tipoFuncao,
        item.nomeFuncao,
        item.descricao,
        item.complexidade,
        item.quantidadePF.toString() + " PF"
      ];
    }).toList();

    var ce = _dadosFuncaoTransacional =
        _storeEstimada.contagemEstimadaValida.ce.map((item) {
      valorTotalTransacionalEstimada += item.quantidadePF;

      return [
        item.tipoFuncao,
        item.nomeFuncao,
        item.descricao,
        item.complexidade,
        item.quantidadePF.toString() + " PF"
      ];
    }).toList();

    _dadosFuncaoTransacional = ce.toList() + ee.toList() + se.toList();
    _esforcoDetalhado = _storeEsforco.esforcosValidos.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Estimada"));

    _equipeDetalhada = _storeEquipe.equipesValidas.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Estimada"));

    _prazoDetalhado = _storePrazo.prazosValidos.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Estimada"));

    _custoDetalhado = _storeCusto.custosValidos
        .singleWhere((element) => element.tipoContagem.contains("Estimada"));
  }
}
