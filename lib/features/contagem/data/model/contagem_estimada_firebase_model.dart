import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

class ContagemEstimadaFirebaseModel extends ContagemEstimadaEntitie {
  ContagemEstimadaFirebaseModel(
      {required List<String> ce,
      required List<String> ee,
      required List<String> se,
      required int totalPF})
      : super(ce: ce, ee: ee, se: se, totalPF: totalPF);

  Map<String, dynamic> toMap() {
    return {
      "total": totalPF,
      'EE': ee,
      'CE': ce,
      'SE': se,
    };
  }

  factory ContagemEstimadaFirebaseModel.fromMap(Map<String, dynamic> map) {
    List<String> listaEE = [];
    List<String> listaCE = [];
    List<String> listaSE = [];

    List<dynamic>? lista = map["EE"];

    for (var element in lista!) {
      listaEE.add(element);
    }

    List<dynamic>? lista2 = map["CE"];
    for (var element in lista2!) {
      listaCE.add(element);
    }

    List<dynamic>? lista3 = map["SE"];
    for (var element in lista3!) {
      listaSE.add(element);
    }

    return ContagemEstimadaFirebaseModel(
        ce: listaCE, ee: listaEE, se: listaSE, totalPF: map["total"]);
  }
}
