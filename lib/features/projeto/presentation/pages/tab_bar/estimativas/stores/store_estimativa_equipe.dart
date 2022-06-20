import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:mobx/mobx.dart';

part 'store_estimativa_equipe.g.dart';

class StoreEstimativaEquipe = StoreEstimativaEquipeBase
    with _$StoreEstimativaEquipe;

abstract class StoreEstimativaEquipeBase with Store {
  List<EquipeEntity> equipesValidas = [];
  List<EsforcoEntity> esforcosValidos = [];
  List<PrazoEntity> prazosValidos = [];
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
  bool carregando = false;
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
      equipeEstimadaValor =
          (double.parse(esforcoSelecionado.split(" HH ").first)) /
              (21 *
                  double.parse(producaoDiaria.split(" horas").first) *
                  (double.parse(prazoSelecionado.split(" Dias").first)) /
                  30);
    }
  }

  @action
  adicionarEquipe(context) {
    bool existe = false;
    for (var element in equipes) {
      if (element.esforco == esforcoSelecionado ||
          element.esforco.contains(esforcoSelecionado.split(" - ").last)) {
        existe = true;
        return AlertaSnack.exbirSnackBar(
            context, "Existe uma estimativa com essa contagem");
      }
    }

    for (var element in equipes) {
      if (element.prazo == prazoSelecionado ||
          element.prazo.contains(prazoSelecionado.split(" - ").last)) {
        existe = true;
        return AlertaSnack.exbirSnackBar(
            context, "Existe uma estimativa com essa contagem");
      }
    }

    if (esforcoSelecionado.split(" - ").last !=
        prazoSelecionado.split(" - ").last) {
      return AlertaSnack.exbirSnackBar(
          context, "Selecione um esforço e prazo com a mesma contagem");
    }

    if (esforcosValidos.isNotEmpty && !existe) {
      EquipeEntity equipeEntity = EquipeEntity(
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
