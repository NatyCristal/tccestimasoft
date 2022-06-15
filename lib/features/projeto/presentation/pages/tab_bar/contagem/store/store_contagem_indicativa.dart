import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_indicativa_firebase_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'store_contagem_indicativa.g.dart';

class StoreContagemIndicativa = StoreContagemIndicativaBase
    with _$StoreContagemIndicativa;

abstract class StoreContagemIndicativaBase with Store {
  @observable
  ContagemIndicativaEntitie contagemIndicativaValida =
      ContagemIndicativaModelFirebase(
    aie: [],
    ali: [],
    totalPf: 0,
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
  String tipoFuncao = "ALI";

  List<String> alis = [];

  List<String> aies = [];

  @observable
  int totalPf = 0;

  @observable
  int tamanhoListaALI = 0;

  @observable
  int tamanhoListaAIE = 0;

  @action
  adicionarFuncao(context, String funcao) {
    bool temIgual = false;

    for (var element in alis) {
      if (element == nomeDafuncao) {
        temIgual = true;
      }
    }
    for (var element in aies) {
      if (element == nomeDafuncao) {
        temIgual = true;
      }
    }

    if (temIgual) {
      return AlertaSnack.exbirSnackBar(context, "Nome de função já cadastrada");
    }

    switch (tipoFuncao) {
      case "ALI":
        if (!temIgual) {
          alis.add(nomeDafuncao);
          totalPf += 35;
          tamanhoListaALI = alis.length;
          alteracoes = true;
        }
        break;
      case "AIE":
        if (!temIgual) {
          aies.add(nomeDafuncao);
          totalPf += 15;
          tamanhoListaAIE = aies.length;
          alteracoes = true;
        }
        break;
      default:
        break;
    }

    nomeDafuncao = "";
    nomeDaFuncaoController.text = "";
    tipoFuncao = "ALI";
  }

  @action
  removerFuncao(String nomeDaFuncao, tipoFuncao) {
    switch (tipoFuncao) {
      case "ALI":
        alis.remove(nomeDaFuncao);
        tamanhoListaALI = alis.length;
        totalPf -= 35;
        alteracoes = true;
        break;
      case "AIE":
        aies.remove(nomeDaFuncao);
        tamanhoListaAIE = aies.length;
        totalPf -= 15;
        alteracoes = true;
        break;
      default:
    }
  }

  @action
  editar(String nomeDaFuncao, String tipoFuncao) {
    switch (tipoFuncao) {
      case "ALI":
        alis.remove(nomeDaFuncao);
        tamanhoListaALI = alis.length;
        totalPf -= 35;
        alteracoes = true;
        break;
      case "AIE":
        aies.remove(nomeDaFuncao);
        tamanhoListaAIE = aies.length;
        totalPf -= 15;
        alteracoes = true;
        break;
      default:
    }

    alteracoes = true;
    nomeDaFuncaoController.text = nomeDaFuncao;
    this.tipoFuncao = tipoFuncao;
  }

  @action
  iniciarSessao(ContagemIndicativaEntitie contagemRecuperadaFirebase) {
    totalPf = contagemRecuperadaFirebase.totalPf;
    aies = contagemRecuperadaFirebase.aie;
    tamanhoListaAIE = contagemRecuperadaFirebase.aie.length;
    alis = contagemRecuperadaFirebase.ali;
    tamanhoListaALI = contagemRecuperadaFirebase.ali.length;

    contagemIndicativaValida =
        Modular.get<ProjetoController>().contagemController.contagemIndicativa;
  }

  @action
  salvar(ContagemIndicativaEntitie novaContagem) {
    //   contagemIndicativaValida = novaContagem;
  }
}
