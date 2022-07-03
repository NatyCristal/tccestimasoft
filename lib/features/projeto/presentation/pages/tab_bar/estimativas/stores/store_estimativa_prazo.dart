import 'dart:math';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:mobx/mobx.dart';

part 'store_estimativa_prazo.g.dart';

class StoreEstimativaPrazo = StoreEstimativaPrazoBase
    with _$StoreEstimativaPrazo;

abstract class StoreEstimativaPrazoBase with Store {
  @observable
  String valorTotalEmDias = "0";

  @observable
  String valorEmDiasReagiaoDoImpossivel = "0";

  @observable
  int tamanhoListaPrazo = 0;

  @observable
  List<PrazoEntity> prazos = [];

  @observable
  bool alteracao = false;

  @observable
  bool carregando = false;

  @observable
  String contagemPF = "";

  @observable
  int tamanhoPf = 0;

  @observable
  double prazoTotal = 0;
  @observable
  double regiaoDoImpossivel = 0;

  @observable
  List<PrazoEntity> prazosValidos = [];

  List<String> tipoSistema = [
    "Sistema Comum - Mainframe",
    "Sistema Comum - Web",
    "Sistema OO",
    "Sistema Cliente/Servidor (alta complexidade)",
    "Sistemas Gerenciais complexos",
    "Software Basico, frameworks, Sistemas Comerciais"
  ];

  @observable
  String tipoSistemaSelecionado = "Sistema Comum - Mainframe";

  @action
  buscarListaPrazp(List<PrazoEntity> prazoEntity) {
    prazos = prazoEntity;
    tamanhoListaPrazo = prazoEntity.length;
    prazosValidos = prazoEntity;
  }

  @action
  remover(PrazoEntity prazoEntity) {
    prazos.removeWhere((element) {
      return element.contagemPontoDeFuncao == prazoEntity.contagemPontoDeFuncao;
    });
    alteracao = true;

    tamanhoListaPrazo = prazos.length;
  }

  @action
  adicionarPrazo(context) {
    bool existe = false;
    for (var element in prazos) {
      if (element.contagemPontoDeFuncao == contagemPF ||
          element.contagemPontoDeFuncao
              .contains(contagemPF.split(" - ").first)) {
        existe = true;
        return AlertaSnack.exbirSnackBar(
            context, "Existe uma estimativa com essa contagem");
      }
    }

    if (contagemPF.isNotEmpty && !existe) {
      PrazoEntity prazoEntity = PrazoEntity(
          compartilhada: false,
          contagemPontoDeFuncao: contagemPF,
          tipoSistema: tipoSistemaSelecionado,
          prazoMinimo: valorEmDiasReagiaoDoImpossivel,
          prazoTotal: double.parse(valorTotalEmDias));

      prazos.add(prazoEntity);
      tamanhoListaPrazo = prazos.length;
      alteracao = true;
    }
  }

  @action
  buscarExpoenteT(String tipoSistemaBusca) {
    if (tipoSistemaBusca != "") {
      switch (tipoSistemaBusca) {
        case "Sistema Comum - Mainframe":
          return 0.32;
        case "Sistema Comum - Web":
          return 0.34;
        case "Sistema OO":
          return 0.36;
        case "Sistema Cliente/Servidor (alta complexidade)":
          return 0.37;
        case "Sistemas Gerenciais complexos":
          return 0.39;
        case "Software Basico, frameworks, Sistemas Comerciais":
          return 0.4;

        default:
          0.0;
          break;
      }
    }
  }

  @action
  validarContagem() {
    if (!contagemPF.contains(" 0 PF")) {
      // int produtividade = int.parse(produtividadeEquipe.split(" - ").last);
      String text = contagemPF.split(" - ").last.split(" PF").first;
      tamanhoPf = int.parse(text);
      if (tamanhoPf <= 110) {
        prazoTotal = calcularTamanhoMinimo();
        valorTotalEmDias = prazoTotal.toString();
        regiaoDoImpossivel = (0.75 * prazoTotal);
        valorEmDiasReagiaoDoImpossivel = regiaoDoImpossivel.toString();
      } else {
        prazoTotal = calcularPrazo();
        valorTotalEmDias = (prazoTotal * 30).toStringAsFixed(2);

        regiaoDoImpossivel = (0.75 * prazoTotal);
        valorEmDiasReagiaoDoImpossivel =
            (regiaoDoImpossivel * 30).toStringAsFixed(2);
      }
    }
  }

  calcularPrazo() {
    return pow(tamanhoPf, buscarExpoenteT(tipoSistemaSelecionado));
  }

  calcularTamanhoMinimo() {
    if (tamanhoPf <= 10) {
      return 9.0;
    } else if (tamanhoPf >= 11 && tamanhoPf <= 20) {
      return 18.0;
    } else if (tamanhoPf >= 21 && tamanhoPf <= 30) {
      return 27.0;
    } else if (tamanhoPf >= 31 && tamanhoPf <= 40) {
      return 36.0;
    } else if (tamanhoPf >= 41 && tamanhoPf <= 50) {
      return 45.0;
    } else if (tamanhoPf >= 51 && tamanhoPf <= 60) {
      return 54.0;
    } else if (tamanhoPf >= 61 && tamanhoPf <= 70) {
      return 63.0;
    } else if (tamanhoPf >= 71 && tamanhoPf <= 85) {
      return 70.0;
    } else if (tamanhoPf >= 86 && tamanhoPf <= 99) {
      return 79.0;
    }
  }

  calcularTamanhoComplexidadeMedia() {
    if (tamanhoPf <= 10) {
      return 15.0;
    } else if (tamanhoPf >= 11 && tamanhoPf <= 20) {
      return 30.0;
    } else if (tamanhoPf >= 21 && tamanhoPf <= 30) {
      return 45.0;
    } else if (tamanhoPf >= 31 && tamanhoPf <= 40) {
      return 60.0;
    } else if (tamanhoPf >= 41 && tamanhoPf <= 50) {
      return 75.0;
    } else if (tamanhoPf >= 51 && tamanhoPf <= 60) {
      return 90.0;
    } else if (tamanhoPf >= 61 && tamanhoPf <= 70) {
      return 105.0;
    } else if (tamanhoPf >= 71 && tamanhoPf <= 85) {
      return 110.0;
    } else if (tamanhoPf >= 86 && tamanhoPf <= 99) {
      return 110.0;
    }
  }
}
