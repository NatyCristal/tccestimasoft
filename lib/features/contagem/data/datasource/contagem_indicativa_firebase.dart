import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/contagem/data/datasource/interfaces/contagem_indicativa.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_indicativa_firebase_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';

class ContagemIndicativaFirebase extends ContagemIndicativaDatasource {
  final firestore = FirebaseFirestore.instance;
  @override
  Future<ContagemIndicativaEntitie> salvar(List<String> alis, List<String> aies,
      String uidProjeto, String iudUsuario, int totalPf) async {
    ContagemIndicativaModelFirebase contagem =
        ContagemIndicativaModelFirebase(aie: aies, ali: alis, totalPf: totalPf);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection(iudUsuario)
        .doc("Indicativa")
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection(iudUsuario)
            .doc("Indicativa")
            .update(contagem.toMap());
      } else if (!value.exists) {
        await firestore
            .collection("Contagem")
            .doc(uidProjeto)
            .collection(iudUsuario)
            .doc("Indicativa")
            .set(contagem.toMap());
      }
    });

    return contagem;
  }

  // recuperarFuncoesAli(String uidProjeto, String uidUsuario) async {
  //   List<String> alis = [];

  //   await firestore
  //       .collection("Contagem")
  //       .doc(uidProjeto)
  //       .collection(uidUsuario)
  //       .doc("Indicativa")
  //       .get()
  //       .then((value) async {
  //     if (value.exists) {
  //       Map<String, dynamic>? dados = value.data();
  //       if (dados?["ALI"] != null) {
  //         List<dynamic> lista = dados?["ALI"];
  //         for (var element in lista) {
  //           alis.add(element.toString());
  //         }
  //       }
  //     }
  //   });

  //   return alis;
  // }

  @override
  Future<ContagemIndicativaEntitie> recuperarContagem(
      String uidProjeto, String uidUsuario) async {
    ContagemIndicativaModelFirebase contagem =
        ContagemIndicativaModelFirebase(totalPf: 0, aie: [], ali: []);

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection(uidUsuario)
        .doc("Indicativa")
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? valor = value.data();
        if (valor!.isNotEmpty) {
          contagem = ContagemIndicativaModelFirebase.fromMap(valor);
        }
      }
    });

    return contagem;
  }

  // recuperarFuncoes(String tipoDaFuncao, uidProjeto, iudUsuario) async {
  //   if (tipoDaFuncao == "ALI") {
  //     return await recuperarFuncoesAli(uidProjeto, iudUsuario);
  //   } else if (tipoDaFuncao == "AIE") {
  //     return await recuperarFuncoesAie(uidProjeto, iudUsuario);
  //   }
  // }

  // recuperarFuncoesAie(
  //   String uidProjeto,
  //   String uidUsuario,
  // ) async {
  //   List<String> aies = [];

  //   await firestore
  //       .collection("Contagem")
  //       .doc(uidProjeto)
  //       .collection(uidUsuario)
  //       .doc("Indicativa")
  //       .get()
  //       .then((value) async {
  //     if (value.exists) {
  //       Map<String, dynamic>? dados = value.data();
  //       if (dados?["AIE"] != null) {
  //         List<dynamic> lista = dados?["AIE"];
  //         for (var element in lista) {
  //           aies.add(element.toString());
  //         }
  //       }
  //     }
  //   });

  //   return aies;
  // }

}
