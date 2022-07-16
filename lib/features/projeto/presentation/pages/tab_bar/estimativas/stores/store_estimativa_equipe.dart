import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'store_estimativa_equipe.g.dart';

class StoreEstimativaEquipe = StoreEstimativaEquipeBase
    with _$StoreEstimativaEquipe;

abstract class StoreEstimativaEquipeBase with Store {
  bool isVisualizacao = false;

  List<String> contagens = [];

  List<EquipeEntity> equipesValidas = [];

  List<EsforcoEntity> esforcosValidos =
      Modular.get<ProjetoController>().estimativasController.esforcos;

  List<PrazoEntity> prazosValidos =
      Modular.get<ProjetoController>().estimativasController.prazos;

  List<String> menuItem = [
    '1 hora',
    '2 horas',
    '3 horas',
    '4 horas',
    '5 horas',
    '6 horas',
    '7 horas',
    '8 horas',
    '9 horas',
    '10 horas'
  ];

  @observable
  double equipeEstimadaValor = 0.00;
  @observable
  String esforcoSelecionado = "";
  @observable
  String prazoSelecionado = "";
  @observable
  String producaoDiaria = "7 horas";
  @observable
  bool alteracao = false;

  @observable
  int tamanhoEquipe = 0;

  @observable
  List<EquipeEntity> equipes = [];

  @observable
  List<String> menuPrazo = [];

  @observable
  List<String> menuEsforco = [];

  @action
  buscarListaEquipe(List<EquipeEntity> equipeEntity) {
    equipes = equipeEntity;
    tamanhoEquipe = equipeEntity.length;

    if (equipesValidas.isEmpty) {
      equipesValidas = equipeEntity;
    }
  }

  @action
  estimarEquipe() {
    if (esforcoSelecionado.isNotEmpty &&
        producaoDiaria.isNotEmpty &&
        prazoSelecionado.isNotEmpty) {
      equipeEstimadaValor = (double.parse(esforcoSelecionado)) /
          (21 *
              double.parse(producaoDiaria.split(" horas").first) *
              (double.parse(prazoSelecionado)) /
              30);
    }
  }

  @action
  adicionarEquipe(context) {
    if (equipes.isEmpty) {
      for (var cont in contagens) {
        if (esforcosValidos.isNotEmpty) {
          prazoSelecionado = prazosValidos
              .singleWhere((element) => element.contagemPontoDeFuncao
                  .contains(cont.split(" - ").first))
              .prazoTotal
              .toString();

          esforcoSelecionado = esforcosValidos
              .singleWhere((element) => element.contagemPontoDeFuncao
                  .contains(cont.split(" - ").first))
              .esforcoTotal;
          estimarEquipe();

          EquipeEntity equipeEntity = EquipeEntity(
            contagemPontoDeFuncao: cont.split(" - ").first,
            compartilhada: false,
            esforco: esforcoSelecionado,
            prazo: prazoSelecionado,
            producaoDiaria: producaoDiaria,
            equipeEstimada: equipeEstimadaValor.toStringAsFixed(2),
          );

          equipes.add(equipeEntity);
          tamanhoEquipe = equipes.length;
          alteracao = true;
        }
      }
    }
  }

  @action
  remover(EquipeEntity equipeEntity) {
    equipes.removeWhere((element) {
      return element.equipeEstimada == equipeEntity.equipeEstimada;
    });
    alteracao = true;

    tamanhoEquipe = equipes.length;
  }

  @action
  exibirEsforcos(List<EsforcoEntity> esforcos) {
    List<String> esforcosEstimadosExibicao = [];
    for (var element in esforcos) {
      esforcosEstimadosExibicao.add(
          "${element.esforcoTotal} HH - ${element.contagemPontoDeFuncao.split(" - ").first}");
    }
    esforcosValidos = esforcos;
    menuEsforco = esforcosEstimadosExibicao;

    return esforcosEstimadosExibicao;
  }

  @action
  exibirPrazps(List<PrazoEntity> prazps) {
    List<String> esforcosEstimadosExibicao = [];
    for (var element in prazps) {
      esforcosEstimadosExibicao.add(
          "${element.prazoTotal} Dias - ${element.contagemPontoDeFuncao.split(" - ").first}");
    }
    prazosValidos = prazps;
    menuPrazo = esforcosEstimadosExibicao;

    return esforcosEstimadosExibicao;
  }
}
