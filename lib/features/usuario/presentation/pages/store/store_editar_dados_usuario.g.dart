// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_editar_dados_usuario.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreEditarDadosUsuario on StoreEditarDadosUsuarioBase, Store {
  late final _$controllerNomeAtom = Atom(
      name: 'StoreEditarDadosUsuarioBase.controllerNome', context: context);

  @override
  TextEditingController get controllerNome {
    _$controllerNomeAtom.reportRead();
    return super.controllerNome;
  }

  @override
  set controllerNome(TextEditingController value) {
    _$controllerNomeAtom.reportWrite(value, super.controllerNome, () {
      super.controllerNome = value;
    });
  }

  late final _$temErroNomeAtom =
      Atom(name: 'StoreEditarDadosUsuarioBase.temErroNome', context: context);

  @override
  bool get temErroNome {
    _$temErroNomeAtom.reportRead();
    return super.temErroNome;
  }

  @override
  set temErroNome(bool value) {
    _$temErroNomeAtom.reportWrite(value, super.temErroNome, () {
      super.temErroNome = value;
    });
  }

  late final _$textoErroNomeAtom =
      Atom(name: 'StoreEditarDadosUsuarioBase.textoErroNome', context: context);

  @override
  String get textoErroNome {
    _$textoErroNomeAtom.reportRead();
    return super.textoErroNome;
  }

  @override
  set textoErroNome(String value) {
    _$textoErroNomeAtom.reportWrite(value, super.textoErroNome, () {
      super.textoErroNome = value;
    });
  }

  late final _$controllerEmailAtom = Atom(
      name: 'StoreEditarDadosUsuarioBase.controllerEmail', context: context);

  @override
  TextEditingController get controllerEmail {
    _$controllerEmailAtom.reportRead();
    return super.controllerEmail;
  }

  @override
  set controllerEmail(TextEditingController value) {
    _$controllerEmailAtom.reportWrite(value, super.controllerEmail, () {
      super.controllerEmail = value;
    });
  }

  late final _$temErroEmailAtom =
      Atom(name: 'StoreEditarDadosUsuarioBase.temErroEmail', context: context);

  @override
  bool get temErroEmail {
    _$temErroEmailAtom.reportRead();
    return super.temErroEmail;
  }

  @override
  set temErroEmail(bool value) {
    _$temErroEmailAtom.reportWrite(value, super.temErroEmail, () {
      super.temErroEmail = value;
    });
  }

  late final _$textoErroEmailAtom = Atom(
      name: 'StoreEditarDadosUsuarioBase.textoErroEmail', context: context);

  @override
  String get textoErroEmail {
    _$textoErroEmailAtom.reportRead();
    return super.textoErroEmail;
  }

  @override
  set textoErroEmail(String value) {
    _$textoErroEmailAtom.reportWrite(value, super.textoErroEmail, () {
      super.textoErroEmail = value;
    });
  }

  late final _$carregouAtom =
      Atom(name: 'StoreEditarDadosUsuarioBase.carregou', context: context);

  @override
  bool get carregou {
    _$carregouAtom.reportRead();
    return super.carregou;
  }

  @override
  set carregou(bool value) {
    _$carregouAtom.reportWrite(value, super.carregou, () {
      super.carregou = value;
    });
  }

  late final _$StoreEditarDadosUsuarioBaseActionController =
      ActionController(name: 'StoreEditarDadosUsuarioBase', context: context);

  @override
  dynamic validarEmail() {
    final _$actionInfo = _$StoreEditarDadosUsuarioBaseActionController
        .startAction(name: 'StoreEditarDadosUsuarioBase.validarEmail');
    try {
      return super.validarEmail();
    } finally {
      _$StoreEditarDadosUsuarioBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic validarNome() {
    final _$actionInfo = _$StoreEditarDadosUsuarioBaseActionController
        .startAction(name: 'StoreEditarDadosUsuarioBase.validarNome');
    try {
      return super.validarNome();
    } finally {
      _$StoreEditarDadosUsuarioBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controllerNome: ${controllerNome},
temErroNome: ${temErroNome},
textoErroNome: ${textoErroNome},
controllerEmail: ${controllerEmail},
temErroEmail: ${temErroEmail},
textoErroEmail: ${textoErroEmail},
carregou: ${carregou}
    ''';
  }
}
