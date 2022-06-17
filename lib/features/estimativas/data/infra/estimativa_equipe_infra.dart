import 'package:estimasoft/features/estimativas/data/datasource/estimativa_firebase_equipe_datasource.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/estimativas/domain/repository/equipe_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EstimativaEquipeFirebase extends EquipeRepository {
  final EstimativaEquipeFirebaseDatasource datasource;

  EstimativaEquipeFirebase(this.datasource);

  @override
  Future<Either<Falha, List<EquipeEntity>>> recuperarEstimativaEquipe(
      String uidProjeto, String uidUsuario) async {
    try {
      var resultado =
          await datasource.recuperarEstimativaEquipe(uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, EquipeEntity>> salvarEstimativaEquipe(
      EquipeEntity equipeEntity,
      String uidProjeto,
      String uidUsuario,
      String tipoContagem) async {
    try {
      var usuario = await datasource.salvarEstimativaEquipe(
          equipeEntity, uidProjeto, uidUsuario, tipoContagem);
      return Right(usuario);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
