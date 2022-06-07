// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_projeto_principal.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreProjetos on StoreProjetosBase, Store {
  late final _$tamanhoProjetosAtom =
      Atom(name: 'StoreProjetosBase.tamanhoProjetos', context: context);

  @override
  int get tamanhoProjetos {
    _$tamanhoProjetosAtom.reportRead();
    return super.tamanhoProjetos;
  }

  @override
  set tamanhoProjetos(int value) {
    _$tamanhoProjetosAtom.reportWrite(value, super.tamanhoProjetos, () {
      super.tamanhoProjetos = value;
    });
  }

  late final _$carregouAtom =
      Atom(name: 'StoreProjetosBase.carregou', context: context);

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

  late final _$exibirDrawerAtom =
      Atom(name: 'StoreProjetosBase.exibirDrawer', context: context);

  @override
  bool get exibirDrawer {
    _$exibirDrawerAtom.reportRead();
    return super.exibirDrawer;
  }

  @override
  set exibirDrawer(bool value) {
    _$exibirDrawerAtom.reportWrite(value, super.exibirDrawer, () {
      super.exibirDrawer = value;
    });
  }

  late final _$codEntrarProjetoAtom =
      Atom(name: 'StoreProjetosBase.codEntrarProjeto', context: context);

  @override
  String get codEntrarProjeto {
    _$codEntrarProjetoAtom.reportRead();
    return super.codEntrarProjeto;
  }

  @override
  set codEntrarProjeto(String value) {
    _$codEntrarProjetoAtom.reportWrite(value, super.codEntrarProjeto, () {
      super.codEntrarProjeto = value;
    });
  }

  late final _$erroCodEntrarProjetoAtom =
      Atom(name: 'StoreProjetosBase.erroCodEntrarProjeto', context: context);

  @override
  String get erroCodEntrarProjeto {
    _$erroCodEntrarProjetoAtom.reportRead();
    return super.erroCodEntrarProjeto;
  }

  @override
  set erroCodEntrarProjeto(String value) {
    _$erroCodEntrarProjetoAtom.reportWrite(value, super.erroCodEntrarProjeto,
        () {
      super.erroCodEntrarProjeto = value;
    });
  }

  late final _$nomeProjetoAtom =
      Atom(name: 'StoreProjetosBase.nomeProjeto', context: context);

  @override
  String get nomeProjeto {
    _$nomeProjetoAtom.reportRead();
    return super.nomeProjeto;
  }

  @override
  set nomeProjeto(String value) {
    _$nomeProjetoAtom.reportWrite(value, super.nomeProjeto, () {
      super.nomeProjeto = value;
    });
  }

  late final _$nomeProjetoErroAtom =
      Atom(name: 'StoreProjetosBase.nomeProjetoErro', context: context);

  @override
  String get nomeProjetoErro {
    _$nomeProjetoErroAtom.reportRead();
    return super.nomeProjetoErro;
  }

  @override
  set nomeProjetoErro(String value) {
    _$nomeProjetoErroAtom.reportWrite(value, super.nomeProjetoErro, () {
      super.nomeProjetoErro = value;
    });
  }

  late final _$StoreProjetosBaseActionController =
      ActionController(name: 'StoreProjetosBase', context: context);

  @override
  dynamic validarNomeProjeto() {
    final _$actionInfo = _$StoreProjetosBaseActionController.startAction(
        name: 'StoreProjetosBase.validarNomeProjeto');
    try {
      return super.validarNomeProjeto();
    } finally {
      _$StoreProjetosBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tamanhoProjetos: ${tamanhoProjetos},
carregou: ${carregou},
exibirDrawer: ${exibirDrawer},
codEntrarProjeto: ${codEntrarProjeto},
erroCodEntrarProjeto: ${erroCodEntrarProjeto},
nomeProjeto: ${nomeProjeto},
nomeProjetoErro: ${nomeProjetoErro}
    ''';
  }
}
