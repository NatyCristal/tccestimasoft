import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/repository/contagem_detalhada_repository.dart';
import 'package:estimasoft/features/contagem/error/contagem_erro.dart';

class ContagemDetalhadaUsecase {
  final ContagemDetalhadaRepository repository;

  ContagemDetalhadaUsecase(this.repository);

  Future<Either<Falha, ContagemDetalhadaEntitie>> salva(
    ContagemDetalhadaEntitie contagemDetalhadaEntitie,
    String uidProjeto,
    String uidUsuario,
  ) async {
    var resultado = await repository.salvar(
        contagemDetalhadaEntitie, uidProjeto, uidUsuario);

    var erro = "";
    // ignore: prefer_typing_uninitialized_variables
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

  Future<Either<Falha, ContagemDetalhadaEntitie>> recuperarContagemDetalhada(
      String uidProjeto, String uidUsuario) async {
    var resultado = await repository.recuperarContagem(uidProjeto, uidUsuario);

    var erro = "";
    // ignore: prefer_typing_uninitialized_variables
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
