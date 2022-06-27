import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/contagem/data/datasource/interfaces/contagem_indicativa.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_indicativa_firebase_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';

class ContagemIndicativaFirebase extends ContagemIndicativaDatasource {
  final firestore = FirebaseFirestore.instance;
  @override
  Future<ContagemIndicativaEntitie> salvar(List<String> alis, List<String> aies,
      String uidProjeto, String iudUsuario, int totalPf) async {
    ContagemIndicativaModelFirebase contagem = ContagemIndicativaModelFirebase(
        aie: aies, ali: alis, totalPf: totalPf, compartilhada: false);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Indicativa")
        .doc(iudUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection("Indicativa")
            .doc(iudUsuario)
            .update(contagem.toMap());
      } else {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection("Indicativa")
            .doc(iudUsuario)
            .set(contagem.toMap());
      }
    });

    return contagem;
  }

  @override
  Future<ContagemIndicativaEntitie> recuperarContagem(
      String uidProjeto, String uidUsuario) async {
    ContagemIndicativaModelFirebase contagem = ContagemIndicativaModelFirebase(
        totalPf: 0, aie: [], ali: [], compartilhada: false);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Indicativa")
        .doc(uidUsuario)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valores = value.data();

        if (valores!.isNotEmpty) {
          contagem = ContagemIndicativaModelFirebase.fromMap(valores);
        }
      }
    });

    return contagem;
  }

  @override
  Future<List<ContagemIndicativaEntitie>> recuperarIndicativasCompartilhadas(
      String uidProjeto) async {
    List<ContagemIndicativaEntitie> contagensEstimadas = [];

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Indicativa")
        .get()
        .then((value) async {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          String id = element.id;
          if (element["Compartilhada"] == true) {
            ContagemIndicativaModelFirebase contagem =
                ContagemIndicativaModelFirebase.fromMap(element.data());
            contagem.uidUsuario = id;
            contagensEstimadas.add(contagem);
          }
        }
      }
    });

    return contagensEstimadas;
  }
}
