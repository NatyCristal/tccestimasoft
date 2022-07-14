import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/resultado/data/model/resultado_model.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

import 'interfaces/resultado_compartilhar_datasource.dart';

class ResultadoFirebaseDatasource extends CompartilharResultadoDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<ResultadoEntity> enviarContagemDetalhada(bool anonimamente,
      String texto, String uidProjeto, String uidUsuario) async {
    ResultadoModel contagemDetalhada = ResultadoModel(
        anonimo: anonimamente,
        nome: "Detalhada",
        uidMembro: uidUsuario,
        valor: texto);

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Detalhada")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Detalhada")
            .doc(uidUsuario)
            .update(contagemDetalhada.toMap());
      } else {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Detalhada")
            .doc(uidUsuario)
            .set(contagemDetalhada.toMap());
      }
    });

    return contagemDetalhada;
  }
}
