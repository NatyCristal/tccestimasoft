import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/repository/custo_repository.dart';
import 'package:estimasoft/features/estimativas/error/estimativas_error.dart';

class CustoUsecase {
  final CustoRepository repository;

  CustoUsecase(this.repository);

  Future salvarEstimativaCusto(CustoEntity custoEntity, String uidProjeto,
      String uidUsuario, String tipoContagem) async {
    var result = await repository.salvarCusto(
        custoEntity, uidProjeto, uidUsuario, tipoContagem);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return Right(result);
  }

  Future<Either<Falha, List<CustoEntity>>> recuperarEstimativaCusto(
      String uidProjeto, String uidUsuario) async {
    var result = await repository.recuperarCusto(uidProjeto, uidUsuario);

    if (result.isLeft()) {
      Left(ErroEstimativas(mensagem: "Algo de errado aconteceu!"));
    }

    return result;
  }
}
