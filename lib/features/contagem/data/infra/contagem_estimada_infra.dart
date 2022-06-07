import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import '../../domain/repository/contagem_estimada_repository.dart';
import '../datasource/interfaces/contagem_estimada.dart';

class ContagemEstimadaInfra extends ContagemEstimadaRepository {
  final ContagemEstimadaDatasource datasource;

  ContagemEstimadaInfra(this.datasource);

  @override
  Future<Either<String, ContagemEstimadaEntitie>> salvar(
      List<String> ce,
      List<String> ee,
      List<String> se,
      String uidProjeto,
      String uidUsuario,
      int totalPF) async {
    try {
      var resultado = await datasource.salvarContagem(
          ce, ee, se, uidProjeto, uidUsuario, totalPF);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, ContagemEstimadaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario) async {
    try {
      var resultado =
          await datasource.recuperarContagemEstimada(uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }
}
