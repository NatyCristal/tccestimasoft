import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/login/data/models/login_usuario_firebase_model.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/data/datasource/projeto_datasource.dart';
import 'package:estimasoft/features/projeto/data/model/projeto_firebase_model.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/usuario/data/datasource/usuario_datasource.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class ProjetoFirebaseDatasource extends ProjetoDatasource {
  final firestore = FirebaseFirestore.instance;
  final PerfilDatasource usuarioDatasource;

  ProjetoFirebaseDatasource(this.usuarioDatasource);
  @override
  Future<ProjetoEntitie> criarProjeto(
      String uidUsuario, String nomeProjeto, String nomeAdministrador) async {
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
        descricao: "",
        nomeAdminstrador: nomeAdministrador,
        uidProjeto: uidProjeto,
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
  Future<ProjetoEntitie> entrarEmProjeto(
      String uidUsuario, String uidProjeto) async {
    List<UsuarioEntity> membros = [];
    List<String> listaMembros = [];

    ProjetoFirebaseModel novoProjeto = ProjetoFirebaseModel(
        descricao: "",
        nomeAdminstrador: "",
        uidProjeto: "",
        admin: "",
        dataCriacao: "",
        nomeProjeto: "",
        membros: membros);
    try {
      await firestore
          .collection("Projetos")
          .doc(uidProjeto)
          .get()
          .then((value) async {
        if (value.exists) {
          Map<String, dynamic>? valor = value.data();
          if (valor != null) {
            List<dynamic> lista = valor["membros"];

            for (var element in lista) {
              if (element != uidUsuario) {
                listaMembros.add(element);
              }
            }

            novoProjeto = (ProjetoFirebaseModel.fromMap(valor, uidProjeto));
            await usuarioDatasource.vincularProjetoUsuario(
                uidProjeto, uidUsuario);
          }
        }
      });

      listaMembros.add(uidUsuario);
      Map<String, List<String>> mapFinal;
      mapFinal = {"membros": listaMembros};
      await firestore.collection("Projetos").doc(uidProjeto).update(mapFinal);

      return novoProjeto;
    } catch (e) {
      throw Exception("Projeto não encontrado");
    }
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
  Future sairProjeto(String uidUsuario, String uidProjeto) async {
    await firestore
        .collection('Projetos')
        .doc(uidProjeto)
        .get()
        .then((value) async {
      if (value.exists) {
        List<String> membros = [];

        List<dynamic> teste = value['membros'];

        for (var element in teste) {
          if (element != uidUsuario) {
            membros.add(element);
          }
        }

        if (membros.isNotEmpty && value["admin"] != uidUsuario) {
          Map<String, List<String>> mapFinal;
          mapFinal = {"membros": membros};

          await firestore
              .collection("Projetos")
              .doc(uidProjeto)
              .update(mapFinal)
              .then((value) async {
            await usuarioDatasource.removerProjetoUsuario(
                uidUsuario, uidProjeto);
            await excluirDadosUsuario(uidProjeto, uidUsuario);
          });
        } else if (membros.isNotEmpty && value["admin"] == uidUsuario) {
          String nomeNovoAdmin = "";
          await firestore
              .collection("Usuarios")
              .doc(membros[0].toString())
              .get()
              .then((value) {
            nomeNovoAdmin = value["nome"];
          });

          Map<String, String> mapFinal = {
            "admin": membros[0].toString(),
            "nomeAdministrador": nomeNovoAdmin
          };

          await firestore
              .collection("Projetos")
              .doc(uidProjeto)
              .update(mapFinal);

          Map<String, List<String>> mapFinal2;
          mapFinal2 = {"membros": membros};

          await firestore
              .collection("Projetos")
              .doc(uidProjeto)
              .update(mapFinal2);

          await usuarioDatasource.removerProjetoUsuario(uidUsuario, uidProjeto);
          await excluirDadosUsuario(uidProjeto, uidUsuario);
        } else {
          await usuarioDatasource
              .removerProjetoUsuario(uidUsuario, uidProjeto)
              .then((value) async {
            // await firestore.collection("Projetos").doc(uidProjeto).delete();
            await usuarioDatasource.removerProjetoUsuario(
                uidUsuario, uidProjeto);
            await excluirDadosUsuario(uidProjeto, uidUsuario);
            final arquivos =
                await FirebaseStorage.instance.ref(uidProjeto).listAll();

            if (arquivos.items.isNotEmpty) {
              await FirebaseStorage.instance.ref(uidProjeto).delete();
            }
          });
        }
      }
    });
  }

  @override
  Future<List<UsuarioEntity>> recuperarMembrosProjeto(String uidProjeto) async {
    List<String> uidMembrosProjeto = [];
    List<UsuarioEntity> membros = [];

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

  @override
  Future uparArquivo(String uidProjeto, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(uidProjeto);

      return await ref.putFile(file);
    } on FirebaseException catch (e) {
      return throw Exception(e);
    }
  }

  @override
  Future<ListResult> recuperarArquivos(String uidProjeto) async {
    ListResult arquivos;
    arquivos =
        await FirebaseStorage.instance.ref("arquivos/$uidProjeto").listAll();

    return arquivos;
  }

  @override
  Future excluirArquivo(String uidProjeto, String nomeArquivo) async {
    await FirebaseStorage.instance.ref(nomeArquivo).delete();
  }

  @override
  Future<String> adicionarDescricaoProjeto(
      String uidProjeto, String descricao) async {
    Map<String, String> map = {"descricao": descricao};

    await firestore.collection("Projetos").doc(uidProjeto).update(map);
    return "Descrição salva com sucesso!";
  }

  Future excluirDadosUsuario(String uidProjeto, String uidUsuario) async {
    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Indicativa")
        .doc(uidUsuario)
        .delete();

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Estimada")
        .doc(uidUsuario)
        .delete();

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Detalhada")
        .doc(uidUsuario)
        .delete();

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Custo")
        .doc(uidUsuario)
        .delete();

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Equipe")
        .doc(uidUsuario)
        .delete();

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Prazo")
        .doc(uidUsuario)
        .delete();

    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Esforco")
        .doc(uidUsuario)
        .delete();

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Detalhada")
        .doc(uidUsuario)
        .delete();
  }
}
