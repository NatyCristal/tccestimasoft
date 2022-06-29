import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/contagem/error/contagem_erro.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:estimasoft/features/resultado/domain/repository/resultado_recuperar_repository.dart';

class ResultadoRecuperarUsecase {
  final ResultadoRecuperarRepository repository;

  ResultadoRecuperarUsecase(this.repository);

  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasCusto(
    String uidProjeto,
  ) async {
    var resultado = await repository.recuperarEstimativasCustos(uidProjeto);

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

  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasEquipe(
      String uidProjeto) async {
    var resultado = await repository.recuperarEstimativasEquipe(uidProjeto);

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

  Future<Either<Falha, List<ResultadoEntity>>> enviarEstimativasEsforco(
    String uidProjeto,
  ) async {
    var resultado = await repository.recuperarEstimativasEsforco(uidProjeto);

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

  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasPrazo(
      String uidProjeto) async {
    var resultado = await repository.recuperarEstimativasPrazo(uidProjeto);

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

  Future<Either<Falha, List<ResultadoEntity>>> recuperarContagensIndicativas(
      String uidProjeto) async {
    var resultado = await repository.recuperaContagensIndicativas(uidProjeto);

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

  Future<Either<Falha, List<ResultadoEntity>>> recuperarContagensEstimada(
      String uidProjeto) async {
    var resultado = await repository.recuperarContagemEstimada(uidProjeto);

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
