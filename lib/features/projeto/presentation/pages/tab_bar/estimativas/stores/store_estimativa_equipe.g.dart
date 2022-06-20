// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_estimativa_equipe.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreEstimativaEquipe on StoreEstimativaEquipeBase, Store {
  late final _$carregandoAtom =
      Atom(name: 'StoreEstimativaEquipeBase.carregando', context: context);

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

  late final _$equipeEstimadaValorAtom = Atom(
      name: 'StoreEstimativaEquipeBase.equipeEstimadaValor', context: context);

  @override
  double get equipeEstimadaValor {
    _$equipeEstimadaValorAtom.reportRead();
    return super.equipeEstimadaValor;
  }

  @override
  set equipeEstimadaValor(double value) {
    _$equipeEstimadaValorAtom.reportWrite(value, super.equipeEstimadaValor, () {
      super.equipeEstimadaValor = value;
    });
  }

  late final _$esforcoSelecionadoAtom = Atom(
      name: 'StoreEstimativaEquipeBase.esforcoSelecionado', context: context);

  @override
  String get esforcoSelecionado {
    _$esforcoSelecionadoAtom.reportRead();
    return super.esforcoSelecionado;
  }

  @override
  set esforcoSelecionado(String value) {
    _$esforcoSelecionadoAtom.reportWrite(value, super.esforcoSelecionado, () {
      super.esforcoSelecionado = value;
    });
  }

  late final _$prazoSelecionadoAtom = Atom(
      name: 'StoreEstimativaEquipeBase.prazoSelecionado', context: context);

  @override
  String get prazoSelecionado {
    _$prazoSelecionadoAtom.reportRead();
    return super.prazoSelecionado;
  }

  @override
  set prazoSelecionado(String value) {
    _$prazoSelecionadoAtom.reportWrite(value, super.prazoSelecionado, () {
      super.prazoSelecionado = value;
    });
  }

  late final _$producaoDiariaAtom =
      Atom(name: 'StoreEstimativaEquipeBase.producaoDiaria', context: context);

  @override
  String get producaoDiaria {
    _$producaoDiariaAtom.reportRead();
    return super.producaoDiaria;
  }

  @override
  set producaoDiaria(String value) {
    _$producaoDiariaAtom.reportWrite(value, super.producaoDiaria, () {
      super.producaoDiaria = value;
    });
  }

  late final _$alteracaoAtom =
      Atom(name: 'StoreEstimativaEquipeBase.alteracao', context: context);

  @override
  bool get alteracao {
    _$alteracaoAtom.reportRead();
    return super.alteracao;
  }

  @override
  set alteracao(bool value) {
    _$alteracaoAtom.reportWrite(value, super.alteracao, () {
      super.alteracao = value;
    });
  }

  late final _$tamanhoEquipeAtom =
      Atom(name: 'StoreEstimativaEquipeBase.tamanhoEquipe', context: context);

  @override
  int get tamanhoEquipe {
    _$tamanhoEquipeAtom.reportRead();
    return super.tamanhoEquipe;
  }

  @override
  set tamanhoEquipe(int value) {
    _$tamanhoEquipeAtom.reportWrite(value, super.tamanhoEquipe, () {
      super.tamanhoEquipe = value;
    });
  }

  late final _$equipesAtom =
      Atom(name: 'StoreEstimativaEquipeBase.equipes', context: context);

  @override
  List<EquipeEntity> get equipes {
    _$equipesAtom.reportRead();
    return super.equipes;
  }

  @override
  set equipes(List<EquipeEntity> value) {
    _$equipesAtom.reportWrite(value, super.equipes, () {
      super.equipes = value;
    });
  }

  late final _$menuPrazoAtom =
      Atom(name: 'StoreEstimativaEquipeBase.menuPrazo', context: context);

  @override
  List<String> get menuPrazo {
    _$menuPrazoAtom.reportRead();
    return super.menuPrazo;
  }

  @override
  set menuPrazo(List<String> value) {
    _$menuPrazoAtom.reportWrite(value, super.menuPrazo, () {
      super.menuPrazo = value;
    });
  }

  late final _$menuEsforcoAtom =
      Atom(name: 'StoreEstimativaEquipeBase.menuEsforco', context: context);

  @override
  List<String> get menuEsforco {
    _$menuEsforcoAtom.reportRead();
    return super.menuEsforco;
  }

  @override
  set menuEsforco(List<String> value) {
    _$menuEsforcoAtom.reportWrite(value, super.menuEsforco, () {
      super.menuEsforco = value;
    });
  }

  late final _$StoreEstimativaEquipeBaseActionController =
      ActionController(name: 'StoreEstimativaEquipeBase', context: context);

  @override
  dynamic buscarListaEquipe(List<EquipeEntity> equipeEntity) {
    final _$actionInfo = _$StoreEstimativaEquipeBaseActionController
        .startAction(name: 'StoreEstimativaEquipeBase.buscarListaEquipe');
    try {
      return super.buscarListaEquipe(equipeEntity);
    } finally {
      _$StoreEstimativaEquipeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic estimarEquipe() {
    final _$actionInfo = _$StoreEstimativaEquipeBaseActionController
        .startAction(name: 'StoreEstimativaEquipeBase.estimarEquipe');
    try {
      return super.estimarEquipe();
    } finally {
      _$StoreEstimativaEquipeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic adicionarEquipe(dynamic context) {
    final _$actionInfo = _$StoreEstimativaEquipeBaseActionController
        .startAction(name: 'StoreEstimativaEquipeBase.adicionarEquipe');
    try {
      return super.adicionarEquipe(context);
    } finally {
      _$StoreEstimativaEquipeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic remover(EquipeEntity equipeEntity) {
    final _$actionInfo = _$StoreEstimativaEquipeBaseActionController
        .startAction(name: 'StoreEstimativaEquipeBase.remover');
    try {
      return super.remover(equipeEntity);
    } finally {
      _$StoreEstimativaEquipeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic exibirEsforcos(List<EsforcoEntity> esforcos) {
    final _$actionInfo = _$StoreEstimativaEquipeBaseActionController
        .startAction(name: 'StoreEstimativaEquipeBase.exibirEsforcos');
    try {
      return super.exibirEsforcos(esforcos);
    } finally {
      _$StoreEstimativaEquipeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic exibirPrazps(List<PrazoEntity> prazps) {
    final _$actionInfo = _$StoreEstimativaEquipeBaseActionController
        .startAction(name: 'StoreEstimativaEquipeBase.exibirPrazps');
    try {
      return super.exibirPrazps(prazps);
    } finally {
      _$StoreEstimativaEquipeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
carregando: ${carregando},
equipeEstimadaValor: ${equipeEstimadaValor},
esforcoSelecionado: ${esforcoSelecionado},
prazoSelecionado: ${prazoSelecionado},
producaoDiaria: ${producaoDiaria},
alteracao: ${alteracao},
tamanhoEquipe: ${tamanhoEquipe},
equipes: ${equipes},
menuPrazo: ${menuPrazo},
menuEsforco: ${menuEsforco}
    ''';
  }
}
