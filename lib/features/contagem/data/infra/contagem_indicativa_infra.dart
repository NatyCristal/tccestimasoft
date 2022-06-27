import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/contagem/data/datasource/interfaces/contagem_indicativa.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/contagem_indicativa_repository.dart';

class ContagemIndicativaInfra extends ContagemIndicativaRepository {
  final ContagemIndicativaDatasource datasource;

  ContagemIndicativaInfra(this.datasource);

  @override
  Future<Either<String, ContagemIndicativaEntitie>> salvar(
      List<String> alis,
      List<String> aies,
      String uidProjeto,
      String uidUsuario,
      int totalPF) async {
    try {
      var resultado =
          await datasource.salvar(alis, aies, uidProjeto, uidUsuario, totalPF);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, ContagemIndicativaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario) async {
    try {
      var resultado =
          await datasource.recuperarContagem(uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, List<ContagemIndicativaEntitie>>>
      recuperarIndicativasCompartilhadas(String uidProjeto) async {
    try {
      var resultado =
          await datasource.recuperarIndicativasCompartilhadas(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }
}
