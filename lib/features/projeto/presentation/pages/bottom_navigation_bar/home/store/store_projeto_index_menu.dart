import 'package:mobx/mobx.dart';
part 'store_projeto_index_menu.g.dart';

class StoreProjetosIndexMenu = StoreProjetosIndexMenuBase
    with _$StoreProjetosIndexMenu;

abstract class StoreProjetosIndexMenuBase with Store {
  @observable
  String linkDownload = "";

  @observable
  bool carregou = false;

  @observable
  int index = 0;

  @observable
  bool houveMudancaEmResultado = false;

  @observable
  bool houveMudancaEmArquivosEdocumentos = false;
}
