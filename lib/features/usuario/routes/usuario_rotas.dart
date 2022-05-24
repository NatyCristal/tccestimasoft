import 'package:flutter_modular/flutter_modular.dart';

class UsuarioRotas {
  static irParaLogin() {
    Modular.to.popAndPushNamed("/login/");
  }
}
