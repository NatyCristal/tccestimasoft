// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_contagem_indicativa.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreContagemIndicativa on StoreContagemIndicativaBase, Store {
  late final _$contagemIndicativaValidaAtom = Atom(
      name: 'StoreContagemIndicativaBase.contagemIndicativaValida',
      context: context);

  @override
  ContagemIndicativaEntitie get contagemIndicativaValida {
    _$contagemIndicativaValidaAtom.reportRead();
    return super.contagemIndicativaValida;
  }

  @override
  set contagemIndicativaValida(ContagemIndicativaEntitie value) {
    _$contagemIndicativaValidaAtom
        .reportWrite(value, super.contagemIndicativaValida, () {
      super.contagemIndicativaValida = value;
    });
  }

  late final _$nomeDaFuncaoControllerAtom = Atom(
      name: 'StoreContagemIndicativaBase.nomeDaFuncaoController',
      context: context);

  @override
  TextEditingController get nomeDaFuncaoController {
    _$nomeDaFuncaoControllerAtom.reportRead();
    return super.nomeDaFuncaoController;
  }

  @override
  set nomeDaFuncaoController(TextEditingController value) {
    _$nomeDaFuncaoControllerAtom
        .reportWrite(value, super.nomeDaFuncaoController, () {
      super.nomeDaFuncaoController = value;
    });
  }

  late final _$descricaoControllerAtom = Atom(
      name: 'StoreContagemIndicativaBase.descricaoController',
      context: context);

  @override
  TextEditingController get descricaoController {
    _$descricaoControllerAtom.reportRead();
    return super.descricaoController;
  }

  @override
  set descricaoController(TextEditingController value) {
    _$descricaoControllerAtom.reportWrite(value, super.descricaoController, () {
      super.descricaoController = value;
    });
  }

  late final _$alteracoesAtom =
      Atom(name: 'StoreContagemIndicativaBase.alteracoes', context: context);

  @override
  bool get alteracoes {
    _$alteracoesAtom.reportRead();
    return super.alteracoes;
  }

  @override
  set alteracoes(bool value) {
    _$alteracoesAtom.reportWrite(value, super.alteracoes, () {
      super.alteracoes = value;
    });
  }

  late final _$carregouAtom =
      Atom(name: 'StoreContagemIndicativaBase.carregou', context: context);

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

  late final _$nomeDafuncaoAtom =
      Atom(name: 'StoreContagemIndicativaBase.nomeDafuncao', context: context);

  @override
  String get nomeDafuncao {
    _$nomeDafuncaoAtom.reportRead();
    return super.nomeDafuncao;
  }

  @override
  set nomeDafuncao(String value) {
    _$nomeDafuncaoAtom.reportWrite(value, super.nomeDafuncao, () {
      super.nomeDafuncao = value;
    });
  }

  late final _$tipoFuncaoAtom =
      Atom(name: 'StoreContagemIndicativaBase.tipoFuncao', context: context);

  @override
  String get tipoFuncao {
    _$tipoFuncaoAtom.reportRead();
    return super.tipoFuncao;
  }

  @override
  set tipoFuncao(String value) {
    _$tipoFuncaoAtom.reportWrite(value, super.tipoFuncao, () {
      super.tipoFuncao = value;
    });
  }

  late final _$descricaoAtom =
      Atom(name: 'StoreContagemIndicativaBase.descricao', context: context);

  @override
  String get descricao {
    _$descricaoAtom.reportRead();
    return super.descricao;
  }

  @override
  set descricao(String value) {
    _$descricaoAtom.reportWrite(value, super.descricao, () {
      super.descricao = value;
    });
  }

  late final _$totalPfAtom =
      Atom(name: 'StoreContagemIndicativaBase.totalPf', context: context);

  @override
  int get totalPf {
    _$totalPfAtom.reportRead();
    return super.totalPf;
  }

  @override
  set totalPf(int value) {
    _$totalPfAtom.reportWrite(value, super.totalPf, () {
      super.totalPf = value;
    });
  }

  late final _$tamanhoListaALIAtom = Atom(
      name: 'StoreContagemIndicativaBase.tamanhoListaALI', context: context);

  @override
  int get tamanhoListaALI {
    _$tamanhoListaALIAtom.reportRead();
    return super.tamanhoListaALI;
  }

  @override
  set tamanhoListaALI(int value) {
    _$tamanhoListaALIAtom.reportWrite(value, super.tamanhoListaALI, () {
      super.tamanhoListaALI = value;
    });
  }

  late final _$tamanhoListaAIEAtom = Atom(
      name: 'StoreContagemIndicativaBase.tamanhoListaAIE', context: context);

  @override
  int get tamanhoListaAIE {
    _$tamanhoListaAIEAtom.reportRead();
    return super.tamanhoListaAIE;
  }

  @override
  set tamanhoListaAIE(int value) {
    _$tamanhoListaAIEAtom.reportWrite(value, super.tamanhoListaAIE, () {
      super.tamanhoListaAIE = value;
    });
  }

  late final _$StoreContagemIndicativaBaseActionController =
      ActionController(name: 'StoreContagemIndicativaBase', context: context);

  @override
  dynamic adicionarFuncao(dynamic context, String funcao) {
    final _$actionInfo = _$StoreContagemIndicativaBaseActionController
        .startAction(name: 'StoreContagemIndicativaBase.adicionarFuncao');
    try {
      return super.adicionarFuncao(context, funcao);
    } finally {
      _$StoreContagemIndicativaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removerFuncao(String nomeDaFuncao, dynamic tipoFuncao) {
    final _$actionInfo = _$StoreContagemIndicativaBaseActionController
        .startAction(name: 'StoreContagemIndicativaBase.removerFuncao');
    try {
      return super.removerFuncao(nomeDaFuncao, tipoFuncao);
    } finally {
      _$StoreContagemIndicativaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic editar(String nomeDaFuncaoalterada, String tipoFuncao,
      String descricaoALterada) {
    final _$actionInfo = _$StoreContagemIndicativaBaseActionController
        .startAction(name: 'StoreContagemIndicativaBase.editar');
    try {
      return super.editar(nomeDaFuncaoalterada, tipoFuncao, descricaoALterada);
    } finally {
      _$StoreContagemIndicativaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic iniciarSessao(ContagemIndicativaEntitie contagemRecuperadaFirebase) {
    final _$actionInfo = _$StoreContagemIndicativaBaseActionController
        .startAction(name: 'StoreContagemIndicativaBase.iniciarSessao');
    try {
      return super.iniciarSessao(contagemRecuperadaFirebase);
    } finally {
      _$StoreContagemIndicativaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic salvar(ContagemIndicativaEntitie novaContagem) {
    final _$actionInfo = _$StoreContagemIndicativaBaseActionController
        .startAction(name: 'StoreContagemIndicativaBase.salvar');
    try {
      return super.salvar(novaContagem);
    } finally {
      _$StoreContagemIndicativaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contagemIndicativaValida: ${contagemIndicativaValida},
nomeDaFuncaoController: ${nomeDaFuncaoController},
descricaoController: ${descricaoController},
alteracoes: ${alteracoes},
carregou: ${carregou},
nomeDafuncao: ${nomeDafuncao},
tipoFuncao: ${tipoFuncao},
descricao: ${descricao},
totalPf: ${totalPf},
tamanhoListaALI: ${tamanhoListaALI},
tamanhoListaAIE: ${tamanhoListaAIE}
    ''';
  }
}
