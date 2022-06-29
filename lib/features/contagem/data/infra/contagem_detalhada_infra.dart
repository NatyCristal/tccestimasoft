import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/contagem/data/datasource/interfaces/contagem_detalhada.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/repository/contagem_detalhada_repository.dart';

class ContagemDetalhadaInfra extends ContagemDetalhadaRepository {
  final ContagemDetalhadaDatasource datasource;

  ContagemDetalhadaInfra(this.datasource);

  @override
  Future<Either<String, ContagemDetalhadaEntitie>> salvar(
    ContagemDetalhadaEntitie contagemDetalhadaEntitie,
    String uidProjeto,
    String uidUsuario,
  ) async {
    try {
      var resultado = await datasource.salvarContageDetalhada(
          contagemDetalhadaEntitie, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, ContagemDetalhadaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario) async {
    try {
      var resultado =
          await datasource.recuperarContagemDetalhada(uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, List<ContagemDetalhadaEntitie>>>
      recuperarDetalhadasCompartilhadas(String uidProjeto) async {
    try {
      var resultado =
          await datasource.recuperarDetalhadasCompartilhadas(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }
}
