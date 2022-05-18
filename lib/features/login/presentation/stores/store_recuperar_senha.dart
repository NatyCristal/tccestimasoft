import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'store_recuperar_senha.g.dart';

class StoreLoginRecuperarSenha = StoreLoginRecuperarSenhaBase
    with _$StoreLoginRecuperarSenha;

abstract class StoreLoginRecuperarSenhaBase with Store {
  @observable
  bool carregando = false;

  RegExp reGex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

  @observable
  TextEditingController controllerEmail = TextEditingController();

  @observable
  bool temErroEmail = false;
  @observable
  String textoErroEmail = "";

  @action
  validarEmail() {
    temErroEmail = true;

    if (!reGex.hasMatch(controllerEmail.text) ||
        controllerEmail.text.length <= 3) {
      textoErroEmail = "E-mail inválido";
      return false;
    }
    temErroEmail = false;
    textoErroEmail = "";
    return true;
  }
}
