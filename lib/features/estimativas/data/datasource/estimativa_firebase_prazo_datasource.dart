import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/estimativas/data/datasource/interfaces/estimativa_prazo_datasource.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_prazo_model_firebase.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';

class EstimativaFirebasePrazoDatasource extends EstimativaPrazo {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<PrazoEntity>> recuperarEstimativaPrazo(
      String uidProjeto, String uidUsuario) async {
    List<PrazoEntity> prazos = [];

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Prazo")
        .doc(uidUsuario)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valores = value.data();
        valores!.forEach((key, value) {
          prazos.add(EstimativaPrazoModel.fromMap(value));
        });
      }
    });

    return prazos;
  }

  @override
  Future<PrazoEntity> salvarEstimativaPrazo(PrazoEntity prazo,
      String uidProjeto, String uidUsuario, String tipoContagem) async {
    EstimativaPrazoModel prazoModel = EstimativaPrazoModel(
        compartilhada: false,
        contagemPontoDeFuncao: prazo.contagemPontoDeFuncao,
        tipoSistema: prazo.tipoSistema,
        prazoMinimo: prazo.prazoMinimo,
        prazoTotal: prazo.prazoTotal);

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Prazo")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Estimativa")
            .doc(uidProjeto)
            .collection("Prazo")
            .doc(uidUsuario)
            .update({tipoContagem: prazoModel.toMap()});
      } else {
        await firestore
            .collection("Estimativa")
            .doc(uidProjeto)
            .collection("Prazo")
            .doc(uidUsuario)
            .set({tipoContagem: prazoModel.toMap()});
      }
    });

    return prazoModel;
  }
}
