import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';

class EstimativaEquipeModel extends EquipeEntity {
  EstimativaEquipeModel(
      {required String esforco,
      required String prazo,
      required String producaoDiaria,
      required String equipeEstimada})
      : super(
            esforco: esforco,
            prazo: prazo,
            producaoDiaria: producaoDiaria,
            equipeEstimada: equipeEstimada);

  Map<String, dynamic> toMap() {
    return {
      "Esforco": esforco,
      'Prazo': prazo,
      'ProducaoDiaria': producaoDiaria,
      'EquipeEstimada': equipeEstimada,
    };
  }

  factory EstimativaEquipeModel.fromMap(Map<String, dynamic> map) {
    return EstimativaEquipeModel(
        esforco: map["Esforco"],
        prazo: map["Prazo"],
        producaoDiaria: map["ProducaoDiaria"],
        equipeEstimada: map["EquipeEstimada"]);
  }
}
