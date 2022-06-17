import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/repository/equipe_repository.dart';
import 'package:estimasoft/features/estimativas/error/estimativas_error.dart';

class EquipeUsecase {
  final EquipeRepository repository;

  EquipeUsecase(this.repository);

  Future salvarEstimativaEquipe(EquipeEntity equipeEntity, String uidProjeto,
      String uidUsuario, String tipoContagem) async {
    var result = await repository.salvarEstimativaEquipe(
        equipeEntity, uidProjeto, uidUsuario, tipoContagem);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return Right(result);
  }

  Future<Either<Falha, List<EquipeEntity>>> recuperarEstimativaEquipe(
      String uidProjeto, String uidUsuario) async {
    var result =
        await repository.recuperarEstimativaEquipe(uidProjeto, uidUsuario);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return result;
  }
}
