import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_custo_model_firebase.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';

import 'interfaces/estimativa_custo_datasource.dart';

class EstimativaCustoFirebaseDatasource extends CustoDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<CustoEntity>> recuperarEstimativaCusto(
      String uidProjeto, String uidUsuario) async {
    List<CustoEntity> custos = [];

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Custo")
        .doc(uidUsuario)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valores = value.data();
        valores!.forEach((key, value) {
          custos.add(CustoModel.fromMap(value));
        });
      }
    });

    return custos;
  }

  @override
  Future<CustoEntity> salvarEstimativaCusto(CustoEntity custoEntity,
      String uidProjeto, String uidUsuario, String tipoContagem) async {
    CustoModel custo = CustoModel(
      compartilhada: false,
      tipoContagem: tipoContagem,
      custoHora: custoEntity.custoHora,
      custoPF: custoEntity.custoPF,
      custoTotalMensal: custoEntity.custoTotalMensal,
      custoTotalProjeto: custoEntity.custoTotalProjeto,
      custosVariaisFixos: custoEntity.custosVariaisFixos,
      disponibilidadeEquipe: custoEntity.disponibilidadeEquipe,
      equipe: custoEntity.equipe,
      porcentagemLucro: custoEntity.porcentagemLucro,
      valorTotalProjeto: custoEntity.valorTotalProjeto,
    );

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Custo")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Estimativa")
            .doc(uidProjeto)
            .collection("Custo")
            .doc(uidUsuario)
            .update({tipoContagem.split(" - ").first: custo.toMap()});
      } else {
        await firestore
            .collection("Estimativa")
            .doc(uidProjeto)
            .collection("Custo")
            .doc(uidUsuario)
            .set({tipoContagem.split(" - ").first: custo.toMap()});
      }
    });

    return custo;
  }

  @override
  Future<List<CustoEntity>> recuperaCustosCompartilhados(
      String uidProjeto, String tipoContagem) async {
    List<CustoEntity> custos = [];

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Custo")
        .get()
        .then((value) async {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          String id = element.id;

          element.data().forEach((key, value) {
            if (value["Compartilhada"] == true) {
              CustoModel custo = CustoModel.fromMap(value);
              custo.uidUsuario = id;
              custos.add(custo);
            }
          });
        }
      }
    });
    return custos;
  }
}
