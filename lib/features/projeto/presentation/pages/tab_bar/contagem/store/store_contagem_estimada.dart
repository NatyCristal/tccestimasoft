import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'store_contagem_estimada.g.dart';

class StoreContagemEstimada = StoreContagemEstimadaBase
    with _$StoreContagemEstimada;

abstract class StoreContagemEstimadaBase with Store {
  @observable
  ContagemEstimadaEntitie contagemEstimadaValida = ContagemEstimadaEntitie(
    aie: [],
    ali: [],
    compartilhada: false,
    ce: [],
    ee: [],
    se: [],
    totalPF: 0,
  );

  @observable
  String descricao = "";

  @observable
  TextEditingController nomeDaFuncaoController = TextEditingController();

  @observable
  TextEditingController descricaoController = TextEditingController();

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
  List<IndiceDescricaoContagenModel> ee = [];
  @observable
  List<IndiceDescricaoContagenModel> se = [];
  @observable
  List<IndiceDescricaoContagenModel> ce = [];

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
          ee.add(IndiceDescricaoContagenModel(
              complexidade: "Média",
              nomeFuncao: nomeDafuncao,
              descricao: descricao,
              quantidadePF: 4,
              tipoFuncao: "EE"));
          totalPf += 4;
          tamanhoListaEE = ee.length;
          alteracoes = true;
        }
        break;
      case "SE":
        if (!temIgual) {
          se.add(IndiceDescricaoContagenModel(
              complexidade: "Média",
              nomeFuncao: nomeDafuncao,
              descricao: descricao,
              quantidadePF: 5,
              tipoFuncao: "SE"));
          totalPf += 5;
          tamanhoListaSE = se.length;
          alteracoes = true;
        }
        break;
      case "CE":
        if (!temIgual) {
          ce.add(IndiceDescricaoContagenModel(
              complexidade: "Média",
              nomeFuncao: nomeDafuncao,
              descricao: descricao,
              quantidadePF: 4,
              tipoFuncao: "CE"));
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
    descricao = "";
    descricaoController.text = "";
    tipoFuncao = "CE";
  }

  @action
  removerFuncao(String nomeDaFuncaoDelete, tipoFuncao) {
    switch (tipoFuncao) {
      case "CE":
        ce.removeWhere((element) => element.nomeFuncao == nomeDaFuncaoDelete);
        tamanhoListaCE = ce.length;
        totalPf -= 4;
        alteracoes = true;
        break;
      case "SE":
        se.removeWhere((element) => element.nomeFuncao == nomeDaFuncaoDelete);
        tamanhoListaSE = se.length;
        totalPf -= 5;
        alteracoes = true;
        break;
      case "EE":
        ee.removeWhere((element) => element.nomeFuncao == nomeDaFuncaoDelete);
        tamanhoListaEE = ee.length;
        totalPf -= 4;
        alteracoes = true;
        break;
      default:
    }
    alteracoes = true;
  }

  @action
  editar(
      String nomeDaFuncaoDelete, String tipoFuncao, String descricaoEditada) {
    switch (tipoFuncao) {
      case "CE":
        ce.removeWhere((element) => element.nomeFuncao == nomeDaFuncaoDelete);
        tamanhoListaCE = ce.length;
        totalPf -= 4;
        alteracoes = true;
        break;
      case "SE":
        se.removeWhere((element) => element.nomeFuncao == nomeDaFuncaoDelete);
        tamanhoListaSE = se.length;
        totalPf -= 5;
        alteracoes = true;
        break;
      case "EE":
        ee.removeWhere((element) => element.nomeFuncao == nomeDaFuncaoDelete);
        tamanhoListaEE = ee.length;
        totalPf -= 4;
        alteracoes = true;
        break;
      default:
    }

    descricaoController.text = descricaoEditada;
    descricao = descricaoEditada;
    alteracoes = true;
    nomeDaFuncaoController.text = nomeDaFuncaoDelete;
    nomeDafuncao = nomeDaFuncaoDelete;
    this.tipoFuncao = tipoFuncao;
  }

  validar(String nomeFuncao) {
    for (var element in ee) {
      if (element.nomeFuncao == nomeDafuncao) {
        return true;
      }
    }
    for (var element in se) {
      if (element.nomeFuncao == nomeDafuncao) {
        return true;
      }
    }

    for (var element in ce) {
      if (element.nomeFuncao == nomeDafuncao) {
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
    contagemEstimadaValida =
        Modular.get<ProjetoController>().contagemController.contagemEstimada;
  }

  @action
  salvar(ContagemEstimadaEntitie novaContagem) {
    contagemEstimadaValida = novaContagem;
  }
}
