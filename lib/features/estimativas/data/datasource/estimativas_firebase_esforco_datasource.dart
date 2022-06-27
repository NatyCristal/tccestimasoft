import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/estimativas/data/datasource/interfaces/estimativa_esforco_datasource.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_esforco_model_firebases.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';

class EstimativaFirebaseEsforcoDatasource extends EstimativaEsforcoDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<EsforcoEntity> salvarEstimativaEsforco(EsforcoEntity esforcoEntity,
      String uidProjeto, String uidUsuario, String tipoContagem) async {
    EstimativaEsforcoModel esforco = EstimativaEsforcoModel(
        compartilhada: esforcoEntity.compartilhada,
        contagemPontoDeFuncao: esforcoEntity.contagemPontoDeFuncao,
        linguagem: esforcoEntity.linguagem,
        produtividadeEquipe: esforcoEntity.produtividadeEquipe,
        esforcoTotal: esforcoEntity.esforcoTotal);

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Esforco")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Estimativa")
            .doc(uidProjeto)
            .collection("Esforco")
            .doc(uidUsuario)
            .update({tipoContagem: esforco.toMap()});
      } else {
        await firestore
            .collection("Estimativa")
            .doc(uidProjeto)
            .collection("Esforco")
            .doc(uidUsuario)
            .set({tipoContagem: esforco.toMap()});
      }
    });

    return esforco;
  }

  @override
  Future<List<EsforcoEntity>> recuperarEstimativaEsforco(
      String uidProjeto, String uidUsuario) async {
    List<EsforcoEntity> esforcos = [];

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Esforco")
        .doc(uidUsuario)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valores = value.data();
        valores!.forEach((key, value) {
          esforcos.add(EstimativaEsforcoModel.fromMap(value));
        });
      }
    });

    return esforcos;
  }

  @override
  Future<List<EsforcoEntity>> recuperarEsforcosCompartilhados(
      String uidProjeto, String tipoContagem) async {
    List<EsforcoEntity> esforcos = [];

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Esforco")
        .get()
        .then((value) async {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          String id = element.id;

          element.data().forEach((key, value) {
            if (value["Compartilhada"] == true) {
              EstimativaEsforcoModel esforco =
                  EstimativaEsforcoModel.fromMap(value);
              esforco.uidUsuario = id;
              esforcos.add(esforco);
            }
          });
        }
      }
    });
    return esforcos;
  }
}
