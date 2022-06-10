import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'store_editar_dados_usuario.g.dart';

class StoreEditarDadosUsuario = StoreEditarDadosUsuarioBase
    with _$StoreEditarDadosUsuario;

abstract class StoreEditarDadosUsuarioBase with Store {
  @observable
  TextEditingController controllerNome = TextEditingController()
    ..text = Modular.get<UsuarioAutenticado>().store.nome;

  @observable
  bool temErroNome = false;
  @observable
  String textoErroNome = "";

  @observable
  TextEditingController controllerEmail = TextEditingController()
    ..text = Modular.get<UsuarioAutenticado>().store.email;
  @observable
  bool temErroEmail = false;
  @observable
  String textoErroEmail = "";

  RegExp reGex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
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

  @observable
  bool carregou = false;
}
