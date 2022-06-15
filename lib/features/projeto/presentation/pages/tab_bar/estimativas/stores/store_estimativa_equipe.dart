import 'package:mobx/mobx.dart';

part 'store_estimativa_equipe.g.dart';

class StoreEstimativaEquipe = StoreEstimativaEquipeBase
    with _$StoreEstimativaEquipe;

abstract class StoreEstimativaEquipeBase with Store {
  @observable
  double equipeEstimada = 0;

  List<String> menuItem = [
    '1 hora',
    '2 horas',
    '3 horas',
    '4 horas',
    '5 horas',
    '6 horas',
    '7 horas',
    '8 horas',
    '9 horas',
    '10 horas'
  ];
}
