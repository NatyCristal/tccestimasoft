import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/contagem/data/datasource/interfaces/contagem_detalhada.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_detalhada_firebase_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';

class ContagemDetalhadaFirebase extends ContagemDetalhadaDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<ContagemDetalhadaEntitie> recuperarContagemDetalhada(
      String uidProjeto, String uidUsuario) async {
    ContagemDetalhadaModel contagem = ContagemDetalhadaModel(
        compartilhada: false,
        funcaoDados: [],
        funcaoTransacional: [],
        totalFuncaoDados: 0,
        totalFuncaoTransacional: 0,
        totalPf: 0);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection(uidUsuario)
        .doc("Detalhada")
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valor = value.data();
        if (valor!.isNotEmpty) {
          contagem = ContagemDetalhadaModel.fromMap(valor);
        }
      }
    });

    return contagem;
  }

  @override
  Future<ContagemDetalhadaEntitie> salvarContageDetalhada(
      ContagemDetalhadaEntitie contagemDetalhadaEntitie,
      String uidProjeto,
      String uidUsuario) async {
    ContagemDetalhadaModel contagemDetalhada = ContagemDetalhadaModel(
        compartilhada: false,
        funcaoDados: contagemDetalhadaEntitie.funcaoDados,
        funcaoTransacional: contagemDetalhadaEntitie.funcaoTransacional,
        totalPf: contagemDetalhadaEntitie.totalPf,
        totalFuncaoDados: contagemDetalhadaEntitie.totalFuncaoDados,
        totalFuncaoTransacional:
            contagemDetalhadaEntitie.totalFuncaoTransacional);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection(uidUsuario)
        .doc("Detalhada")
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection(uidUsuario)
            .doc("Detalhada")
            .update(contagemDetalhada.toMap());
      } else if (!value.exists) {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection(uidUsuario)
            .doc("Estimada")
            .set(contagemDetalhada.toMap());
      }
    });

    return contagemDetalhada;
  }
}
