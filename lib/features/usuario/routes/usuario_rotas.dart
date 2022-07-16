import 'package:flutter/services.dart';

class UsuarioRotas {
  static irParaLogin() {
    SystemNavigator.pop();

    // Modular.to
    //     .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);

    //Modular.to.popUntil("/login", (Route<dynamic> route) => false);
  }
}
