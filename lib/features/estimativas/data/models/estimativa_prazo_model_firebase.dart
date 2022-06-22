import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';

class EstimativaPrazoModel extends PrazoEntity {
  EstimativaPrazoModel(
      {required bool compartilhada,
      required String contagemPontoDeFuncao,
      required String tipoSistema,
      required double prazoTotal,
      required String prazoMinimo})
      : super(
            compartilhada: compartilhada,
            contagemPontoDeFuncao: contagemPontoDeFuncao,
            tipoSistema: tipoSistema,
            prazoTotal: prazoTotal,
            prazoMinimo: prazoMinimo);

  Map<String, dynamic> toMap() {
    return {
      "Compartilhada": compartilhada,
      "ContagemPontoDeFuncao": contagemPontoDeFuncao,
      'TipoSistema': tipoSistema,
      'PrazoTotal': prazoTotal,
      'PrazoMinimo': prazoMinimo,
    };
  }

  factory EstimativaPrazoModel.fromMap(Map<String, dynamic> map) {
    return EstimativaPrazoModel(
        compartilhada: map["Compartilhada"] ?? false,
        contagemPontoDeFuncao: map["ContagemPontoDeFuncao"],
        tipoSistema: map["TipoSistema"],
        prazoTotal: map["PrazoTotal"],
        prazoMinimo: map["PrazoMinimo"]);
  }
}
