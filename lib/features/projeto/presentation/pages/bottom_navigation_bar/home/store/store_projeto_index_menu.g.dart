// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_projeto_index_menu.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreProjetosIndexMenu on StoreProjetosIndexMenuBase, Store {
  late final _$descricaoProjetoControllerAtom = Atom(
      name: 'StoreProjetosIndexMenuBase.descricaoProjetoController',
      context: context);

  @override
  TextEditingController get descricaoProjetoController {
    _$descricaoProjetoControllerAtom.reportRead();
    return super.descricaoProjetoController;
  }

  @override
  set descricaoProjetoController(TextEditingController value) {
    _$descricaoProjetoControllerAtom
        .reportWrite(value, super.descricaoProjetoController, () {
      super.descricaoProjetoController = value;
    });
  }

  late final _$descricaoProjetoAtom = Atom(
      name: 'StoreProjetosIndexMenuBase.descricaoProjeto', context: context);

  @override
  String get descricaoProjeto {
    _$descricaoProjetoAtom.reportRead();
    return super.descricaoProjeto;
  }

  @override
  set descricaoProjeto(String value) {
    _$descricaoProjetoAtom.reportWrite(value, super.descricaoProjeto, () {
      super.descricaoProjeto = value;
    });
  }

  late final _$linkDownloadAtom =
      Atom(name: 'StoreProjetosIndexMenuBase.linkDownload', context: context);

  @override
  String get linkDownload {
    _$linkDownloadAtom.reportRead();
    return super.linkDownload;
  }

  @override
  set linkDownload(String value) {
    _$linkDownloadAtom.reportWrite(value, super.linkDownload, () {
      super.linkDownload = value;
    });
  }

  late final _$carregouAtom =
      Atom(name: 'StoreProjetosIndexMenuBase.carregou', context: context);

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

  late final _$indexAtom =
      Atom(name: 'StoreProjetosIndexMenuBase.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$houveMudancaEmResultadoAtom = Atom(
      name: 'StoreProjetosIndexMenuBase.houveMudancaEmResultado',
      context: context);

  @override
  bool get houveMudancaEmResultado {
    _$houveMudancaEmResultadoAtom.reportRead();
    return super.houveMudancaEmResultado;
  }

  @override
  set houveMudancaEmResultado(bool value) {
    _$houveMudancaEmResultadoAtom
        .reportWrite(value, super.houveMudancaEmResultado, () {
      super.houveMudancaEmResultado = value;
    });
  }

  late final _$houveMudancaEmArquivosEdocumentosAtom = Atom(
      name: 'StoreProjetosIndexMenuBase.houveMudancaEmArquivosEdocumentos',
      context: context);

  @override
  bool get houveMudancaEmArquivosEdocumentos {
    _$houveMudancaEmArquivosEdocumentosAtom.reportRead();
    return super.houveMudancaEmArquivosEdocumentos;
  }

  @override
  set houveMudancaEmArquivosEdocumentos(bool value) {
    _$houveMudancaEmArquivosEdocumentosAtom
        .reportWrite(value, super.houveMudancaEmArquivosEdocumentos, () {
      super.houveMudancaEmArquivosEdocumentos = value;
    });
  }

  @override
  String toString() {
    return '''
descricaoProjetoController: ${descricaoProjetoController},
descricaoProjeto: ${descricaoProjeto},
linkDownload: ${linkDownload},
carregou: ${carregou},
index: ${index},
houveMudancaEmResultado: ${houveMudancaEmResultado},
houveMudancaEmArquivosEdocumentos: ${houveMudancaEmArquivosEdocumentos}
    ''';
  }
}
