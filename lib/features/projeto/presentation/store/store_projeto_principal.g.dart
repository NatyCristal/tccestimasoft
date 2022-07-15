// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_projeto_principal.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StoreProjetos on StoreProjetosBase, Store {
  late final _$exibirNotificacaoAtom =
      Atom(name: 'StoreProjetosBase.exibirNotificacao', context: context);

  @override
  bool get exibirNotificacao {
    _$exibirNotificacaoAtom.reportRead();
    return super.exibirNotificacao;
  }

  @override
  set exibirNotificacao(bool value) {
    _$exibirNotificacaoAtom.reportWrite(value, super.exibirNotificacao, () {
      super.exibirNotificacao = value;
    });
  }

  late final _$carregandoSairProjetosAtom =
      Atom(name: 'StoreProjetosBase.carregandoSairProjetos', context: context);

  @override
  bool get carregandoSairProjetos {
    _$carregandoSairProjetosAtom.reportRead();
    return super.carregandoSairProjetos;
  }

  @override
  set carregandoSairProjetos(bool value) {
    _$carregandoSairProjetosAtom
        .reportWrite(value, super.carregandoSairProjetos, () {
      super.carregandoSairProjetos = value;
    });
  }

  late final _$carregandoEntrarProjetosAtom = Atom(
      name: 'StoreProjetosBase.carregandoEntrarProjetos', context: context);

  @override
  bool get carregandoEntrarProjetos {
    _$carregandoEntrarProjetosAtom.reportRead();
    return super.carregandoEntrarProjetos;
  }

  @override
  set carregandoEntrarProjetos(bool value) {
    _$carregandoEntrarProjetosAtom
        .reportWrite(value, super.carregandoEntrarProjetos, () {
      super.carregandoEntrarProjetos = value;
    });
  }

  late final _$carregandoCriarPRojetosAtom =
      Atom(name: 'StoreProjetosBase.carregandoCriarPRojetos', context: context);

  @override
  bool get carregandoCriarPRojetos {
    _$carregandoCriarPRojetosAtom.reportRead();
    return super.carregandoCriarPRojetos;
  }

  @override
  set carregandoCriarPRojetos(bool value) {
    _$carregandoCriarPRojetosAtom
        .reportWrite(value, super.carregandoCriarPRojetos, () {
      super.carregandoCriarPRojetos = value;
    });
  }

  late final _$temPesquisaAtom =
      Atom(name: 'StoreProjetosBase.temPesquisa', context: context);

  @override
  bool get temPesquisa {
    _$temPesquisaAtom.reportRead();
    return super.temPesquisa;
  }

  @override
  set temPesquisa(bool value) {
    _$temPesquisaAtom.reportWrite(value, super.temPesquisa, () {
      super.temPesquisa = value;
    });
  }

  late final _$valorPesquisaAtom =
      Atom(name: 'StoreProjetosBase.valorPesquisa', context: context);

  @override
  String get valorPesquisa {
    _$valorPesquisaAtom.reportRead();
    return super.valorPesquisa;
  }

  @override
  set valorPesquisa(String value) {
    _$valorPesquisaAtom.reportWrite(value, super.valorPesquisa, () {
      super.valorPesquisa = value;
    });
  }

  late final _$projetosAtom =
      Atom(name: 'StoreProjetosBase.projetos', context: context);

  @override
  ObservableList<ProjetoEntitie> get projetos {
    _$projetosAtom.reportRead();
    return super.projetos;
  }

  @override
  set projetos(ObservableList<ProjetoEntitie> value) {
    _$projetosAtom.reportWrite(value, super.projetos, () {
      super.projetos = value;
    });
  }

  late final _$projetosPesquisaAtom =
      Atom(name: 'StoreProjetosBase.projetosPesquisa', context: context);

  @override
  List<ProjetoEntitie> get projetosPesquisa {
    _$projetosPesquisaAtom.reportRead();
    return super.projetosPesquisa;
  }

  @override
  set projetosPesquisa(List<ProjetoEntitie> value) {
    _$projetosPesquisaAtom.reportWrite(value, super.projetosPesquisa, () {
      super.projetosPesquisa = value;
    });
  }

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
  dynamic validarCodProjeto() {
    final _$actionInfo = _$StoreProjetosBaseActionController.startAction(
        name: 'StoreProjetosBase.validarCodProjeto');
    try {
      return super.validarCodProjeto();
    } finally {
      _$StoreProjetosBaseActionController.endAction(_$actionInfo);
    }
  }

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
exibirNotificacao: ${exibirNotificacao},
carregandoSairProjetos: ${carregandoSairProjetos},
carregandoEntrarProjetos: ${carregandoEntrarProjetos},
carregandoCriarPRojetos: ${carregandoCriarPRojetos},
temPesquisa: ${temPesquisa},
valorPesquisa: ${valorPesquisa},
projetos: ${projetos},
projetosPesquisa: ${projetosPesquisa},
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
