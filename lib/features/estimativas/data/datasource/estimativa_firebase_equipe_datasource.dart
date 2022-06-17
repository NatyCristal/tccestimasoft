import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/estimativas/data/datasource/interfaces/estimativa_equipe_datasource.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_equipe_model_firebase.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';

class EstimativaEquipeFirebaseDatasource extends EstimativaEquipeDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<EquipeEntity>> recuperarEstimativaEquipe(
      String uidProjeto, String uidUsuario) async {
    List<EquipeEntity> equipes = [];

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Equipe")
        .doc(uidUsuario)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valores = value.data();
        valores!.forEach((key, value) {
          equipes.add(EstimativaEquipeModel.fromMap(value));
        });
      }
    });

    return equipes;
  }

  @override
  Future<EquipeEntity> salvarEstimativaEquipe(EquipeEntity equipeEntity,
      String uidProjeto, String uidUsuario, String tipoContagem) async {
    EstimativaEquipeModel prazo = EstimativaEquipeModel(
      equipeEstimada: equipeEntity.equipeEstimada,
      esforco: equipeEntity.esforco,
      prazo: equipeEntity.prazo,
      producaoDiaria: equipeEntity.producaoDiaria,
    );

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Equipe")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Estimativa")
            .doc(uidProjeto)
            .collection("Equipe")
            .doc(uidUsuario)
            .update({tipoContagem: prazo.toMap()});
      } else {
        await firestore
            .collection("Estimativa")
            .doc(uidProjeto)
            .collection("Equipe")
            .doc(uidUsuario)
            .set({tipoContagem: prazo.toMap()});
      }
    });

    return prazo;
  }
}
