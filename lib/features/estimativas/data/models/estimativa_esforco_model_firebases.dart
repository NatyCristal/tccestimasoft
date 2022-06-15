import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';

class EstimativaEsforcoModel extends EsforcoEntity {
  EstimativaEsforcoModel(
      {required String contagemPontoDeFuncao,
      required String linguagem,
      required String produtividadeEquipe,
      required String esforcoTotal})
      : super(
            contagemPontoDeFuncao: contagemPontoDeFuncao,
            linguagem: linguagem,
            produtividadeEquipe: produtividadeEquipe,
            esforcoTotal: esforcoTotal);

  Map<String, dynamic> toMap() {
    return {
      "ContagemPontoDeFuncao": contagemPontoDeFuncao,
      'Linguagem': linguagem,
      'ProdutividadeEquipe': produtividadeEquipe,
      'EsforcoTotal': esforcoTotal,
    };
  }

  factory EstimativaEsforcoModel.fromMap(Map<String, dynamic> map) {
    return EstimativaEsforcoModel(
        contagemPontoDeFuncao: map["ContagemPontoDeFuncao"],
        esforcoTotal: map["EsforcoTotal"],
        linguagem: map["Linguagem"],
        produtividadeEquipe: map["ProdutividadeEquipe"]);
  }
}
