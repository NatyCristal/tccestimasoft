import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';

class EstimativaPrazoModel extends PrazoEntity {
  EstimativaPrazoModel(
      {required String contagemPontoDeFuncao,
      required String tipoSistema,
      required double prazoTotal,
      required String prazoMinimo})
      : super(
            contagemPontoDeFuncao: contagemPontoDeFuncao,
            tipoSistema: tipoSistema,
            prazoTotal: prazoTotal,
            prazoMinimo: prazoMinimo);

  Map<String, dynamic> toMap() {
    return {
      "ContagemPontoDeFuncao": contagemPontoDeFuncao,
      'TipoSistema': tipoSistema,
      'PrazoTotal': prazoTotal,
      'PrazoMinimo': prazoMinimo,
    };
  }

  factory EstimativaPrazoModel.fromMap(Map<String, dynamic> map) {
    return EstimativaPrazoModel(
        contagemPontoDeFuncao: map["ContagemPontoDeFuncao"],
        tipoSistema: map["TipoSistema"],
        prazoTotal: map["PrazoTotal"],
        prazoMinimo: map["PrazoMinimo"]);
  }
}
