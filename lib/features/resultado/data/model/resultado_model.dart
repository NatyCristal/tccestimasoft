import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

class ResultadoModel extends ResultadoEntity {
  ResultadoModel(
      {required bool anonimo,
      required String nome,
      required String valor,
      required String uidMembro})
      : super(anonimo, nome, valor, uidMembro);

  Map<String, dynamic> toMap() {
    return {
      "Anonimo": anonimo,
      'NomeEstimativa': nome,
      'Valor': valor,
    };
  }

  factory ResultadoModel.fromMap(
      Map<String, dynamic> map, String id, String tipoContagem) {
    return ResultadoModel(
        uidMembro: id,
        anonimo: map["Anonimamente"],
        nome: tipoContagem,
        valor: map["Valor"]);
  }
}