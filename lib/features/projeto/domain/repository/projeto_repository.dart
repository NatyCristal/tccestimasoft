import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../entitie/projeto_entitie.dart';

abstract class ProjetoRepository {
  Future<Either<Falha, List<ProjetoEntitie>>> rrecuperarProjetos(String uid);

  Future<Either<Falha, ProjetoEntitie>> criarProjeto(
      String uidUsuario, String nomeProjeto, String nomeAdministrador);

  Future removerProjeto(String uidUsuario, String uidProjeto);

  Future sairProjeto(String uidUsuario, String uidProjeto);

  Future<Either<Falha, ProjetoEntitie>> entrarEmProjeto(
    String uidUsuario,
    String uidProjeto,
  );

  Future<Either<Falha, List<UsuarioEntity>>> recuperarMembros(
    String uidProjeto,
  );
  Future<Either<Falha, TaskSnapshot?>> uparArquivos(
      String uidProjeto, File file);

  Future<Either<Falha, ListResult>> recuperarArquivos(String uidProjeto);

  Future removerArquivo(String uidProjeto, String nomeArquivo);

  Future realizarLoginArquivo(String uidProjeto, String nomeArquivo);

  Future<Either<Falha, String>> adicionarDescricaoProjeto(
      String uidProjeto, String descricao);
}
