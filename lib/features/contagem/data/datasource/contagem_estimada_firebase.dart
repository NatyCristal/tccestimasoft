import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/contagem/data/datasource/interfaces/contagem_estimada.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_estimada_firebase_model.dart';
import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

class ContagemEstimadaFirebase extends ContagemEstimadaDatasource {
  final firestore = FirebaseFirestore.instance;
  @override
  Future<ContagemEstimadaEntitie> recuperarContagemEstimada(
      String uidProjeto, String uidUsuario) async {
    ContagemEstimadaFirebaseModel contagem = ContagemEstimadaFirebaseModel(
        aie: [],
        ali: [],
        totalPF: 0,
        ce: [],
        ee: [],
        se: [],
        compartilhada: false);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Estimada")
        .doc(uidUsuario)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valores = value.data();

        if (valores!.isNotEmpty) {
          contagem = ContagemEstimadaFirebaseModel.fromMap(valores);
        }
      }
    });

    return contagem;
  }

  @override
  Future<ContagemEstimadaEntitie> salvarContagem(
      List<IndiceDescricaoContagenModel> aie,
      List<IndiceDescricaoContagenModel> ali,
      List<IndiceDescricaoContagenModel> ce,
      List<IndiceDescricaoContagenModel> ee,
      List<IndiceDescricaoContagenModel> se,
      String uidProjeto,
      String uidUsuario,
      int totalPF) async {
    ContagemEstimadaFirebaseModel contagem = ContagemEstimadaFirebaseModel(
        aie: aie,
        ali: ali,
        compartilhada: false,
        ce: ce,
        ee: ee,
        se: se,
        totalPF: totalPF);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Estimada")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection("Estimada")
            .doc(uidUsuario)
            .update(contagem.toMap());
      } else {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection("Estimada")
            .doc(uidUsuario)
            .set(contagem.toMap());
      }
    });

    return contagem;
  }

  @override
  Future<List<ContagemEstimadaEntitie>> recuperarEstimadasCompartilhadas(
      String uidProjeto) async {
    List<ContagemEstimadaEntitie> contagensIndicativas = [];

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Estimada")
        .get()
        .then((value) async {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          String id = element.id;
          if (element["Compartilhada"] == true) {
            ContagemEstimadaFirebaseModel custo =
                ContagemEstimadaFirebaseModel.fromMap(element.data());
            custo.uidUsuario = id;
            contagensIndicativas.add(custo);
          }
        }
      }
    });

    return contagensIndicativas;
  }
}
