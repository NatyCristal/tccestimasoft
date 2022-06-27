import 'package:estimasoft/features/estimativas/data/datasource/interfaces/estimativa_esforco_datasource.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/estimativas/domain/repository/esforco_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EstimativaEsforcoFirebase extends EsforcoRepository {
  final EstimativaEsforcoDatasource datasource;

  EstimativaEsforcoFirebase(this.datasource);

  @override
  Future<Either<Falha, List<EsforcoEntity>>> recuperarEstimativaEsforco(
      String uidProjeto, String uidUsuario) async {
    try {
      var resultado =
          await datasource.recuperarEstimativaEsforco(uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, EsforcoEntity>> salvarEstimativaEsforco(
      EsforcoEntity esforcoEntity,
      String uidProjeto,
      String uidUsuario,
      String tipoContagem) async {
    try {
      EsforcoEntity usuario = await datasource.salvarEstimativaEsforco(
          esforcoEntity, uidProjeto, uidUsuario, tipoContagem);
      return Right(usuario);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, List<EsforcoEntity>>> recuperarEsforcosCompartilhados(
      String uidProjeto, String tipoContagem) async {
    try {
      var custo = await datasource.recuperarEsforcosCompartilhados(
          uidProjeto, tipoContagem);
      return Right(custo);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
