import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:mobx/mobx.dart';

part 'store_estimativa_esforco.g.dart';

class StoreEstimativaEsforco = StoreEstimativaEsforcoBase
    with _$StoreEstimativaEsforco;

abstract class StoreEstimativaEsforcoBase with Store {
  @observable
  String erroProdutividadePropria = "";
  @observable
  bool ehValidoProdutovidadePropria = false;

  @observable
  bool utilizarProdutividadePropria = false;

  @observable
  bool isVisualizacao = false;

  @observable
  List<EsforcoEntity> esforcosValidos = [];

  @observable
  bool alteracores = false;

  @observable
  int tamanhoListaEsforco = 0;

  @observable
  List<EsforcoEntity> esforcos = [];

  final _engenhariaRequisitos = 0.25;
  final _design = 0.1;
  final _implementacao = 0.4;
  final _testes = 0.15;
  final _homologacao = 0.05;
  final _implantacao = 0.05;

  @observable
  double valorEngenhariaRequisitos = 0;
  @observable
  double valorDesign = 0;
  @observable
  double valorImplementacao = 0;
  @observable
  double valorTestes = 0;
  @observable
  double valorHomologacao = 0;
  @observable
  double valorImplantacao = 0;

  @observable
  String linguagemSelecionada = "ACCESS";

  @observable
  String produtividadeEquipe = "MEDIA - 11";

  @observable
  String contagemPF = "";

  @observable
  List<String> contagens = [];

  @observable
  int valorTotalEsforco = 0;

  @observable
  List<String> pontoFuncaoHora = [];

  @action
  buscarListaEsforc(List<EsforcoEntity> esforcoEntity) {
    esforcos = esforcoEntity;
    tamanhoListaEsforco = esforcos.length;
    if (esforcosValidos.isEmpty) {
      esforcosValidos = esforcoEntity;
    }
  }

  @action
  remover(EsforcoEntity esforcoEntity) {
    esforcos.removeWhere((element) {
      return element.contagemPontoDeFuncao ==
          esforcoEntity.contagemPontoDeFuncao;
    });
    alteracores = true;

    tamanhoListaEsforco = esforcos.length;
  }

  @action
  adicionarEsforco(context) {
    if (esforcos.isEmpty) {
      if (validarProdutividadeEquipe()) {
        for (var element in contagens) {
          contagemPF = element.split(" - ").last;
          String tipoContagem = element.split(" - ").first;
          validarContagem();
          validarFasesDesenvolvimento(valorTotalEsforco);

          EsforcoEntity esforcoEntity = EsforcoEntity(
              compartilhada: false,
              contagemPontoDeFuncao: tipoContagem,
              linguagem: linguagemSelecionada,
              produtividadeEquipe: produtividadeEquipe,
              esforcoTotal: valorTotalEsforco.toString());

          esforcos.add(esforcoEntity);
        }
      } else {
        AlertaSnack.exbirSnackBar(context, "Informe a produtividade da equipe");
      }
    }

    tamanhoListaEsforco = esforcos.length;
    alteracores = true;
  }

  @action
  validarProdutividadeEquipe() {
    if (produtividadeEquipe.split(" - ").last != "0") {
      erroProdutividadePropria = "";
      return true;
    } else if (produtividadeEquipe.split(" - ").last == "0") {
      erroProdutividadePropria = "Informe um valor maior que zero";

      return false;
    }

    return false;
  }

  @action
  validarContagem() {
    if (!contagemPF.contains(" 0 PF") &&
        produtividadeEquipe.split(" - ").last != "0") {
      erroProdutividadePropria = "";
      int produtividade = int.parse(produtividadeEquipe.split(" - ").last);
      String text = contagemPF.split(" - ").last;
      int pf = int.parse(text);
      valorTotalEsforco = pf * produtividade;
      validarFasesDesenvolvimento(valorTotalEsforco);
    }
  }

  @action
  validarFasesDesenvolvimento(int valor) {
    valorTotalEsforco = valor;
    if (valorTotalEsforco > 0) {
      valorEngenhariaRequisitos = _engenhariaRequisitos * valorTotalEsforco;
      valorDesign = _design * valorTotalEsforco;
      valorHomologacao = _homologacao * valorTotalEsforco;
      valorImplantacao = _implantacao * valorTotalEsforco;
      valorTestes = _testes * valorTotalEsforco;
      valorImplementacao = _implementacao * valorTotalEsforco;
    }
  }
}
