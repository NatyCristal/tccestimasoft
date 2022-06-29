import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/resultado/data/datasource/interfaces/resultado_recuperar_datasource.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:estimasoft/features/resultado/domain/repository/resultado_recuperar_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ResultadoInfraRecuperarFirebase extends ResultadoRecuperarRepository {
  final ResultadoRecuperarDatasource datasource;

  ResultadoInfraRecuperarFirebase(this.datasource);

  @override
  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasCustos(
      String uidProjeto) async {
    try {
      var resultado = await datasource.recuperarEstimativasCustos(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasEquipe(
    String uidProjeto,
  ) async {
    try {
      var resultado = await datasource.recuperarEstimativasEquipe(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasEsforco(
    String uidProjeto,
  ) async {
    try {
      var resultado = await datasource.recuperarEstimativasEsforco(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasPrazo(
      String uidProjet) async {
    try {
      var resultado = await datasource.recuperarEstimativasPrazo(uidProjet);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, List<ResultadoEntity>>> recuperaContagensIndicativas(
      String uidProjeto) async {
    try {
      var resultado = await datasource.recuperarContagenIndicativas(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, List<ResultadoEntity>>> recuperarContagensDetalhada(
      String uidProjeto) async {
    try {
      var resultado = await datasource.recuperarContagensDetalhadas(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, List<ResultadoEntity>>> recuperarContagemEstimada(
      String uidProjeto) async {
    try {
      var resultado = await datasource.recuperarEstimadas(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
