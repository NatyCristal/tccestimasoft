import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/estimativas/data/datasource/interfaces/estimativa_custo_datasource.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/estimativas/domain/repository/custo_repository.dart';

class EstimativaCustoFirebase extends CustoRepository {
  final CustoDatasource datasource;

  EstimativaCustoFirebase(this.datasource);

  @override
  Future<Either<Falha, List<CustoEntity>>> recuperarCusto(
      String uidProjeto, String uidUsuario) async {
    try {
      var resultado =
          await datasource.recuperarEstimativaCusto(uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, CustoEntity>> salvarCusto(CustoEntity custoEntity,
      String uidProjeto, String uidUsuario, String tipoContagem) async {
    try {
      var custo = await datasource.salvarEstimativaCusto(
          custoEntity, uidProjeto, uidUsuario, tipoContagem);
      return Right(custo);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, List<CustoEntity>>> recuperaCustosCompartilhados(
      String uidProjeto, String tipoContagem) async {
    try {
      var custo = await datasource.recuperaCustosCompartilhados(
          uidProjeto, tipoContagem);
      return Right(custo);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
