import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuarioRotas {
  static irParaLogin() {
    Modular.to
        .pushNamedAndRemoveUntil("login", (Route<dynamic> route) => false);

    //Modular.to.popUntil("/login", (Route<dynamic> route) => false);
  }
}
