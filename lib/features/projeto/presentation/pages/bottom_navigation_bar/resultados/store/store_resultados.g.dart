// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_resultados.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreResultados on StoreResultadosBase, Store {
  late final _$estimadaAtom =
      Atom(name: 'StoreResultadosBase.estimada', context: context);

  @override
  bool get estimada {
    _$estimadaAtom.reportRead();
    return super.estimada;
  }

  @override
  set estimada(bool value) {
    _$estimadaAtom.reportWrite(value, super.estimada, () {
      super.estimada = value;
    });
  }

  late final _$indicativaAtom =
      Atom(name: 'StoreResultadosBase.indicativa', context: context);

  @override
  bool get indicativa {
    _$indicativaAtom.reportRead();
    return super.indicativa;
  }

  @override
  set indicativa(bool value) {
    _$indicativaAtom.reportWrite(value, super.indicativa, () {
      super.indicativa = value;
    });
  }

  late final _$detalhadaAtom =
      Atom(name: 'StoreResultadosBase.detalhada', context: context);

  @override
  bool get detalhada {
    _$detalhadaAtom.reportRead();
    return super.detalhada;
  }

  @override
  set detalhada(bool value) {
    _$detalhadaAtom.reportWrite(value, super.detalhada, () {
      super.detalhada = value;
    });
  }

  late final _$compartilhadaAtom =
      Atom(name: 'StoreResultadosBase.compartilhada', context: context);

  @override
  bool get compartilhada {
    _$compartilhadaAtom.reportRead();
    return super.compartilhada;
  }

  @override
  set compartilhada(bool value) {
    _$compartilhadaAtom.reportWrite(value, super.compartilhada, () {
      super.compartilhada = value;
    });
  }

  late final _$anonimoAtom =
      Atom(name: 'StoreResultadosBase.anonimo', context: context);

  @override
  bool get anonimo {
    _$anonimoAtom.reportRead();
    return super.anonimo;
  }

  @override
  set anonimo(bool value) {
    _$anonimoAtom.reportWrite(value, super.anonimo, () {
      super.anonimo = value;
    });
  }

  @override
  String toString() {
    return '''
estimada: ${estimada},
indicativa: ${indicativa},
detalhada: ${detalhada},
compartilhada: ${compartilhada},
anonimo: ${anonimo}
    ''';
  }
}
