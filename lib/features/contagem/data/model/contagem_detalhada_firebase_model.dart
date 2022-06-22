import 'package:estimasoft/features/contagem/data/model/indice_detalhada_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';

class ContagemDetalhadaModel extends ContagemDetalhadaEntitie {
  ContagemDetalhadaModel({
    required List<IndiceDetalhadaModel> funcaoDados,
    required List<IndiceDetalhadaModel> funcaoTransacional,
    required int totalPf,
    required int totalFuncaoDados,
    required int totalFuncaoTransacional,
  }) : super(
          funcaoDados: funcaoDados,
          funcaoTransacional: funcaoTransacional,
          totalFuncaoDados: totalFuncaoDados,
          totalFuncaoTransacional: totalFuncaoTransacional,
          totalPf: totalPf,
        );

  Map<String, dynamic> toMap() {
    return {
      "TotalPF": totalPf,
      'TotalFuncaoDeDados': totalFuncaoDados,
      'FuncaoDeDados': {
        for (var e in funcaoDados) funcaoDados.indexOf(e).toString(): e.toMap()
      },
      'FuncaoTransacional': {
        for (var e in funcaoTransacional)
          funcaoTransacional.indexOf(e).toString(): e.toMap()
      },
    };
  }

  factory ContagemDetalhadaModel.fromMap(Map<String, dynamic> map) {
    return ContagemDetalhadaModel(
        totalFuncaoTransacional: map['TotalFuncaoDeDados'],
        totalPf: map["TotalPF"],
        totalFuncaoDados: map["TotalFuncaoDeDados"],
        funcaoDados: map["FuncaoDeDados"],
        funcaoTransacional: map["FuncaoTransacional"]);
  }
}
