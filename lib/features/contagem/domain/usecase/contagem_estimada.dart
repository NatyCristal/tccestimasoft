// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/repository/contagem_estimada_repository.dart';
import 'package:estimasoft/features/contagem/error/contagem_erro.dart';

class ContagemEstimadaUsecase {
  final ContagemEstimadaRepository repository;

  ContagemEstimadaUsecase(this.repository);

  Future<Either<Falha, ContagemEstimadaEntitie>> salvarContagemEstimada(
      List<String> ce,
      List<String> ee,
      List<String> se,
      String uidProjeto,
      String uidUsuario,
      int totalPf) async {
    var resultado =
        await repository.salvar(ce, ee, se, uidProjeto, uidUsuario, totalPf);

    var erro = "";
    var retorno;

    resultado.fold((l) {
      erro = l;
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

  Future<Either<Falha, ContagemEstimadaEntitie>> recuperarContagemEstimada(
      String uidProjeto, String uidUsuario) async {
    var resultado = await repository.recuperarContagem(uidProjeto, uidUsuario);

    var erro = "";
    var retorno;

    resultado.fold((l) {
      erro = l;
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
