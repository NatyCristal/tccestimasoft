import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

class ContagemEstimadaFirebaseModel extends ContagemEstimadaEntitie {
  ContagemEstimadaFirebaseModel(
      {required bool compartilhada,
      required List<String> aie,
      required List<String> ali,
      required List<String> ce,
      required List<String> ee,
      required List<String> se,
      required int totalPF})
      : super(
            aie: aie,
            ali: ali,
            ce: ce,
            ee: ee,
            se: se,
            totalPF: totalPF,
            compartilhada: compartilhada);

  Map<String, dynamic> toMap() {
    return {
      "AIE": aie,
      "ALI": ali,
      "Compartilhada": compartilhada,
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
    List<String> listaAli = [];
    List<String> listaAie = [];

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

    List<dynamic>? lista4 = map["ALI"];
    for (var element in lista4!) {
      listaAli.add(element);
    }

    List<dynamic>? lista5 = map["AIE"];
    for (var element in lista5!) {
      listaAie.add(element);
    }

    return ContagemEstimadaFirebaseModel(
        compartilhada: map["Compartilhada"] ?? false,
        ali: listaAli,
        aie: listaAie,
        ce: listaCE,
        ee: listaEE,
        se: listaSE,
        totalPF: map["total"]);
  }
}
