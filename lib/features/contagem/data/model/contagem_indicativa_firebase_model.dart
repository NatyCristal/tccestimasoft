import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';

class ContagemIndicativaModelFirebase extends ContagemIndicativaEntitie {
  ContagemIndicativaModelFirebase(
      {required bool compartilhada,
      required int totalPf,
      required List<IndiceDescricaoContagenModel> aie,
      required List<IndiceDescricaoContagenModel> ali})
      : super(
          compartilhada: compartilhada,
          totalPf: totalPf,
          aie: aie,
          ali: ali,
        );

  Map<String, dynamic> toMap() {
    return {
      "Compartilhada": compartilhada,
      "total": totalPf,
      'AIE': {for (var e in aie) aie.indexOf(e).toString(): e.toMap()},
      'ALI': {for (var e in ali) ali.indexOf(e).toString(): e.toMap()},
    };
  }

  factory ContagemIndicativaModelFirebase.fromMap(
    Map<String, dynamic> map,
  ) {
    List<IndiceDescricaoContagenModel> listaAIE = [];
    List<IndiceDescricaoContagenModel> listaALI = [];

    Map<String, dynamic>? lista = map["AIE"];
    lista!.forEach((key, value) {
      listaAIE.add(IndiceDescricaoContagenModel.fromMap(value));
    });

    Map<String, dynamic>? lista2 = map["ALI"];

    lista2!.forEach((key, value) {
      listaALI.add(IndiceDescricaoContagenModel.fromMap(value));
    });

    return ContagemIndicativaModelFirebase(
        compartilhada: map["Compartilhada"] ?? false,
        aie: listaAIE,
        ali: listaALI,
        totalPf: map["total"]);
  }
}
