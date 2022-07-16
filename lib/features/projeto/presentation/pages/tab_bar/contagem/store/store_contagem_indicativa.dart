import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_indicativa_firebase_model.dart';
import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
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
    compartilhada: false,
    aie: [],
    ali: [],
    totalPf: 0,
  );

  @observable
  TextEditingController nomeDaFuncaoController = TextEditingController();

  @observable
  TextEditingController descricaoController = TextEditingController();

  @observable
  bool alteracoes = false;

  @observable
  bool carregou = false;

  @observable
  String nomeDafuncao = "";

  @observable
  String tipoFuncao = "ALI";

  @observable
  String descricao = "";

  List<IndiceDescricaoContagenModel> alis = [];

  List<IndiceDescricaoContagenModel> aies = [];

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
      if (element.nomeFuncao == nomeDafuncao) {
        temIgual = true;
      }
    }
    for (var element in aies) {
      if (element.nomeFuncao == nomeDafuncao) {
        temIgual = true;
      }
    }

    if (temIgual) {
      return AlertaSnack.exbirSnackBar(context, "Nome de função já cadastrada");
    }

    switch (tipoFuncao) {
      case "ALI":
        if (!temIgual) {
          alis.add(IndiceDescricaoContagenModel(
              complexidade: "Baixa",
              nomeFuncao: nomeDafuncao,
              descricao: descricao,
              quantidadePF: 35,
              tipoFuncao: tipoFuncao));
          totalPf += 35;
          tamanhoListaALI = alis.length;
          alteracoes = true;
        }
        break;
      case "AIE":
        if (!temIgual) {
          aies.add(IndiceDescricaoContagenModel(
              complexidade: "Baixa",
              nomeFuncao: nomeDafuncao,
              descricao: descricao,
              quantidadePF: 15,
              tipoFuncao: tipoFuncao));
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
    descricao = "";
    descricaoController.text = "";
  }

  @action
  removerFuncao(String nomeDaFuncao, tipoFuncao) {
    switch (tipoFuncao) {
      case "ALI":
        alis.removeWhere((element) => element.nomeFuncao == nomeDaFuncao);
        tamanhoListaALI = alis.length;
        totalPf -= 35;
        alteracoes = true;
        break;
      case "AIE":
        aies.removeWhere((element) => element.nomeFuncao == nomeDaFuncao);
        tamanhoListaAIE = aies.length;
        totalPf -= 15;
        alteracoes = true;
        break;
      default:
    }
  }

  @action
  editar(String nomeDaFuncaoalterada, String tipoFuncao,
      String descricaoALterada) {
    switch (tipoFuncao) {
      case "ALI":
        alis.removeWhere(
            (element) => element.nomeFuncao == nomeDaFuncaoalterada);
        tamanhoListaALI = alis.length;
        totalPf -= 35;
        alteracoes = true;
        break;
      case "AIE":
        aies.removeWhere(
            (element) => element.nomeFuncao == nomeDaFuncaoalterada);
        tamanhoListaAIE = aies.length;
        totalPf -= 15;
        alteracoes = true;
        break;
      default:
    }

    descricaoController.text = descricaoALterada;
    descricao = descricaoALterada;
    alteracoes = true;
    nomeDaFuncaoController.text = nomeDaFuncaoalterada;
    nomeDafuncao = nomeDaFuncaoalterada;
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
    contagemIndicativaValida = novaContagem;
  }
}
