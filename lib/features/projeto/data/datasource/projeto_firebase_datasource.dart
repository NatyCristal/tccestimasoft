import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:estimasoft/features/login/data/models/login_usuario_firebase_model.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/data/datasource/projeto_datasource.dart';
import 'package:estimasoft/features/projeto/data/model/projeto_firebase_model.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/usuario/data/datasource/usuario_datasource.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ProjetoFirebaseDatasource extends ProjetoDatasource {
  final firestore = FirebaseFirestore.instance;
  final PerfilDatasource usuarioDatasource;

  ProjetoFirebaseDatasource(this.usuarioDatasource);
  @override
  Future<ProjetoEntitie> criarProjeto(
      String uidUsuario, String nomeProjeto, String nomeAdminstrador) async {
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
        nomeAdminstrador: nomeAdminstrador,
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
    List<UsuarioEntitie> membros = [];
    List<String> listaMembros = [];

    ProjetoFirebaseModel novoProjeto = ProjetoFirebaseModel(
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

  @override
  uparArquivo(String uidProjeto, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(uidProjeto);

      return ref.putFile(file);
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
  Future realizarDownloadArquivo(
      String uidProjeto, String caminhoDocumento) async {
    final ref = FirebaseStorage.instance.ref(caminhoDocumento);

    // ignore: unused_local_variable
    var resultado =
        FirebaseStorage.instance.ref(caminhoDocumento); //.getDownloadURL();

    final dir = await getApplicationDocumentsDirectory();
    //print("Diretorio: " + dir.path);
    File file = File("${dir.path}/${caminhoDocumento.split("/").last}");

//TODO: FINALIZAR DOWNLOAD ARQUIVOS
    //  print(file);

    await ref.writeToFile(file);
    // print(ref.name);

    final url = await ref.getDownloadURL();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';

    // ignore: unused_local_variable
    Response response = await Dio().download(url, path);

    //
    //
    //await file.writeAsBytes(response.);
    //await ref.writeToFile(file);

    if (url.contains(".jpg")) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    //print("Baixou");

    // //First you get the documents folder location on the device...
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // //Here you'll specify the file it should be saved as
    // File downloadToFile = File('${appDocDir.path}/Downloads.jpg');
    // //Here you'll specify the file it should download from Cloud Storage
    // String fileToDownload = 'uploads/uploaded-pdf.pdf';

    // //Now you can try to download the specified file, and write it to the downloadToFile.
    // try {
    //   await FirebaseStorage.instance
    //       .ref(caminhoDocumento)
    //       .writeToFile(downloadToFile);
    // } on FirebaseException catch (e) {
    //   // e.g, e.code == 'canceled'
    //   print('Download error: $e');
    // }

    // final qualquercoisa = FirebaseStorage.instance.ref("arquivos/$uidProjeto");
    // final islandRef = qualquercoisa.child(caminhoDocumento.split("/").last);
    // final appDocDir = await getApplicationDocumentsDirectory();
    // //String teste = appDocDir.absolute.toString();
    // print(appDocDir);
    // final filePath = "${appDocDir.path}//teste.jpg";

    // final file = File(filePath);
    // print(filePath);

    // final downloadTask = islandRef.writeToFile(file);
    // downloadTask.snapshotEvents.listen((taskSnapshot) {
    //   switch (taskSnapshot.state) {
    //     case TaskState.running:
    //       print("Deu running");
    //       break;
    //     case TaskState.paused:
    //       print("Deu paused");
    //       break;
    //     case TaskState.success:
    //       print("Deu certo");
    //       break;
    //     case TaskState.canceled:
    //       print("Deu cancelado");
    //       break;
    //     case TaskState.error:
    //       print("Deu erro");
    //       break;
    //   }
    // });
  }
}



// Future<Directory> getApplicationDocumentsDirectory() async {
//   final String? path = await _platform.getApplicationDocumentsPath();
//   if (path == null) {
//     throw MissingPlatformDirectoryException(
//         'Unable to get application documents directory');
//   }
//   return Directory(path);
// }