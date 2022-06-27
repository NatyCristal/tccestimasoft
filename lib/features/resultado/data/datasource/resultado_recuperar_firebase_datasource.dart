import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/resultado/data/datasource/interfaces/resultado_recuperar_datasource.dart';
import 'package:estimasoft/features/resultado/data/model/resultado_model.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

class ResultadoRecuperarFirebaseDatasource
    extends ResultadoRecuperarDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<ResultadoEntity>> recuperarEstimativasEsforco(
      String uidProjeto) async {
    List<ResultadoEntity> resultadosEsforcos = [];
    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Esforcos")
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          element.data().forEach((key, value) {
            resultadosEsforcos
                .add(ResultadoModel.fromMap(value, element.id, key.toString()));
          });
        }
      }
    });
    return resultadosEsforcos;
  }

  @override
  Future<List<ResultadoEntity>> recuperarEstimativasCustos(
      String uidProjeto) async {
    List<ResultadoEntity> resultadosEsforcos = [];
    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Custos")
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          element.data().forEach((key, value) {
            resultadosEsforcos
                .add(ResultadoModel.fromMap(value, element.id, key.toString()));
          });
        }
      }
    });
    return resultadosEsforcos;
  }

  @override
  Future<List<ResultadoEntity>> recuperarEstimativasEquipe(
      String uidProjeto) async {
    List<ResultadoEntity> resultadosEsforcos = [];
    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Equipes")
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          element.data().forEach((key, value) {
            resultadosEsforcos
                .add(ResultadoModel.fromMap(value, element.id, key.toString()));
          });
        }
      }
    });
    return resultadosEsforcos;
  }

  @override
  Future<List<ResultadoEntity>> recuperarEstimativasPrazo(
      String uidProjeto) async {
    List<ResultadoEntity> resultadosEsforcos = [];
    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Prazos")
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          element.data().forEach((key, value) {
            resultadosEsforcos
                .add(ResultadoModel.fromMap(value, element.id, key.toString()));
          });
        }
      }
    });
    return resultadosEsforcos;
  }

  @override
  Future<List<ResultadoEntity>> recuperarContagens(String uidProjeto) async {
    List<ResultadoEntity> resultadosContagens = [];
    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Contagem")
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          element.data().forEach((key, value) {
            resultadosContagens
                .add(ResultadoModel.fromMap(value, element.id, key.toString()));
          });
        }
      }
    });
    return resultadosContagens;
  }
}
