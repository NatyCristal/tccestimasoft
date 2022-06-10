import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/data/datasource/projeto_datasource.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/domain/repository/projeto_repository.dart';
import 'package:estimasoft/features/projeto/error/projeto_erro.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjetoFirebaseInfra extends ProjetoRepository {
  final ProjetoDatasource datasource;

  ProjetoFirebaseInfra(this.datasource);

  @override
  Future<Either<Falha, ProjetoEntitie>> criarProjeto(
      String uidUsuario, String nomeProjeto) async {
    try {
      var resultado = await datasource.criarProjeto(uidUsuario, nomeProjeto);
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
  Future<Either<Falha, String>> removerProjeto(
      String uidUsuario, String uidProjeto) {
    // TODO: implement removerProjeto
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
  Future<Either<Falha, String>> sairProjeto(
      String uidUsuario, String uidProjeto) {
    // TODO: implement sairProjeto
    throw UnimplementedError();
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
}
