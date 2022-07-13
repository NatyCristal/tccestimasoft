import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/login/data/models/login_usuario_firebase_model.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'usuario_datasource.dart';

class UsuarioFirebaseDataSource extends PerfilDatasource {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Future alterarEmail(String email) async {
    await _auth.currentUser!.updateEmail(email).then((value) {
      _firestore.collection("Usuarios").doc(_auth.currentUser!.uid).update({
        'email': email,
      });
    });
    return "Usuário alterado com sucesso!";
  }

  @override
  alterarNome(String nome) async {
    await _auth.currentUser!.updateDisplayName(nome).then((value) => ({
          _firestore.collection("Usuarios").doc(_auth.currentUser!.uid).update({
            'nome': nome,
          })
        }));

    return "Nome alterado com sucesso!";
  }

  @override
  Future signOut() async {
    await _auth.signOut();
    return "Usuário deslogado do sistema";
  }

  @override
  Future vincularProjetoUsuario(String uidProjeto, String uidUsuario) async {
    List<String> listaProjetos = [];

    await _firestore
        .collection("Usuarios")
        .doc(uidUsuario)
        .get()
        .then((resultado) async {
      if (resultado.exists) {
        listaProjetos.add(uidProjeto);
        Map<String, List<String>> mapFinal;
        Map<String, dynamic>? dados = resultado.data();

        if (dados?["projetosUids"] != null) {
          List<dynamic> lista = dados?["projetosUids"];

          for (var element in lista) {
            if (element != uidProjeto) {
              listaProjetos.add(element.toString());
            }
          }

          mapFinal = {"projetosUids": listaProjetos};

          await _firestore
              .collection("Usuarios")
              .doc(uidUsuario)
              .update(mapFinal);
        } else {
          mapFinal = {"projetosUids": listaProjetos};
          await _firestore
              .collection("Usuarios")
              .doc(uidUsuario)
              .update(mapFinal);
        }
      }
    });
  }

  @override
  Future<List<String>> recuperarListaDeProjetos(String uidUsuario) async {
    List<String> listaProjetos = [];
    await _firestore
        .collection("Usuarios")
        .doc(uidUsuario)
        .get()
        .then((resultado) {
      if (resultado.exists) {
        Map<String, dynamic>? dados = resultado.data();

        if (dados?["projetosUids"] != null) {
          List<dynamic> lista = dados?["projetosUids"];
          for (var element in lista) {
            listaProjetos.add(element.toString());
          }
        }
      }
    });

    return listaProjetos;
  }

  @override
  Future<List<UsuarioEntity>> recuperarMembros(List<String> uidUsuarios) async {
    List<LoginUsuarioFirebaseModel> usuarios = [];

    for (var element in uidUsuarios) {
      await _firestore.collection("Usuarios").doc(element).get().then((value) {
        if (value.exists) {
          Map<String, dynamic>? dados = value.data();
          if (dados != null) {
            usuarios.add(LoginUsuarioFirebaseModel.fromMap(dados));
          }
        }
      });
    }

    return usuarios;
  }

  @override
  UsuarioEntity usuarioLogado() {
    User? currentUser = _auth.currentUser;
    UsuarioEntity usuario =
        LoginUsuarioFirebaseModel(nome: "", email: "", uid: "", urlFoto: "");

    if (currentUser != null) {
      usuario = LoginUsuarioFirebaseModel(
          nome: currentUser.displayName ?? "",
          email: currentUser.email ?? "",
          uid: currentUser.uid,
          urlFoto: currentUser.photoURL ?? "");
    }

    return usuario;
  }

  @override
  Future removerProjetoUsuario(String uidUsuario, String uidProjeto) async {
    List<String> listaProjetos = [];

    await _firestore
        .collection("Usuarios")
        .doc(uidUsuario)
        .get()
        .then((resultado) async {
      if (resultado.exists) {
        Map<String, List<String>> mapFinal;
        Map<String, dynamic>? dados = resultado.data();

        List<dynamic> lista = dados?["projetosUids"];

        for (var element in lista) {
          if (element != uidProjeto) {
            listaProjetos.add(element.toString());
          }
        }

        mapFinal = {"projetosUids": listaProjetos};

        await _firestore
            .collection("Usuarios")
            .doc(uidUsuario)
            .update(mapFinal);
      }
    });
  }
}
