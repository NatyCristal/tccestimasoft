import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:mobx/mobx.dart';

part 'store_estimativa_esforco.g.dart';

class StoreEstimativaEsforco = StoreEstimativaEsforcoBase
    with _$StoreEstimativaEsforco;

abstract class StoreEstimativaEsforcoBase with Store {
  @observable
  bool alteracores = false;

  @observable
  int tamanhoListaEsforco = 0;

  @observable
  List<EsforcoEntity> esforcos = [];

  @observable
  bool carregando = false;

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
  int valorTotalEsforco = 0;

  @observable
  List<String> pontoFuncaoHora = [];

  @action
  buscarListaEsforc(List<EsforcoEntity> esforcoEntity) {
    esforcos = esforcoEntity;
    tamanhoListaEsforco = esforcos.length;
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
    bool existe = false;
    for (var element in esforcos) {
      if (element.contagemPontoDeFuncao == contagemPF ||
          element.contagemPontoDeFuncao
              .contains(contagemPF.split(" - ").first)) {
        existe = true;
        return AlertaSnack.exbirSnackBar(
            context, "Existe uma extimativa com essa contagem");
      }
    }

    if (contagemPF.isNotEmpty && !existe) {
      EsforcoEntity esforcoEntity = EsforcoEntity(
          contagemPontoDeFuncao: contagemPF,
          linguagem: linguagemSelecionada,
          produtividadeEquipe: produtividadeEquipe,
          esforcoTotal: valorTotalEsforco.toString());

      esforcos.add(esforcoEntity);
      tamanhoListaEsforco = esforcos.length;
      alteracores = true;
    }
  }

  @action
  validarContagem() {
    // String contagemPF = "Indicativa - 47 PF";
    if (!contagemPF.contains(" 0 PF")) {
      int produtividade = int.parse(produtividadeEquipe.split(" - ").last);
      String text = contagemPF.split(" - ").last.split(" PF").first;
      int pf = int.parse(text);
      valorTotalEsforco = pf * produtividade;
      validarFasesDesenvolvimento();
    }
  }

  @action
  validarFasesDesenvolvimento() {
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
