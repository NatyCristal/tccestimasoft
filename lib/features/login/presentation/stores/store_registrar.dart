import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'store_registrar.g.dart';

class StoreLoginRegistrar = StoreLoginRegistrarBase with _$StoreLoginRegistrar;

abstract class StoreLoginRegistrarBase with Store {
  @observable
  bool carregando = false;
  RegExp reGex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  @observable
  TextEditingController controllerEmail = TextEditingController();
  @observable
  TextEditingController controllerSenha = TextEditingController();
  @observable
  TextEditingController controllerNome = TextEditingController();
  @observable
  TextEditingController controllerConfirmacaoSenha = TextEditingController();

  @observable
  bool temErroNome = false;
  @observable
  String textoErroNome = "";

  @observable
  bool temErroEmail = false;
  @observable
  String textoErroEmail = "";

  @observable
  bool temErroSenha = false;
  @observable
  String textoErroSenha = "";

  @observable
  bool temErroConfirmacaoSenha = false;
  @observable
  String textoErroConfirmacaoSenha = "";

  @observable
  bool existeSenha = true;

  @action
  validarNome() {
    temErroNome = true;
    if (controllerNome.text.length < 4) {
      textoErroNome = "Nome pequeno";
      return false;
    }
    if (!controllerNome.text.contains(" ")) {
      textoErroNome = "Informe o nome completo";
      return false;
    }
    temErroNome = false;
    textoErroNome = "";
    return true;
  }

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

  @action
  validarSenhaComCampoConfirmacao() {
    return (validarSenha() && validarConfirmacaoSenha()) ? true : false;
  }

  @action
  validarConfirmacaoSenha() {
    temErroConfirmacaoSenha = true;
    if (controllerSenha.text != controllerConfirmacaoSenha.text) {
      textoErroConfirmacaoSenha = "Senhas não conferem";
      return false;
    }
    if (temErroSenha) {
      textoErroConfirmacaoSenha = "Senha pequena";
      return false;
    }
    if (controllerSenha.text == "") {
      textoErroConfirmacaoSenha = "Senha vazia";
      return false;
    }
    temErroConfirmacaoSenha = false;
    textoErroConfirmacaoSenha = "";
    return true;
  }
}
