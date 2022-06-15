import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/estimativas/data/datasource/estimativa_firebase_prazo_datasource.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/repository/prazo_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EstimativaPrazoFirebase extends PrazoRepository {
  final EstimativaFirebasePrazoDatasource datasource;

  EstimativaPrazoFirebase(this.datasource);

  @override
  Future<Either<Falha, List<PrazoEntity>>> recuperarEstimativPrazo(
      String uidProjeto, String uidUsuario) async {
    try {
      var resultado =
          await datasource.recuperarEstimativaPrazo(uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, PrazoEntity>> salvarEstimativaPrazo(
      PrazoEntity prazoEntity,
      String uidProjeto,
      String uidUsuario,
      String tipoContagem) async {
    try {
      var usuario = await datasource.salvarEstimativaPrazo(
          prazoEntity, uidProjeto, uidUsuario, tipoContagem);
      return Right(usuario);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
