// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_autenticado_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioAutenticadoStore on UsuarioAutenticadoStoreBase, Store {
  late final _$emailAtom =
      Atom(name: 'UsuarioAutenticadoStoreBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$nomeAtom =
      Atom(name: 'UsuarioAutenticadoStoreBase.nome', context: context);

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$urlFotoAtom =
      Atom(name: 'UsuarioAutenticadoStoreBase.urlFoto', context: context);

  @override
  String get urlFoto {
    _$urlFotoAtom.reportRead();
    return super.urlFoto;
  }

  @override
  set urlFoto(String value) {
    _$urlFotoAtom.reportWrite(value, super.urlFoto, () {
      super.urlFoto = value;
    });
  }

  late final _$uidAtom =
      Atom(name: 'UsuarioAutenticadoStoreBase.uid', context: context);

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  late final _$UsuarioAutenticadoStoreBaseActionController =
      ActionController(name: 'UsuarioAutenticadoStoreBase', context: context);

  @override
  dynamic limparDados() {
    final _$actionInfo = _$UsuarioAutenticadoStoreBaseActionController
        .startAction(name: 'UsuarioAutenticadoStoreBase.limparDados');
    try {
      return super.limparDados();
    } finally {
      _$UsuarioAutenticadoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic pegarUsuario(User usuario) {
    final _$actionInfo = _$UsuarioAutenticadoStoreBaseActionController
        .startAction(name: 'UsuarioAutenticadoStoreBase.pegarUsuario');
    try {
      return super.pegarUsuario(usuario);
    } finally {
      _$UsuarioAutenticadoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic usuarioEhValido() {
    final _$actionInfo = _$UsuarioAutenticadoStoreBaseActionController
        .startAction(name: 'UsuarioAutenticadoStoreBase.usuarioEhValido');
    try {
      return super.usuarioEhValido();
    } finally {
      _$UsuarioAutenticadoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
nome: ${nome},
urlFoto: ${urlFoto},
uid: ${uid}
    ''';
  }
}
