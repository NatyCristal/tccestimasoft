// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_recuperar_senha.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreLoginRecuperarSenha on StoreLoginRecuperarSenhaBase, Store {
  late final _$carregandoAtom =
      Atom(name: 'StoreLoginRecuperarSenhaBase.carregando', context: context);

  @override
  bool get carregando {
    _$carregandoAtom.reportRead();
    return super.carregando;
  }

  @override
  set carregando(bool value) {
    _$carregandoAtom.reportWrite(value, super.carregando, () {
      super.carregando = value;
    });
  }

  late final _$controllerEmailAtom = Atom(
      name: 'StoreLoginRecuperarSenhaBase.controllerEmail', context: context);

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
      Atom(name: 'StoreLoginRecuperarSenhaBase.temErroEmail', context: context);

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
      name: 'StoreLoginRecuperarSenhaBase.textoErroEmail', context: context);

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

  late final _$StoreLoginRecuperarSenhaBaseActionController =
      ActionController(name: 'StoreLoginRecuperarSenhaBase', context: context);

  @override
  dynamic validarEmail() {
    final _$actionInfo = _$StoreLoginRecuperarSenhaBaseActionController
        .startAction(name: 'StoreLoginRecuperarSenhaBase.validarEmail');
    try {
      return super.validarEmail();
    } finally {
      _$StoreLoginRecuperarSenhaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
carregando: ${carregando},
controllerEmail: ${controllerEmail},
temErroEmail: ${temErroEmail},
textoErroEmail: ${textoErroEmail}
    ''';
  }
}
