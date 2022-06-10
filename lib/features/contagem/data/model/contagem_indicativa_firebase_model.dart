import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';

class ContagemIndicativaModelFirebase extends ContagemIndicativaEntitie {
  ContagemIndicativaModelFirebase(
      {required int totalPf,
      required List<String> aie,
      required List<String> ali})
      : super(totalPf: totalPf, aie: aie, ali: ali);

  Map<String, dynamic> toMap() {
    return {
      "total": totalPf,
      'AIE': aie,
      'ALI': ali,
    };
  }

  factory ContagemIndicativaModelFirebase.fromMap(
    Map<String, dynamic> map,
  ) {
    List<String> listaAIE = [];
    List<String> listaALI = [];

    List<dynamic>? lista = map["AIE"];

    for (var element in lista!) {
      listaAIE.add(element);
    }

    List<dynamic>? lista2 = map["ALI"];
    for (var element in lista2!) {
      listaALI.add(element);
    }

    return ContagemIndicativaModelFirebase(
        aie: listaAIE, ali: listaALI, totalPf: map["total"]);
  }
}
