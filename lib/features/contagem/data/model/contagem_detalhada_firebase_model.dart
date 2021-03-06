import 'package:estimasoft/features/contagem/data/model/indice_detalhada_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';

class ContagemDetalhadaModel extends ContagemDetalhadaEntitie {
  ContagemDetalhadaModel({
    required bool compartilhada,
    required List<IndiceDetalhadaModel> funcaoDados,
    required List<IndiceDetalhadaModel> funcaoTransacional,
    required int totalPf,
    required int totalFuncaoDados,
    required int totalFuncaoTransacional,
  }) : super(
          compartilhada: compartilhada,
          funcaoDados: funcaoDados,
          funcaoTransacional: funcaoTransacional,
          totalFuncaoDados: totalFuncaoDados,
          totalFuncaoTransacional: totalFuncaoTransacional,
          totalPf: totalPf,
        );

  Map<String, dynamic> toMap() {
    return {
      "Compartilhada": compartilhada,
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
    List<IndiceDetalhadaModel> dadosTransacionais = [];
    List<IndiceDetalhadaModel> funcaoDados = [];

    Map<String, dynamic>? lista = map["FuncaoTransacional"];

    lista!.forEach((key, value) {
      dadosTransacionais.add(IndiceDetalhadaModel.fromMap(value));
    });

    Map<String, dynamic> lista2 = map["FuncaoDeDados"];
    lista2.forEach((key, value) {
      funcaoDados.add(IndiceDetalhadaModel.fromMap(value));
    });

    return ContagemDetalhadaModel(
        compartilhada: map["Compartilhada"] ?? false,
        totalFuncaoTransacional: map['TotalFuncaoDeDados'],
        totalPf: map["TotalPF"],
        totalFuncaoDados: map["TotalFuncaoDeDados"],
        funcaoDados: funcaoDados,
        funcaoTransacional: dadosTransacionais);
  }
}
