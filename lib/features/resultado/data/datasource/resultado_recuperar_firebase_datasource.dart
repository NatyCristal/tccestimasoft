import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/resultado/data/datasource/interfaces/resultado_recuperar_datasource.dart';
import 'package:estimasoft/features/resultado/data/model/resultado_model.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

class ResultadoRecuperarFirebaseDatasource
    extends ResultadoRecuperarDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<ResultadoEntity>> recuperarContagensDetalhadas(
      String uidProjeto) async {
    List<ResultadoEntity> resultadosContagens = [];
    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Detalhada")
        .get()
        .then((value) {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map = value.docs;

      if (map.isNotEmpty) {
        for (var element in map) {
          resultadosContagens.add(
              ResultadoModel.fromMap(element.data(), element.id, "Detalhada"));
        }
      }
    });
    return resultadosContagens;
  }
}
