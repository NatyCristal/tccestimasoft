import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';

class CustoModel extends CustoEntity {
  CustoModel(
      {required Map<String, String> equipe,
      required Map<String, String> custosVariaisFixos,
      required String disponibilidadeEquipe,
      required String custoTotalMensal,
      required double custoHora,
      required String porcentagemLucro,
      required double custoTotalProjeto,
      required double valorTotalProjeto,
      required String custoPF})
      : super(
            equipe: equipe,
            custosVariaisFixos: custosVariaisFixos,
            disponibilidadeEquipe: disponibilidadeEquipe,
            custoTotalMensal: custoTotalMensal,
            custoHora: custoHora,
            porcentagemLucro: porcentagemLucro,
            custoTotalProjeto: custoTotalProjeto,
            valorTotalProjeto: valorTotalProjeto,
            custoPF: custoPF);

  Map<String, dynamic> toMap() {
    return {
      "Equipe": equipe,
      'CustosVariaveisEFixos': custosVariaisFixos,
      'DisponibilidadeEquipe': disponibilidadeEquipe,
      'CustoTotalMensal': custoTotalMensal,
      'CustoHora': custoHora,
      'PorcentagemLucro': porcentagemLucro,
      'CustoTotalDoProjeto': custoTotalProjeto,
      'ValorTotalProjeto': valorTotalProjeto,
      'CustoPF': custoPF
    };
  }

  factory CustoModel.fromMap(Map<String, dynamic> map) {
    return CustoModel(
      equipe: map["Equipe"],
      custosVariaisFixos: map["CustosVariaveisEFixos"],
      disponibilidadeEquipe: map["DisponibilidadeEquipe"],
      custoTotalMensal: map["CustoTotalMensal"],
      custoHora: map["CustoHora"],
      porcentagemLucro: map["PorcentagemLucro"],
      custoTotalProjeto: map["CustoTotalDoProjeto"],
      valorTotalProjeto: map["valorTotalProjeto"],
      custoPF: map['CustoPF'],
    );
  }
}
