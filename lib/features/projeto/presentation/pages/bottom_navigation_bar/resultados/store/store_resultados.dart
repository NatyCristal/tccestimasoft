import 'package:mobx/mobx.dart';
part 'store_resultados.g.dart';

class StoreResultados = StoreResultadosBase with _$StoreResultados;

abstract class StoreResultadosBase with Store {
  @observable
  bool carregando = false;

  @observable
  bool estimada = false;

  @observable
  bool indicativa = true;

  @observable
  bool detalhada = false;

  @observable
  bool compartilhada = false;

  @observable
  bool anonimo = false;
}
