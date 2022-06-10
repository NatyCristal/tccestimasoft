import 'package:mobx/mobx.dart';
import '../../domain/entitie/projeto_entitie.dart';

part 'store_projeto_principal.g.dart';

class StoreProjetos = StoreProjetosBase with _$StoreProjetos;

abstract class StoreProjetosBase with Store {
  @observable
  String pesquisa = "";

  @observable
  List<ProjetoEntitie> projetos = [];

  @observable
  List<ProjetoEntitie> projetosPesquisa = [];

  @observable
  int tamanhoProjetos = 0;

  @observable
  bool carregou = false;

  @observable
  bool exibirDrawer = false;

  @observable
  String codEntrarProjeto = "";

  @observable
  String erroCodEntrarProjeto = "";

  validarCodProjeto() {
    if (codEntrarProjeto.length < 3) {
      erroCodEntrarProjeto = "Código pequeno";
      return false;
    }
    if (codEntrarProjeto.isEmpty) {
      erroCodEntrarProjeto = "Código não pode ficar vazio";
      return false;
    }

    erroCodEntrarProjeto = "";
    return true;
  }

  @observable
  String nomeProjeto = "";

  @observable
  String nomeProjetoErro = "";

  @action
  validarNomeProjeto() {
    if (nomeProjeto.length < 3) {
      nomeProjetoErro = "Nome pequeno";
      return false;
    }
    if (nomeProjeto.isEmpty) {
      nomeProjetoErro = "nome não pode ficar vazio";
      return false;
    }

    nomeProjetoErro = "";
    return true;
  }

  @action
  pesquisarProjetos() {
    for (var element in projetos) {
      if (element.nomeProjeto.contains(nomeProjeto)) {
        projetosPesquisa.add(element);
      }
    }
    return projetosPesquisa.length;
  }
}
