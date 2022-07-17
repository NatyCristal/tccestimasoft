import 'package:estimasoft/features/estimativas/data/models/insumo_estimativa_custo.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';

class CustoModel extends CustoEntity {
  CustoModel(
      {required double valorPorcentagem,
      required double despesasTotaisDurantePrazoProjeto,
      required double custoBasico,
      required bool compartilhada,
      required String tipoContagem,
      required List<InsumoEstimativaCustoModel> equipe,
      required List<InsumoEstimativaCustoModel> custosVariaisFixos,
      required String custoTotalMensal,
      required String porcentagemLucro,
      required double custoTotalProjeto,
      required double valorTotalProjeto,
      required String custoPF})
      : super(
            valorPorcentagem: valorPorcentagem,
            despesasTotaisDurantePrazoProjeto:
                despesasTotaisDurantePrazoProjeto,
            custoBasico: custoBasico,
            compartilhada: compartilhada,
            tipoContagem: tipoContagem,
            equipe: equipe,
            custosVariaisFixos: custosVariaisFixos,
            custoTotalMensal: custoTotalMensal,
            porcentagemLucro: porcentagemLucro,
            custoTotalProjeto: custoTotalProjeto,
            valorTotalProjeto: valorTotalProjeto,
            custoPF: custoPF);

  Map<String, dynamic> toMap() {
    return {
      "ValorPorcentagem": valorPorcentagem.toStringAsFixed(2),
      "DespesasTotaisDurantePrazoProjeto":
          despesasTotaisDurantePrazoProjeto.toStringAsFixed(2),
      "CustoBasico": custoBasico.toStringAsFixed(2),
      "Compartilhada": compartilhada,
      "Equipe": {for (var e in equipe) equipe.indexOf(e).toString(): e.toMap()},
      'CustosVariaveisEFixos': {
        for (var e in custosVariaisFixos)
          custosVariaisFixos.indexOf(e).toString(): e.toMap()
      },
      'TipoContagem': tipoContagem,
      'CustoTotalMensal': custoTotalMensal,
      'PorcentagemLucro': porcentagemLucro,
      'CustoTotalDoProjeto': custoTotalProjeto.toStringAsFixed(2),
      'ValorTotalProjeto': valorTotalProjeto.toStringAsFixed(2),
      'CustoPF': custoPF
    };
  }

  factory CustoModel.fromMap(Map<String, dynamic> map) {
    List<InsumoEstimativaCustoModel> equipe = [];
    List<InsumoEstimativaCustoModel> custos = [];
    Map<String, dynamic> equipeFirebase = map["Equipe"];
    if (equipeFirebase.isNotEmpty) {
      equipeFirebase.forEach((key, value) {
        equipe.add(InsumoEstimativaCustoModel.fromMap(value));
      });
    }

    Map<String, dynamic> custosFirebase = map["CustosVariaveisEFixos"];
    if (custosFirebase.isNotEmpty) {
      custosFirebase.forEach((key, value) {
        custos.add(InsumoEstimativaCustoModel.fromMap(value));
      });
    }

    return CustoModel(
      valorPorcentagem: double.parse(map['ValorPorcentagem'] ?? "0.0"),
      despesasTotaisDurantePrazoProjeto:
          double.parse((map['DespesasTotaisDurantePrazoProjeto'] ?? 0.0)),
      custoBasico: double.parse(map["CustoBasico"] ?? 0.0),
      compartilhada: map["Compartilhada"] ?? false,
      tipoContagem: map["TipoContagem"],
      equipe: equipe,
      custosVariaisFixos: custos,
      custoTotalMensal: map["CustoTotalMensal"],
      porcentagemLucro: map["PorcentagemLucro"],
      custoTotalProjeto: double.parse(map["CustoTotalDoProjeto"]),
      valorTotalProjeto: double.parse(map["ValorTotalProjeto"]),
      custoPF: map['CustoPF'],
    );
  }
}
