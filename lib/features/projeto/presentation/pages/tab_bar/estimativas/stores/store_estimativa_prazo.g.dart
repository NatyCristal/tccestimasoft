// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_estimativa_prazo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreEstimativaPrazo on StoreEstimativaPrazoBase, Store {
  late final _$valorTotalEmDiasAtom =
      Atom(name: 'StoreEstimativaPrazoBase.valorTotalEmDias', context: context);

  @override
  String get valorTotalEmDias {
    _$valorTotalEmDiasAtom.reportRead();
    return super.valorTotalEmDias;
  }

  @override
  set valorTotalEmDias(String value) {
    _$valorTotalEmDiasAtom.reportWrite(value, super.valorTotalEmDias, () {
      super.valorTotalEmDias = value;
    });
  }

  late final _$valorEmDiasReagiaoDoImpossivelAtom = Atom(
      name: 'StoreEstimativaPrazoBase.valorEmDiasReagiaoDoImpossivel',
      context: context);

  @override
  String get valorEmDiasReagiaoDoImpossivel {
    _$valorEmDiasReagiaoDoImpossivelAtom.reportRead();
    return super.valorEmDiasReagiaoDoImpossivel;
  }

  @override
  set valorEmDiasReagiaoDoImpossivel(String value) {
    _$valorEmDiasReagiaoDoImpossivelAtom
        .reportWrite(value, super.valorEmDiasReagiaoDoImpossivel, () {
      super.valorEmDiasReagiaoDoImpossivel = value;
    });
  }

  late final _$tamanhoListaPrazoAtom = Atom(
      name: 'StoreEstimativaPrazoBase.tamanhoListaPrazo', context: context);

  @override
  int get tamanhoListaPrazo {
    _$tamanhoListaPrazoAtom.reportRead();
    return super.tamanhoListaPrazo;
  }

  @override
  set tamanhoListaPrazo(int value) {
    _$tamanhoListaPrazoAtom.reportWrite(value, super.tamanhoListaPrazo, () {
      super.tamanhoListaPrazo = value;
    });
  }

  late final _$prazosAtom =
      Atom(name: 'StoreEstimativaPrazoBase.prazos', context: context);

  @override
  List<PrazoEntity> get prazos {
    _$prazosAtom.reportRead();
    return super.prazos;
  }

  @override
  set prazos(List<PrazoEntity> value) {
    _$prazosAtom.reportWrite(value, super.prazos, () {
      super.prazos = value;
    });
  }

  late final _$alteracaoAtom =
      Atom(name: 'StoreEstimativaPrazoBase.alteracao', context: context);

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

  late final _$carregandoAtom =
      Atom(name: 'StoreEstimativaPrazoBase.carregando', context: context);

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

  late final _$contagemPFAtom =
      Atom(name: 'StoreEstimativaPrazoBase.contagemPF', context: context);

  @override
  String get contagemPF {
    _$contagemPFAtom.reportRead();
    return super.contagemPF;
  }

  @override
  set contagemPF(String value) {
    _$contagemPFAtom.reportWrite(value, super.contagemPF, () {
      super.contagemPF = value;
    });
  }

  late final _$tamanhoPfAtom =
      Atom(name: 'StoreEstimativaPrazoBase.tamanhoPf', context: context);

  @override
  int get tamanhoPf {
    _$tamanhoPfAtom.reportRead();
    return super.tamanhoPf;
  }

  @override
  set tamanhoPf(int value) {
    _$tamanhoPfAtom.reportWrite(value, super.tamanhoPf, () {
      super.tamanhoPf = value;
    });
  }

  late final _$prazoTotalAtom =
      Atom(name: 'StoreEstimativaPrazoBase.prazoTotal', context: context);

  @override
  double get prazoTotal {
    _$prazoTotalAtom.reportRead();
    return super.prazoTotal;
  }

  @override
  set prazoTotal(double value) {
    _$prazoTotalAtom.reportWrite(value, super.prazoTotal, () {
      super.prazoTotal = value;
    });
  }

  late final _$regiaoDoImpossivelAtom = Atom(
      name: 'StoreEstimativaPrazoBase.regiaoDoImpossivel', context: context);

  @override
  double get regiaoDoImpossivel {
    _$regiaoDoImpossivelAtom.reportRead();
    return super.regiaoDoImpossivel;
  }

  @override
  set regiaoDoImpossivel(double value) {
    _$regiaoDoImpossivelAtom.reportWrite(value, super.regiaoDoImpossivel, () {
      super.regiaoDoImpossivel = value;
    });
  }

  late final _$tipoSistemaSelecionadoAtom = Atom(
      name: 'StoreEstimativaPrazoBase.tipoSistemaSelecionado',
      context: context);

  @override
  String get tipoSistemaSelecionado {
    _$tipoSistemaSelecionadoAtom.reportRead();
    return super.tipoSistemaSelecionado;
  }

  @override
  set tipoSistemaSelecionado(String value) {
    _$tipoSistemaSelecionadoAtom
        .reportWrite(value, super.tipoSistemaSelecionado, () {
      super.tipoSistemaSelecionado = value;
    });
  }

  late final _$StoreEstimativaPrazoBaseActionController =
      ActionController(name: 'StoreEstimativaPrazoBase', context: context);

  @override
  dynamic buscarListaPrazp(List<PrazoEntity> prazoEntity) {
    final _$actionInfo = _$StoreEstimativaPrazoBaseActionController.startAction(
        name: 'StoreEstimativaPrazoBase.buscarListaPrazp');
    try {
      return super.buscarListaPrazp(prazoEntity);
    } finally {
      _$StoreEstimativaPrazoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic remover(PrazoEntity prazoEntity) {
    final _$actionInfo = _$StoreEstimativaPrazoBaseActionController.startAction(
        name: 'StoreEstimativaPrazoBase.remover');
    try {
      return super.remover(prazoEntity);
    } finally {
      _$StoreEstimativaPrazoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic adicionarPrazo(dynamic context) {
    final _$actionInfo = _$StoreEstimativaPrazoBaseActionController.startAction(
        name: 'StoreEstimativaPrazoBase.adicionarPrazo');
    try {
      return super.adicionarPrazo(context);
    } finally {
      _$StoreEstimativaPrazoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buscarExpoenteT() {
    final _$actionInfo = _$StoreEstimativaPrazoBaseActionController.startAction(
        name: 'StoreEstimativaPrazoBase.buscarExpoenteT');
    try {
      return super.buscarExpoenteT();
    } finally {
      _$StoreEstimativaPrazoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic validarContagem() {
    final _$actionInfo = _$StoreEstimativaPrazoBaseActionController.startAction(
        name: 'StoreEstimativaPrazoBase.validarContagem');
    try {
      return super.validarContagem();
    } finally {
      _$StoreEstimativaPrazoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
valorTotalEmDias: ${valorTotalEmDias},
valorEmDiasReagiaoDoImpossivel: ${valorEmDiasReagiaoDoImpossivel},
tamanhoListaPrazo: ${tamanhoListaPrazo},
prazos: ${prazos},
alteracao: ${alteracao},
carregando: ${carregando},
contagemPF: ${contagemPF},
tamanhoPf: ${tamanhoPf},
prazoTotal: ${prazoTotal},
regiaoDoImpossivel: ${regiaoDoImpossivel},
tipoSistemaSelecionado: ${tipoSistemaSelecionado}
    ''';
  }
}
