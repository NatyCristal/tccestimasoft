import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/contagem/error/contagem_erro.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:estimasoft/features/resultado/domain/repository/resultado_recuperar_repository.dart';

class ResultadoRecuperarUsecase {
  final ResultadoRecuperarRepository repository;

  ResultadoRecuperarUsecase(this.repository);

  Future<Either<Falha, List<ResultadoEntity>>> recuperarContagensDetalhadas(
      String uidProjeto) async {
    var resultado = await repository.recuperarContagensDetalhada(uidProjeto);

    var erro = "";
    // ignore: prefer_typing_uninitialized_variables
    var retorno;

    resultado.fold((l) {
      erro = l.mensagem;
    }, (r) {
      retorno = r;
    });

    if (resultado.isLeft()) {
      return Left(
        ContagemEstimadaErro(
            mensagem: "Não foi possível salvar a função. O erro foi: $erro"),
      );
    }

    return Right(retorno);
  }
}
