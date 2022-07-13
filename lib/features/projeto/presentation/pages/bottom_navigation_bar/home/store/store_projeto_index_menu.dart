import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'store_projeto_index_menu.g.dart';

class StoreProjetosIndexMenu = StoreProjetosIndexMenuBase
    with _$StoreProjetosIndexMenu;

abstract class StoreProjetosIndexMenuBase with Store {
  @observable
  TextEditingController descricaoProjetoController = TextEditingController();

  @observable
  String descricaoProjeto = "";

  @observable
  String linkDownload = "";

  @observable
  bool carregou = false;

  @observable
  int index = 0;

  @observable
  bool houveMudancaEmResultado = false;

  @observable
  String nomeArquivo = "";

  @observable
  bool houveMudancaEmArquivosEdocumentos = false;

  @observable
  String erroNomeArquivos = "";

  @action
  validarNomeArquivo() {
    if (nomeArquivo.length < 3) {
      erroNomeArquivos = "Nome pequeno";
      return false;
    }
    if (nomeArquivo.isEmpty) {
      erroNomeArquivos = "Código não pode ficar vazio";
      return false;
    }

    erroNomeArquivos = "";
    return true;
  }
}
