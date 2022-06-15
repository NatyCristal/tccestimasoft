// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_contagem_detalhada.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreContagemDetalhada on StoreContagemDetalhadaBase, Store {
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

  @override
  String toString() {
    return '''
totalPf: ${totalPf}
    ''';
  }
}
