import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/repository/esforco_repository.dart';
import 'package:estimasoft/features/estimativas/error/estimativas_error.dart';

class EstimativaEsforcoUsecase {
  final EsforcoRepository repository;

  EstimativaEsforcoUsecase(this.repository);

  Future salvarEstimativaEsforco(EsforcoEntity esforco, String uidProjeto,
      String uidUsuario, String tipoContagem) async {
    var result = await repository.salvarEstimativaEsforco(
        esforco, uidProjeto, uidUsuario, tipoContagem);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return Right(result);
  }

  Future<Either<Falha, List<EsforcoEntity>>> recuperarEstimativaEsforco(
      String uidProjeto, String uidUsuario) async {
    var result =
        await repository.recuperarEstimativaEsforco(uidProjeto, uidUsuario);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return result;
  }

  Future<Either<Falha, List<EsforcoEntity>>> recuperaEsforcosCompartilhados(
      String uidProjeto, String tipoContagem) async {
    var result = await repository.recuperarEsforcosCompartilhados(
        uidProjeto, tipoContagem);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return result;
  }
}
