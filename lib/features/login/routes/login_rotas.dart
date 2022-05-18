import 'package:flutter_modular/flutter_modular.dart';

class LoginRotas {
  static irParaRedefinirSenha() {
    Modular.to.pushNamed("redefinir-senha");
  }

  static irParaRegistrarUsuario() {
    Modular.to.pushNamed("registrar");
  }

  static irParaHomePage() {
    Modular.to.pushReplacementNamed("/projeto/");
  }

  static irParaLogin() {
    Modular.to.pushNamed("/login/");
  }
}
