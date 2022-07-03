// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_contagem_detalhada.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreContagemDetalhada on StoreContagemDetalhadaBase, Store {
  late final _$houveMudancaComplexidadeAtom = Atom(
      name: 'StoreContagemDetalhadaBase.houveMudancaComplexidade',
      context: context);

  @override
  bool get houveMudancaComplexidade {
    _$houveMudancaComplexidadeAtom.reportRead();
    return super.houveMudancaComplexidade;
  }

  @override
  set houveMudancaComplexidade(bool value) {
    _$houveMudancaComplexidadeAtom
        .reportWrite(value, super.houveMudancaComplexidade, () {
      super.houveMudancaComplexidade = value;
    });
  }

  late final _$contagemDetalhadaEntitieAtom = Atom(
      name: 'StoreContagemDetalhadaBase.contagemDetalhadaEntitie',
      context: context);

  @override
  ContagemDetalhadaEntitie get contagemDetalhadaEntitie {
    _$contagemDetalhadaEntitieAtom.reportRead();
    return super.contagemDetalhadaEntitie;
  }

  @override
  set contagemDetalhadaEntitie(ContagemDetalhadaEntitie value) {
    _$contagemDetalhadaEntitieAtom
        .reportWrite(value, super.contagemDetalhadaEntitie, () {
      super.contagemDetalhadaEntitie = value;
    });
  }

  late final _$totalPfFuncaoDeDadosAtom = Atom(
      name: 'StoreContagemDetalhadaBase.totalPfFuncaoDeDados',
      context: context);

  @override
  int get totalPfFuncaoDeDados {
    _$totalPfFuncaoDeDadosAtom.reportRead();
    return super.totalPfFuncaoDeDados;
  }

  @override
  set totalPfFuncaoDeDados(int value) {
    _$totalPfFuncaoDeDadosAtom.reportWrite(value, super.totalPfFuncaoDeDados,
        () {
      super.totalPfFuncaoDeDados = value;
    });
  }

  late final _$totalPfFuncaTransacionalAtom = Atom(
      name: 'StoreContagemDetalhadaBase.totalPfFuncaTransacional',
      context: context);

  @override
  int get totalPfFuncaTransacional {
    _$totalPfFuncaTransacionalAtom.reportRead();
    return super.totalPfFuncaTransacional;
  }

  @override
  set totalPfFuncaTransacional(int value) {
    _$totalPfFuncaTransacionalAtom
        .reportWrite(value, super.totalPfFuncaTransacional, () {
      super.totalPfFuncaTransacional = value;
    });
  }

  late final _$totalPfAtom =
      Atom(name: 'StoreContagemDetalhadaBase.totalPf', context: context);

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

  late final _$alteracoesAtom =
      Atom(name: 'StoreContagemDetalhadaBase.alteracoes', context: context);

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

  late final _$carregandoAtom =
      Atom(name: 'StoreContagemDetalhadaBase.carregando', context: context);

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

  late final _$StoreContagemDetalhadaBaseActionController =
      ActionController(name: 'StoreContagemDetalhadaBase', context: context);

  @override
  dynamic adicionarQuantidade(IndiceDetalhada indice, String tipoFuncao) {
    final _$actionInfo = _$StoreContagemDetalhadaBaseActionController
        .startAction(name: 'StoreContagemDetalhadaBase.adicionarQuantidade');
    try {
      return super.adicionarQuantidade(indice, tipoFuncao);
    } finally {
      _$StoreContagemDetalhadaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic validar(dynamic context) {
    final _$actionInfo = _$StoreContagemDetalhadaBaseActionController
        .startAction(name: 'StoreContagemDetalhadaBase.validar');
    try {
      return super.validar(context);
    } finally {
      _$StoreContagemDetalhadaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic verificaValorTiposFuncoes(
      IndiceDetalhada indiceDetalhadaModel, List<IndiceDetalhada> dados) {
    final _$actionInfo =
        _$StoreContagemDetalhadaBaseActionController.startAction(
            name: 'StoreContagemDetalhadaBase.verificaValorTiposFuncoes');
    try {
      return super.verificaValorTiposFuncoes(indiceDetalhadaModel, dados);
    } finally {
      _$StoreContagemDetalhadaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic calcularPFFuncaoTransacional() {
    final _$actionInfo =
        _$StoreContagemDetalhadaBaseActionController.startAction(
            name: 'StoreContagemDetalhadaBase.calcularPFFuncaoTransacional');
    try {
      return super.calcularPFFuncaoTransacional();
    } finally {
      _$StoreContagemDetalhadaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic calcularPFFuncaoDados() {
    final _$actionInfo = _$StoreContagemDetalhadaBaseActionController
        .startAction(name: 'StoreContagemDetalhadaBase.calcularPFFuncaoDados');
    try {
      return super.calcularPFFuncaoDados();
    } finally {
      _$StoreContagemDetalhadaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic receberDados(ContagemEstimadaEntitie contagemEstimada,
      ContagemIndicativaEntitie contagemIndicativa) {
    final _$actionInfo = _$StoreContagemDetalhadaBaseActionController
        .startAction(name: 'StoreContagemDetalhadaBase.receberDados');
    try {
      return super.receberDados(contagemEstimada, contagemIndicativa);
    } finally {
      _$StoreContagemDetalhadaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic iniciarSessao(ContagemDetalhadaEntitie contagemRecuperadaFirebase) {
    final _$actionInfo = _$StoreContagemDetalhadaBaseActionController
        .startAction(name: 'StoreContagemDetalhadaBase.iniciarSessao');
    try {
      return super.iniciarSessao(contagemRecuperadaFirebase);
    } finally {
      _$StoreContagemDetalhadaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic salvar(ContagemDetalhadaEntitie novaContagem) {
    final _$actionInfo = _$StoreContagemDetalhadaBaseActionController
        .startAction(name: 'StoreContagemDetalhadaBase.salvar');
    try {
      return super.salvar(novaContagem);
    } finally {
      _$StoreContagemDetalhadaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
houveMudancaComplexidade: ${houveMudancaComplexidade},
contagemDetalhadaEntitie: ${contagemDetalhadaEntitie},
totalPfFuncaoDeDados: ${totalPfFuncaoDeDados},
totalPfFuncaTransacional: ${totalPfFuncaTransacional},
totalPf: ${totalPf},
alteracoes: ${alteracoes},
carregando: ${carregando}
    ''';
  }
}
