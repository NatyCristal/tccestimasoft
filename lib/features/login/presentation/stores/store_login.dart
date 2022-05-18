import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'store_login.g.dart';

class StoreLogin = StoreLoginBase with _$StoreLogin;

abstract class StoreLoginBase with Store {
  @observable
  bool carregandoEntrar = false;

  @observable
  bool carregandogoogle = false;

  RegExp reGex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

  @observable
  TextEditingController controllerEmail = TextEditingController();
  @observable
  TextEditingController controllerSenha = TextEditingController();

  @observable
  bool temErroEmail = false;
  @observable
  String textoErroEmail = "";

  @observable
  bool temErroSenha = false;
  @observable
  String textoErroSenha = "";

  @observable
  bool existeSenha = true;

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

  @action
  validarSenha() {
    temErroSenha = true;
    if (controllerSenha.text.length < 6) {
      textoErroSenha = "Senha pequena";
      return false;
    }
    if (controllerSenha.text.isEmpty) {
      textoErroSenha = "Senha não pode ficar vazia";
      return false;
    }
    temErroSenha = false;
    textoErroSenha = "";
    return true;
  }
}
