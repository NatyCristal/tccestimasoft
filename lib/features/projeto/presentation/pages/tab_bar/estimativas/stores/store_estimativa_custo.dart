import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:mobx/mobx.dart';

part 'store_estimativa_custo.g.dart';

class StoreEstimativaCusto = StoreEstimativaCustoBase
    with _$StoreEstimativaCusto;

abstract class StoreEstimativaCustoBase with Store {
  @observable
  int tamanhoEquipe = 0;
  @observable
  int tamanhoCustos = 0;

  @observable
  String cargoMembro = "";
  @observable
  String salarioMembro = "";
  @observable
  bool temErroCargoMembro = false;
  @observable
  bool temErroSalarioMembro = false;
  @observable
  String textoErroCargoMembro = "";
  @observable
  String textoErroSalarioMembro = "";

  @observable
  String nomeCusto = "";
  @observable
  String valorCusto = "";
  @observable
  bool temErroNomeCusto = false;
  @observable
  bool temErroValorCusto = false;
  @observable
  String textoErroNomeCusto = "";
  @observable
  String textoErrovalorCusto = "";

  @observable
  bool carregando = false;

  @observable
  Map<String, String> equipe = <String, String>{};

  @observable
  Map<String, String> custosVariaveis = <String, String>{};

  @observable
  double custoPF = 0;

  @observable
  double custoTotalMensal = 0;

  @observable
  double disponibilidadeEquipe = 0;

  @observable
  double custoTotalEquipe = 0;

  @observable
  double custoHora = 0;

  @observable
  double porcentagemLucro = 0;

  @observable
  double custoProjeto = 0;

  @observable
  double valorTotalProjeto = 0;

  @action
  removerEquipe(String chave, String valor, context) {
    equipe.remove(chave);
    tamanhoEquipe = equipe.length;
    custoProjeto -= double.parse(valor);
    validarValorTotalProjeto();
    AlertaSnack.exbirSnackBar(context, "Membro $chave removido.");
  }

  @action
  removerCusto(String chave, String valor, context) {
    custosVariaveis.remove(chave);
    tamanhoCustos = custosVariaveis.length;
    custoProjeto -= double.parse(valor);
    validarValorTotalProjeto();
    AlertaSnack.exbirSnackBar(context, "Custo $chave removido.");
  }

  @action
  adicionarCusto(context) {
    if (validarAdicaoCusto()) {
      custosVariaveis[nomeCusto] = valorCusto;
      if (tamanhoCustos == custosVariaveis.length) {
        AlertaSnack.exbirSnackBar(
            context, "Custo com o mesmo nome já foi adicionado.");
      } else {
        custoProjeto += double.parse(valorCusto);
        tamanhoCustos = custosVariaveis.length;
        validarValorTotalProjeto();
        AlertaSnack.exbirSnackBar(context, "Custo adicionado");
      }
    }
  }

  @action
  adicionarEquipe(context) {
    if (validarAdicaoEquipe()) {
      equipe[cargoMembro] = salarioMembro;

      if (tamanhoEquipe == equipe.length) {
        AlertaSnack.exbirSnackBar(
            context, "Não pode cadastrar o mesmo membro dentro da equipe.");
      } else {
        custoProjeto += double.parse(salarioMembro);
        tamanhoEquipe = equipe.length;
        validarValorTotalProjeto();
        AlertaSnack.exbirSnackBar(context, "Membro adicionado a equipe");
      }
    }
  }

  @action
  validarValorTotalProjeto() {
    if (porcentagemLucro > 0) {
      valorTotalProjeto =
          custoProjeto + (custoProjeto * (porcentagemLucro / 100));
    } else {
      valorTotalProjeto = custoProjeto;
    }
  }

  @action
  validarAdicaoCusto() {
    temErroNomeCusto = true;
    temErroValorCusto = true;

    if (nomeCusto.isEmpty) {
      textoErroNomeCusto = "Nome de custo vazio";
      return false;
    }

    if (nomeCusto.length <= 3) {
      textoErroNomeCusto = "Nome de custo pequeno";
      return false;
    }
    textoErroNomeCusto = "";
    temErroCargoMembro = false;

    if (valorCusto.isEmpty) {
      textoErrovalorCusto = "valor não pode ser vazio";
      return false;
    }

    temErroValorCusto = false;
    textoErrovalorCusto = "";

    return true;
  }

  @action
  validarAdicaoEquipe() {
    temErroSalarioMembro = true;
    temErroCargoMembro = true;

    if (cargoMembro.isEmpty) {
      textoErroCargoMembro = "Cargo vazio";
      return false;
    }

    if (cargoMembro.length <= 3) {
      textoErroCargoMembro = "Cargo pequeno";
      return false;
    }
    textoErroCargoMembro = "";
    temErroCargoMembro = false;

    if (salarioMembro.isEmpty) {
      textoErroSalarioMembro = "Salário não pode ser vazio";
      return false;
    }

    temErroSalarioMembro = false;
    textoErroSalarioMembro = "";

    return true;
  }
}
