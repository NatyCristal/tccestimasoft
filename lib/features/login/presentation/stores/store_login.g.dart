// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreLogin on StoreLoginBase, Store {
  late final _$carregandoEntrarAtom =
      Atom(name: 'StoreLoginBase.carregandoEntrar', context: context);

  @override
  bool get carregandoEntrar {
    _$carregandoEntrarAtom.reportRead();
    return super.carregandoEntrar;
  }

  @override
  set carregandoEntrar(bool value) {
    _$carregandoEntrarAtom.reportWrite(value, super.carregandoEntrar, () {
      super.carregandoEntrar = value;
    });
  }

  late final _$carregandogoogleAtom =
      Atom(name: 'StoreLoginBase.carregandogoogle', context: context);

  @override
  bool get carregandogoogle {
    _$carregandogoogleAtom.reportRead();
    return super.carregandogoogle;
  }

  @override
  set carregandogoogle(bool value) {
    _$carregandogoogleAtom.reportWrite(value, super.carregandogoogle, () {
      super.carregandogoogle = value;
    });
  }

  late final _$controllerEmailAtom =
      Atom(name: 'StoreLoginBase.controllerEmail', context: context);

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

  late final _$controllerSenhaAtom =
      Atom(name: 'StoreLoginBase.controllerSenha', context: context);

  @override
  TextEditingController get controllerSenha {
    _$controllerSenhaAtom.reportRead();
    return super.controllerSenha;
  }

  @override
  set controllerSenha(TextEditingController value) {
    _$controllerSenhaAtom.reportWrite(value, super.controllerSenha, () {
      super.controllerSenha = value;
    });
  }

  late final _$temErroEmailAtom =
      Atom(name: 'StoreLoginBase.temErroEmail', context: context);

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

  late final _$textoErroEmailAtom =
      Atom(name: 'StoreLoginBase.textoErroEmail', context: context);

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

  late final _$temErroSenhaAtom =
      Atom(name: 'StoreLoginBase.temErroSenha', context: context);

  @override
  bool get temErroSenha {
    _$temErroSenhaAtom.reportRead();
    return super.temErroSenha;
  }

  @override
  set temErroSenha(bool value) {
    _$temErroSenhaAtom.reportWrite(value, super.temErroSenha, () {
      super.temErroSenha = value;
    });
  }

  late final _$textoErroSenhaAtom =
      Atom(name: 'StoreLoginBase.textoErroSenha', context: context);

  @override
  String get textoErroSenha {
    _$textoErroSenhaAtom.reportRead();
    return super.textoErroSenha;
  }

  @override
  set textoErroSenha(String value) {
    _$textoErroSenhaAtom.reportWrite(value, super.textoErroSenha, () {
      super.textoErroSenha = value;
    });
  }

  late final _$existeSenhaAtom =
      Atom(name: 'StoreLoginBase.existeSenha', context: context);

  @override
  bool get existeSenha {
    _$existeSenhaAtom.reportRead();
    return super.existeSenha;
  }

  @override
  set existeSenha(bool value) {
    _$existeSenhaAtom.reportWrite(value, super.existeSenha, () {
      super.existeSenha = value;
    });
  }

  late final _$StoreLoginBaseActionController =
      ActionController(name: 'StoreLoginBase', context: context);

  @override
  dynamic validarEmail() {
    final _$actionInfo = _$StoreLoginBaseActionController.startAction(
        name: 'StoreLoginBase.validarEmail');
    try {
      return super.validarEmail();
    } finally {
      _$StoreLoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic validarSenha() {
    final _$actionInfo = _$StoreLoginBaseActionController.startAction(
        name: 'StoreLoginBase.validarSenha');
    try {
      return super.validarSenha();
    } finally {
      _$StoreLoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
carregandoEntrar: ${carregandoEntrar},
carregandogoogle: ${carregandogoogle},
controllerEmail: ${controllerEmail},
controllerSenha: ${controllerSenha},
temErroEmail: ${temErroEmail},
textoErroEmail: ${textoErroEmail},
temErroSenha: ${temErroSenha},
textoErroSenha: ${textoErroSenha},
existeSenha: ${existeSenha}
    ''';
  }
}
