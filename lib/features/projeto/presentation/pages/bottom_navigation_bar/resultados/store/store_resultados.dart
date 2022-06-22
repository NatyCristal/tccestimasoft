import 'package:mobx/mobx.dart';
part 'store_resultados.g.dart';

class StoreResultados = StoreResultadosBase with _$StoreResultados;

abstract class StoreResultadosBase with Store {
  @observable
  bool compartilhada = false;

  @observable
  bool anonimo = false;
}
