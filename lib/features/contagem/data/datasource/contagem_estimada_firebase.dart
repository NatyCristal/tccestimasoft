import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/contagem/data/datasource/interfaces/contagem_estimada.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_estimada_firebase_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

class ContagemEstimadaFirebase extends ContagemEstimadaDatasource {
  final firestore = FirebaseFirestore.instance;
  @override
  Future<ContagemEstimadaEntitie> recuperarContagemEstimada(
      String uidProjeto, String uidUsuario) async {
    ContagemEstimadaFirebaseModel contagem =
        ContagemEstimadaFirebaseModel(totalPF: 0, ce: [], ee: [], se: []);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection(uidUsuario)
        .doc("Estimada")
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valor = value.data();
        if (valor!.isNotEmpty) {
          contagem = ContagemEstimadaFirebaseModel.fromMap(valor);
        }
      }
    });

    return contagem;
  }

  @override
  Future<ContagemEstimadaEntitie> salvarContagem(
      List<String> ce,
      List<String> ee,
      List<String> se,
      String uidProjeto,
      String uidUsuario,
      int totalPF) async {
    ContagemEstimadaFirebaseModel contagem =
        ContagemEstimadaFirebaseModel(ce: ce, ee: ee, se: se, totalPF: totalPF);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection(uidUsuario)
        .doc("Estimada")
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection(uidUsuario)
            .doc("Estimada")
            .update(contagem.toMap());
      } else if (!value.exists) {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection(uidUsuario)
            .doc("Estimada")
            .set(contagem.toMap());
      }
    });

    return contagem;
  }
}
