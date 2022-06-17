import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'store_contagem_estimada.g.dart';

class StoreContagemEstimada = StoreContagemEstimadaBase
    with _$StoreContagemEstimada;

abstract class StoreContagemEstimadaBase with Store {
  @observable
  ContagemEstimadaEntitie contagemEstimadaValida = ContagemEstimadaEntitie(
    ce: [],
    ee: [],
    se: [],
    totalPF: 0,
  );

  @observable
  TextEditingController nomeDaFuncaoController = TextEditingController();

  @observable
  bool carregouBotao = false;

  @observable
  bool alteracoes = false;

  @observable
  bool carregou = false;

  @observable
  String nomeDafuncao = "";

  @observable
  String tipoFuncao = "EE";

  @observable
  int totalPf = 0;

  @observable
  int tamanhoListaEE = 0;

  @observable
  int tamanhoListaSE = 0;

  @observable
  int tamanhoListaCE = 0;

  @observable
  List<String> ee = [];
  @observable
  List<String> se = [];
  @observable
  List<String> ce = [];

  @observable
  int totalIndicativa = 0;

  @action
  adicionarFuncao(context, String funcao) {
    bool temIgual = validar(nomeDafuncao);

    if (temIgual) {
      return AlertaSnack.exbirSnackBar(context, "Nome de função já cadastrada");
    }

    switch (tipoFuncao) {
      case "EE":
        if (!temIgual) {
          ee.add(nomeDafuncao);
          totalPf += 4;
          tamanhoListaEE = ee.length;
          alteracoes = true;
        }
        break;
      case "SE":
        if (!temIgual) {
          se.add(nomeDafuncao);
          totalPf += 5;
          tamanhoListaSE = se.length;
          alteracoes = true;
        }
        break;
      case "CE":
        if (!temIgual) {
          ce.add(nomeDafuncao);
          totalPf += 4;
          tamanhoListaCE = ce.length;
          alteracoes = true;
        }
        break;
      default:
        break;
    }

    nomeDafuncao = "";
    nomeDaFuncaoController.text = "";
    tipoFuncao = "CE";
  }

  @action
  removerFuncao(String nomeDaFuncao, tipoFuncao) {
    switch (tipoFuncao) {
      case "CE":
        ce.remove(nomeDaFuncao);
        tamanhoListaCE = ce.length;
        totalPf -= 4;
        alteracoes = true;
        break;
      case "SE":
        se.remove(nomeDaFuncao);
        tamanhoListaSE = se.length;
        totalPf -= 5;
        alteracoes = true;
        break;
      case "EE":
        ee.remove(nomeDaFuncao);
        tamanhoListaEE = ee.length;
        totalPf -= 4;
        alteracoes = true;
        break;
      default:
    }
    alteracoes = true;
  }

  @action
  editar(String nomeDaFuncao, String tipoFuncao) {
    switch (tipoFuncao) {
      case "CE":
        ce.remove(nomeDaFuncao);
        tamanhoListaCE = ce.length;
        totalPf -= 4;
        alteracoes = true;
        break;
      case "SE":
        se.remove(nomeDaFuncao);
        tamanhoListaSE = se.length;
        totalPf -= 5;
        alteracoes = true;
        break;
      case "EE":
        ee.remove(nomeDaFuncao);
        tamanhoListaEE = ee.length;
        totalPf -= 4;
        alteracoes = true;
        break;
      default:
    }

    alteracoes = true;
    nomeDaFuncaoController.text = nomeDaFuncao;
    this.tipoFuncao = tipoFuncao;
  }

  validar(String nomeFuncao) {
    for (var element in ee) {
      if (element == nomeDafuncao) {
        return true;
      }
    }
    for (var element in se) {
      if (element == nomeDafuncao) {
        return true;
      }
    }

    for (var element in ce) {
      if (element == nomeDafuncao) {
        return true;
      }
    }
    return false;
  }

  @action
  iniciarSessao(ContagemEstimadaEntitie contagemRecuperadaFirebase) {
    totalPf = contagemRecuperadaFirebase.totalPF;

    ce = contagemRecuperadaFirebase.ce;
    tamanhoListaCE = contagemRecuperadaFirebase.ce.length;

    ee = contagemRecuperadaFirebase.ee;
    tamanhoListaEE = contagemRecuperadaFirebase.ee.length;

    se = contagemRecuperadaFirebase.se;
    tamanhoListaSE = contagemRecuperadaFirebase.se.length;
  }

  @action
  salvar(ContagemEstimadaEntitie novaContagem) {
    contagemEstimadaValida = novaContagem;
  }
}
