import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/repository/prazo_repository.dart';
import 'package:estimasoft/features/estimativas/error/estimativas_error.dart';

import '../../../../core/errors/falha.dart';

class EstimativaPrazoUsecase {
  final PrazoRepository repository;

  EstimativaPrazoUsecase(this.repository);

  Future salvarEstimativaPrazo(PrazoEntity prazo, String uidProjeto,
      String uidUsuario, String tipoContagem) async {
    var result = await repository.salvarEstimativaPrazo(
        prazo, uidProjeto, uidUsuario, tipoContagem);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return Right(result);
  }

  Future<Either<Falha, List<PrazoEntity>>> recuperarEstimativaPrazo(
      String uidProjeto, String uidUsuario) async {
    var result =
        await repository.recuperarEstimativPrazo(uidProjeto, uidUsuario);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return result;
  }

  Future<Either<Falha, List<PrazoEntity>>> recuperarPrazosCompartilhados(
      String uidProjeto, String tipoContagem) async {
    var result = await repository.recuperarPrazosCompartilhados(
        uidProjeto, tipoContagem);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return result;
  }
}
