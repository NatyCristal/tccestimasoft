import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/login/data/models/login_usuario_firebase_model.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/data/datasource/projeto_datasource.dart';
import 'package:estimasoft/features/projeto/data/model/projeto_firebase_model.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/usuario/data/datasource/usuario_datasource.dart';
import 'package:intl/intl.dart';

class ProjetoFirebaseDatasource extends ProjetoDatasource {
  final firestore = FirebaseFirestore.instance;
  final PerfilDatasource usuarioDatasource;

  ProjetoFirebaseDatasource(this.usuarioDatasource);
  @override
  Future<ProjetoEntitie> criarProjeto(
      String uidUsuario, String nomeProjeto) async {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);

    String dateTime = formattedDate.toString();
    List<String> membros = [];

    membros.add(uidUsuario);

    String uidProjeto =
        await firestore.collection("Projetos").doc().get().then((value) {
      return value.id;
    });

    List<LoginUsuarioFirebaseModel> usuario = [];
    usuario.add(LoginUsuarioFirebaseModel(
        email: "", nome: "", uid: uidUsuario, urlFoto: ""));

    ProjetoFirebaseModel novoProjeto = ProjetoFirebaseModel(
        uidProjeto: "",
        admin: uidUsuario,
        dataCriacao: dateTime.toString(),
        nomeProjeto: nomeProjeto,
        membros: usuario);

    await firestore
        .collection("Projetos")
        .doc(uidProjeto)
        .set(novoProjeto.toMap());
    await usuarioDatasource.vincularProjetoUsuario(uidProjeto, uidUsuario);

    return novoProjeto;
  }

  @override
  Future entrarEmProjeto(String uidProjeto) {
    // TODO: implement entrarEmProjeto
    throw UnimplementedError();
  }

  @override
  Future<List<ProjetoFirebaseModel>> recuperarProjetos(String uid) async {
    List<ProjetoFirebaseModel> projetos = [];
    List<String> listaProjetosIds =
        await usuarioDatasource.recuperarListaDeProjetos(uid);

    for (var projetoUids in listaProjetosIds) {
      await firestore
          .collection("Projetos")
          .doc(projetoUids)
          .get()
          .then((value) async {
        if (value.exists) {
          Map<String, dynamic>? valor = value.data();
          if (valor != null) {
            projetos.add(ProjetoFirebaseModel.fromMap(valor, projetoUids));
          }
        }
      });
    }
    return projetos;
  }

  @override
  Future removerProjeto(String uidUsuario, String uidProjeto) {
    // TODO: implement removerProjeto
    throw UnimplementedError();
  }

  @override
  Future sairProjeto(String uidUsuario, String uidProjeto) {
    // TODO: implement sairProjeto
    throw UnimplementedError();
  }

  @override
  Future<List<UsuarioEntitie>> recuperarMembrosProjeto(
      String uidProjeto) async {
    List<String> uidMembrosProjeto = [];
    List<UsuarioEntitie> membros = [];

    await firestore
        .collection("Projetos")
        .doc(uidProjeto)
        .get()
        .then((value) async {
      if (value.exists) {
        Map<String, dynamic>? dados = value.data();
        if (dados?["membros"] != null) {
          List<dynamic> lista = dados?["membros"];
          for (var element in lista) {
            uidMembrosProjeto.add(element.toString());
          }
        }
      }
    });

    membros = await usuarioDatasource.recuperarMembros(uidMembrosProjeto);
    return membros;
  }
}
