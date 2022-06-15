import 'dart:math';

import 'package:mobx/mobx.dart';

part 'store_estimativa_prazo.g.dart';

class StoreEstimativaPrazo = StoreEstimativaPrazoBase
    with _$StoreEstimativaPrazo;

abstract class StoreEstimativaPrazoBase with Store {
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
  buscarExpoenteT() {
    if (tipoSistemaSelecionado != "") {
      switch (tipoSistemaSelecionado) {
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
    contagemPF = "Indicativa - 45 PF";
    if (!contagemPF.contains(" 0 PF")) {
      // int produtividade = int.parse(produtividadeEquipe.split(" - ").last);
      String text = contagemPF.split(" - ").last.split(" PF").first;
      tamanhoPf = int.parse(text);
      if (tamanhoPf <= 110) {
        prazoTotal = calcularTamanhoMinimo();
      } else {
        prazoTotal = calcularPrazo();
      }

      regiaoDoImpossivel = 0.75 * prazoTotal;
    }
  }

  calcularPrazo() {
    return pow(tamanhoPf, buscarExpoenteT());
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
    } else if (tamanhoPf >= 71 && tamanhoPf <= 80) {
      return 70.0;
    } else if (tamanhoPf >= 86 && tamanhoPf <= 99) {
      return 79.0;
    }
  }
}
