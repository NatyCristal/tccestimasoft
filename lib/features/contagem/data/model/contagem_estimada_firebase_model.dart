import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

class ContagemEstimadaFirebaseModel extends ContagemEstimadaEntitie {
  ContagemEstimadaFirebaseModel(
      {required bool compartilhada,
      required List<IndiceDescricaoContagenModel> aie,
      required List<IndiceDescricaoContagenModel> ali,
      required List<IndiceDescricaoContagenModel> ce,
      required List<IndiceDescricaoContagenModel> ee,
      required List<IndiceDescricaoContagenModel> se,
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
      "AIE": {for (var e in aie) aie.indexOf(e).toString(): e.toMap()},
      "ALI": {for (var e in ali) ali.indexOf(e).toString(): e.toMap()},
      "Compartilhada": compartilhada,
      "total": totalPF,
      'EE': {for (var e in ee) ee.indexOf(e).toString(): e.toMap()},
      'CE': {for (var e in ce) ce.indexOf(e).toString(): e.toMap()},
      'SE': {for (var e in se) se.indexOf(e).toString(): e.toMap()},
    };
  }

  factory ContagemEstimadaFirebaseModel.fromMap(Map<String, dynamic> map) {
    List<IndiceDescricaoContagenModel> listaEE = [];
    List<IndiceDescricaoContagenModel> listaCE = [];
    List<IndiceDescricaoContagenModel> listaSE = [];
    List<IndiceDescricaoContagenModel> listaAli = [];
    List<IndiceDescricaoContagenModel> listaAie = [];

    Map<String, dynamic>? lista = map["EE"];
    lista!.forEach((key, value) {
      listaEE.add(IndiceDescricaoContagenModel.fromMap(value));
    });
    Map<String, dynamic>? lista2 = map["CE"];
    lista2!.forEach((key, value) {
      listaCE.add(IndiceDescricaoContagenModel.fromMap(value));
    });

    Map<String, dynamic>? lista3 = map["SE"];
    lista3!.forEach((key, value) {
      listaSE.add(IndiceDescricaoContagenModel.fromMap(value));
    });
    Map<String, dynamic>? lista4 = map["ALI"];
    lista4!.forEach((key, value) {
      listaAli.add(IndiceDescricaoContagenModel.fromMap(value));
    });

    Map<String, dynamic>? lista5 = map["AIE"];
    lista5!.forEach((key, value) {
      listaAie.add(IndiceDescricaoContagenModel.fromMap(value));
    });

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
