import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/estimativas/data/models/insumo_estimativa_custo.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/cadastro_insumo_custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:mobx/mobx.dart';

part 'store_estimativa_custo.g.dart';

class StoreEstimativaCusto = StoreEstimativaCustoBase
    with _$StoreEstimativaCusto;

abstract class StoreEstimativaCustoBase with Store {
  bool isVisualizacao = false;

  List<String> contagens = [];

  @observable
  double valorPorcentagem = 0;

  double prazo = 0;

  @observable
  double despesasTotaisDurantePrazoProjeto = 0.0;

  @observable
  double custoBasico = 0.0;

  @observable
  int quantidadePFSelecionada = 0;

  @observable
  bool alteracao = false;

  @observable
  List<CustoEntity> custos = [];

  @observable
  int tamanhoListaCustos = 0;

  @observable
  int tamanhoEquipe = 0;
  @observable
  int tamanhoCustos = 0;

  @observable
  List<InsumoEstimativaCustoModel> equipe = [];

  @observable
  List<InsumoEstimativaCustoModel> custosVariaveis = [];

  @observable
  double custoPF = 0;

  @observable
  double custoTotalMensal = 0;

  //@observable
  //double disponibilidadeEquipe = 0;

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

  @observable
  String tipoContagem = "";
  @observable
  List<CustoEntity> custosValidos = [];

  @observable
  EsforcoEntity esforcoEntitySelecionado = EsforcoEntity(
      compartilhada: false,
      contagemPontoDeFuncao: "",
      linguagem: "",
      produtividadeEquipe: "",
      esforcoTotal: "");

  @observable
  EquipeEntity equipeEntitySelecionado = EquipeEntity(
      contagemPontoDeFuncao: "",
      compartilhada: false,
      esforco: "",
      prazo: '',
      producaoDiaria: "",
      equipeEstimada: "");

  @action
  exibirEsforcos(List<EsforcoEntity> esforcos) {
    List<String> esforcosEstimadosExibicao = [];
    for (var element in esforcos) {
      esforcosEstimadosExibicao.add(
          "${element.esforcoTotal} HH - ${element.contagemPontoDeFuncao.split(" - ").first}");
    }

    return esforcosEstimadosExibicao;
  }

  @action
  exibirEquipe(List<EquipeEntity> equipes) {
    List<String> esforcosEstimadosExibicao = [];
    for (var element in equipes) {
      esforcosEstimadosExibicao.add(
          "${element.equipeEstimada} HH - ${element.esforco.split(" - ").last}");
    }

    return esforcosEstimadosExibicao;
  }

  @action
  validarCamposPreenchidos(context) {
    if (tipoContagem == "") {
      AlertaSnack.exbirSnackBar(
          context, "Campo: Contagem de ponto de função vazio");
      return false;
    } else if (esforcoEntitySelecionado.contagemPontoDeFuncao == "") {
      AlertaSnack.exbirSnackBar(context, "Campo: Esforço vazio");
      return false;
    } else if (equipeEntitySelecionado.equipeEstimada == "") {
      AlertaSnack.exbirSnackBar(context, "Campo: Equipe vazio");
      return false;
    } else if (equipe.isEmpty) {
      AlertaSnack.exbirSnackBar(context, "Adicione os membros da equipe");
      return false;
    } else if (custoPF == 0) {
      AlertaSnack.exbirSnackBar(context, "Informe o valor de custo do PF");
      return false;
    } else if (porcentagemLucro == 0) {
      AlertaSnack.exbirSnackBar(context, "Adicione a porcentagem de lucro");
      return false;
    } else if (tipoContagem.split(" - ").first == "" &&
        esforcoEntitySelecionado.contagemPontoDeFuncao.split(" - ").first ==
            "" &&
        tipoContagem.split(" - ").first !=
            equipeEntitySelecionado.esforco.split(" - ").last) {
      AlertaSnack.exbirSnackBar(
          context, "Campo: Contagem de ponto de função vazio");
      return false;
    }

    return true;
  }

  @action
  adicionarNovoCusto(CustoEntity custoEntity, context) {
    if (custos.length < 3) {
      custos.add(custoEntity);
      tamanhoListaCustos = custos.length;
      calcularCustoHora();
      alteracao = true;
      validarValorTotalProjeto();
    }
  }

  @action
  remover(CustoEntity custoEntity) {
    custos.remove(custoEntity);
    tamanhoListaCustos = custos.length;
    calcularCustoHora();
    validarValorTotalProjeto();
    alteracao = true;
  }

  @action
  calcularCustoHora() {
    custoBasico = (custoPF * quantidadePFSelecionada);

    despesasTotaisDurantePrazoProjeto = custoTotalMensal * prazo;

    custoProjeto = custoBasico + despesasTotaisDurantePrazoProjeto;
    validarValorTotalProjeto();
  }

  @action
  buscarListaCusto(List<CustoEntity> custoEntity) {
    custos = custoEntity;
    tamanhoListaCustos = custoEntity.length;
    custosValidos = custoEntity;
  }

  @action
  removerEquipe(CadastroInsumoCustoEntity insumoCustoEntity, context) {
    equipe.remove(insumoCustoEntity);
    tamanhoEquipe = equipe.length;
    custoTotalMensal -= double.parse(insumoCustoEntity.valor);
    validarValorTotalProjeto();
    AlertaSnack.exbirSnackBar(
        context, "Membro ${insumoCustoEntity.nome} removido.");
    calcularCustoHora();
  }

  @action
  removerCusto(CadastroInsumoCustoEntity insumoCustoEntity, context) {
    custosVariaveis.remove(insumoCustoEntity);
    tamanhoCustos = custosVariaveis.length;
    custoTotalMensal -= double.parse(insumoCustoEntity.valor);
    validarValorTotalProjeto();
    AlertaSnack.exbirSnackBar(
        context, "Custo ${insumoCustoEntity.nome} removido.");
    calcularCustoHora();
  }

  @action
  adicionarCusto(context) {
    if (validarAdicaoCusto()) {
      InsumoEstimativaCustoModel insumoCustoEntity =
          InsumoEstimativaCustoModel(nome: nomeCusto, valor: valorCusto);
      custosVariaveis.add(insumoCustoEntity);
      custoTotalMensal += double.parse(valorCusto);
      tamanhoCustos = custosVariaveis.length;
      validarValorTotalProjeto();
      AlertaSnack.exbirSnackBar(context, "Custo adicionado");
      //   calcularCustoHora();
    }
  }

  @action
  adicionarEquipe(context) {
    if (validarAdicaoEquipe()) {
      InsumoEstimativaCustoModel insumoCustoEntity =
          InsumoEstimativaCustoModel(nome: cargoMembro, valor: salarioMembro);
      equipe.add(insumoCustoEntity);
      custoTotalMensal += double.parse(salarioMembro);
      tamanhoEquipe = equipe.length;
      validarValorTotalProjeto();
      AlertaSnack.exbirSnackBar(context, "Membro adicionado a equipe");
      calcularCustoHora();
    }
  }

  @action
  validarValorTotalProjeto() {
    if (porcentagemLucro != 0) {
      valorPorcentagem = (custoBasico * (porcentagemLucro / 100));
      valorTotalProjeto = custoProjeto + valorPorcentagem;
    } else if (porcentagemLucro == 0) {
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

    if (valorCusto.isEmpty || valorCusto == "0.00") {
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

    if (salarioMembro.isEmpty || salarioMembro == "0.00") {
      textoErroSalarioMembro = "Salário não pode ser vazio";
      return false;
    }

    temErroSalarioMembro = false;
    textoErroSalarioMembro = "";

    return true;
  }

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
}
