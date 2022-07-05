import 'dart:io';

import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/data/datasource/projeto_datasource.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/domain/repository/projeto_repository.dart';
import 'package:estimasoft/features/projeto/error/projeto_erro.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProjetoFirebaseInfra extends ProjetoRepository {
  final ProjetoDatasource datasource;

  ProjetoFirebaseInfra(this.datasource);

  @override
  Future<Either<Falha, ProjetoEntitie>> criarProjeto(
      String uidUsuario, String nomeProjeto, String nomeAdministrador) async {
    try {
      var resultado = await datasource.criarProjeto(
          uidUsuario, nomeProjeto, nomeAdministrador);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(throw Exception(e.code));
    }
  }

  @override
  Future<Either<Falha, ProjetoEntitie>> entrarEmProjeto(
      String uidUsuario, String uidProjeto) async {
    try {
      var resultado = await datasource.entrarEmProjeto(uidUsuario, uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(throw Exception(e.code));
    } on Exception catch (e) {
      return Left(throw Exception(e));
    }
  }

  @override
  Future removerProjeto(String uidUsuario, String uidProjeto) async {
    // TODO: implement sairProjeto
    throw UnimplementedError();
  }

  @override
  Future<Either<Falha, List<ProjetoEntitie>>> rrecuperarProjetos(
      String uid) async {
    try {
      var resultado = await datasource.recuperarProjetos(uid);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(ErroProjeto(
          mensagem: "Aconteceu um erro aqui em recuperar Projetos" + e.code));
    }
  }

  @override
  Future sairProjeto(String uidUsuario, String uidProjeto) async {
    try {
      await datasource.sairProjeto(uidUsuario, uidProjeto);
    } on FirebaseException catch (e) {
      return Left(throw Exception(e.code));
    } on Exception catch (e) {
      return Left(throw Exception(e));
    }
  }

  @override
  Future<Either<Falha, List<UsuarioEntitie>>> recuperarMembros(
      String uidProjeto) async {
    try {
      var resultado = await datasource.recuperarMembrosProjeto(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(ErroProjeto(
          mensagem: "Aconteceu um erro aqui em recuperar membros" + e.code));
    }
  }

  @override
  Either<Falha, UploadTask> uparArquivos(String uidProjeto, File file) {
    try {
      var resultado = datasource.uparArquivo(uidProjeto, file);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(ErroProjeto(
          mensagem: "Aconteceu um erro aqui em recuperar membros" + e.code));
    }
  }

  @override
  Future<Either<Falha, ListResult>> recuperarArquivos(String uidProjeto) async {
    try {
      var resultado = await datasource.recuperarArquivos(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(ErroProjeto(
          mensagem: "Aconteceu um erro em recuperar os arquivos" + e.code));
    }
  }

  @override
  Future removerArquivo(String uidProjeto, String nomeArquivo) async {
    try {
      await datasource.excluirArquivo(uidProjeto, nomeArquivo);
    } on FirebaseException catch (e) {
      return Left(throw Exception(e.code));
    } on Exception catch (e) {
      return Left(throw Exception(e));
    }
  }

  @override
  Future realizarLoginArquivo(String uidProjeto, String nomeArquivo) async {
    try {
      await datasource.realizarDownloadArquivo(uidProjeto, nomeArquivo);
    } on FirebaseException catch (e) {
      return Left(throw Exception(e.code));
    } on Exception catch (e) {
      return Left(throw Exception(e));
    }
  }
}
