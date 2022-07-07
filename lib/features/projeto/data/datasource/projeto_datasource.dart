import 'dart:io';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/data/model/projeto_firebase_model.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ProjetoDatasource {
  Future<List<ProjetoFirebaseModel>> recuperarProjetos(String uid);

  Future<ProjetoEntitie> criarProjeto(
      String uidUsuario, String nomeProjeto, String nomeAdministrador);

  Future removerProjeto(String uidUsuario, String uidProjeto);

  Future sairProjeto(String uidUsuario, String uidProjeto);

  Future<ProjetoEntitie> entrarEmProjeto(
    String uidUsuario,
    String uidProjeto,
  );

  Future<List<UsuarioEntitie>> recuperarMembrosProjeto(String uidProjeto);

  Future uparArquivo(String uidProjeto, File file);

  Future<ListResult> recuperarArquivos(String uidProjeto);

  Future excluirArquivo(String uidProjeto, String nomeArquivo);

  Future realizarDownloadArquivo(String uidProjeto, String caminhoDocumento);

  Future<String> adicionarDescricaoProjeto(String uidProjeto, String descricao);
}
