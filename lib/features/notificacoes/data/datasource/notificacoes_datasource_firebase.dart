import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/features/notificacoes/data/datasource/notificacoes_datasource.dart';
import 'package:estimasoft/features/notificacoes/data/model/notificacao_composicao_model.dart';
import 'package:estimasoft/features/notificacoes/data/model/notificacao_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class NotificacoesDatasourceFirebase extends NotificacoesDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<NotificacaoModel> buscarNoticaoes() async {
    String uidUsuario = Modular.get<UsuarioAutenticado>().store.uid;

    NotificacaoModel teste =
        NotificacaoModel(notificacoes: [], notificacaoLida: false);

    await firestore
        .collection("Notificacoes")
        .doc(uidUsuario)
        .get()
        .then((value) {
      if (value.exists) {
        DocumentSnapshot<Map<String, dynamic>> map = value;

        teste = NotificacaoModel.fromMap(map.data()!);
      }
    });

    return teste;
  }

  @override
  Future enviarNotivicacao(String textoNotificacao, String uidUsuario) async {
    NotificacaoModel teste = await buscarNoticaoes();
    if (teste.notificacoes.length >= 20) {
      teste.notificacoes.removeLast();
    }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm').format(now);
    String data = formattedDate.toString();
    teste.notificacoes.add(NotificacaoComposicaoModel(
        dataNotificacao: data, textoNotificacao: textoNotificacao));
    teste.notificacaoLida = false;

    await firestore
        .collection("Notificacoes")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Notificacoes")
            .doc(uidUsuario)
            .update(teste.toMap());
      } else {
        await firestore
            .collection("Notificacoes")
            .doc(uidUsuario)
            .set(teste.toMap());
      }
    });
    return teste;
  }

  @override
  Future lerNotificacao() async {
    String uidUsuario = Modular.get<UsuarioAutenticado>().store.uid;

    await firestore
        .collection("Notificacoes")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        final Map<String, dynamic> teste = {"exibirNotificacoes": true};

        await firestore
            .collection("Notificacoes")
            .doc(uidUsuario)
            .update(teste);
      }
    });
  }

  @override
  Future enviarNotificacaoParaMembros(
      String texto, String uidProjeto, List<String> uidUsuarios) async {
    for (var element in uidUsuarios) {
      await enviarNotivicacao(texto, element);
    }
  }
}
