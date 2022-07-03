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
  late final _dadosFuncaoDeDados;
  late final _dadosFuncaoTransacional;
  late final _esforcoDetalhado;
  late final _prazoDetalhado;
  late final _equipeDetalhada;
  late final _custoDetalhado;

  GeradorPdf(
      this._storeDetalhada,
      this._storeEstimada,
      this._storeIndicativa,
      this._storeEsforco,
      this._storePrazo,
      this._storeEquipe,
      this._storeCusto);

  gerarDocument(ProjetoEntitie projeto) async {
    await prepararDocumento();

    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(build: (context) {
      return [
        pw.Header(child: ConstrutorPdf.cabecalho(data, imageAsset)),
        ConstrutorPdf.linha("Nome do projeto: ", projeto.nomeProjeto),
        ConstrutorPdf.linha("Responsável pela contagem: ",
            Modular.get<UsuarioAutenticado>().store.nome),
        ConstrutorPdf.tituloSessao("1. Contagem detalhada"),
        ConstrutorPdf.subtitulo("1.1. Função de Dados"),
        ConstrutorPdf.tabela([
          'Tipo',
          'Nome das Funções',
          '# Tipos de\n Resgistro',
          '# Tipos de\n Dados',
          'Complexidade',
          'Comtribuição',
        ], _dadosFuncaoDeDados),
        ConstrutorPdf.totalTabela(
            "Contribuição total das funções de dados: ",
            _storeDetalhada.contagemDetalhadaValida.totalFuncaoDados
                    .toString() +
                " PF"),
        ConstrutorPdf.subtitulo('1.2. Funções Transacionais'),
        ConstrutorPdf.tabela([
          'Tipo',
          'Nome das Funções',
          '# Arquivos\n Referenciados ',
          '# Tipos de\n Dados',
          'Complexidade',
          'Comtribuição',
        ], _dadosFuncaoTransacional),
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
        ConstrutorPdf.tabela(
          [
            'Tipo de contagem',
            'Tamanho (PF)',
            'Custo estimado',
          ],
          [
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
          ],
        ),
        ConstrutorPdf.tituloSessao(
            '4. Estimativas baseadas na contagem Detalhada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            ['Esforço (horas)', _esforcoDetalhado.esforcoTotal],
            ['Prazo (em meses)', _prazoDetalhado.prazoTotal / 30],
            ['Prazo (em semanas)', _prazoDetalhado.prazoTotal / 30 * 4],
            ['Prazo (em dias)', _prazoDetalhado.prazoTotal],
            [
              'Região do impossível (75%) (em semanas)',
              double.parse(_prazoDetalhado.prazoMinimo) / 4
            ],
            ['Tamanho da Equipe', _equipeDetalhada.equipeEstimada],
            [
              'Valor do rateio de despesas para o projeto por mês',
              Formatadores.formatadorMonetario(_custoDetalhado
                  .despesasTotaisDurantePrazoProjeto
                  .toStringAsFixed(2))
            ],
          ],
        ),
        ConstrutorPdf.tituloSessao(
            '5. Estimativas de Custo para contagem Detalhada'),
        ConstrutorPdf.tabelaSemTitulo(
          [
            [
              'Tamanho funcional (PF)',
              _storeDetalhada.contagemDetalhadaValida.totalPf
            ],
            ['Custo básico (CP)', _custoDetalhado.custoBasico],
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
              'Despesas Rateadas para o projeto furante o\n prazo do seu desenvolvimento',
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
            '6. Distribuição do custo e esforço e prazo por etapa'),
        pw.Table.fromTextArray(
          headerAlignment: pw.Alignment.center,
          headers: [
            'Etapa',
            'Percentual',
            'R\$/Etapa',
            'Esforço(horas)/Etapa',
            'Semanas/Etapa',
          ],
          data: [
            [
              "Requisitos",
              "25%",
              Formatadores.formatadorMonetario(
                  (_custoDetalhado.valorTotalProjeto * 0.25)
                      .toStringAsFixed(2)),
              (double.parse(_esforcoDetalhado.esforcoTotal) * 0.25)
                  .toStringAsFixed(2),
              (_prazoDetalhado.prazoTotal / 30 * 0.25 * 4).toStringAsFixed(2)
            ],
            [
              "Design",
              "10%",
              Formatadores.formatadorMonetario(
                  (_custoDetalhado.valorTotalProjeto * 0.10)
                      .toStringAsFixed(2)),
              (double.parse(_esforcoDetalhado.esforcoTotal) * 0.10)
                  .toStringAsFixed(2),
              (_prazoDetalhado.prazoTotal / 30 * 0.10 * 4).toStringAsFixed(2)
            ],
            [
              "Codificação",
              "40%",
              Formatadores.formatadorMonetario(
                  (_custoDetalhado.valorTotalProjeto * 0.40)
                      .toStringAsFixed(2)),
              (double.parse(_esforcoDetalhado.esforcoTotal) * 0.40)
                  .toStringAsFixed(2),
              (_prazoDetalhado.prazoTotal / 30 * 0.40 * 4).toStringAsFixed(2)
            ],
            [
              "Testes",
              "15%",
              Formatadores.formatadorMonetario(
                  (_custoDetalhado.valorTotalProjeto * 0.15)
                      .toStringAsFixed(2)),
              (double.parse(_esforcoDetalhado.esforcoTotal) * 0.15)
                  .toStringAsFixed(2),
              (_prazoDetalhado.prazoTotal / 30 * 0.15 * 4).toStringAsFixed(2)
            ],
            [
              "Homologação",
              "5%",
              Formatadores.formatadorMonetario(
                  (_custoDetalhado.valorTotalProjeto * 0.05)
                      .toStringAsFixed(2)),
              (double.parse(_esforcoDetalhado.esforcoTotal) * 0.05)
                  .toStringAsFixed(2),
              (_prazoDetalhado.prazoTotal / 30 * 0.050 * 4).toStringAsFixed(2)
            ],
            [
              "Implantação",
              "5%",
              Formatadores.formatadorMonetario(
                  (_custoDetalhado.valorTotalProjeto * 0.05)
                      .toStringAsFixed(2)),
              (double.parse(_esforcoDetalhado.esforcoTotal) * 0.05)
                  .toStringAsFixed(2),
              (_prazoDetalhado.prazoTotal / 30 * 0.050 * 4).toStringAsFixed(2)
            ],
          ],
        ),
        ConstrutorPdf.tituloSessao('7. Orçamento do projeto para o cliente'),
        ConstrutorPdf.tabelaSemTitulo([
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

  prepararDocumento() async {
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
        item.quantidadeTrsEArs,
        item.quantidadeTDs,
        item.complexidade,
        item.pontoDeFuncao.toString() + " PF"
      ];
    }).toList();

    _esforcoDetalhado = _storeEsforco.esforcosValidos.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Detalhada"));

    _equipeDetalhada = _storeEquipe.equipesValidas
        .singleWhere((element) => element.esforco.contains("Detalhada"));

    _prazoDetalhado = _storePrazo.prazosValidos.singleWhere(
        (element) => element.contagemPontoDeFuncao.contains("Detalhada"));

    _custoDetalhado = _storeCusto.custosValidos
        .singleWhere((element) => element.tipoContagem.contains("Detalhada"));
  }
}