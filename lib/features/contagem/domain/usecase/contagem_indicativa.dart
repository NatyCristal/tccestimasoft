import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';

import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/contagem/domain/repository/contagem_indicativa_repository.dart';
import 'package:estimasoft/features/contagem/error/contagem_erro.dart';

class ContagemIndicativaUseCase {
  final ContagemIndicativaRepository repository;

  ContagemIndicativaUseCase(this.repository);

  Future<Either<Falha, ContagemIndicativaEntitie>> salvarContagemIndicativa(
      List<IndiceDescricaoContagenModel> alis,
      List<IndiceDescricaoContagenModel> aies,
      String uidProjeto,
      String uidUsuario,
      int totalPf) async {
    var resultado =
        await repository.salvar(alis, aies, uidProjeto, uidUsuario, totalPf);

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
        ContagemIndicativaErro(
            mensagem: "Não foi possível salvar a função. O erro foi: $erro"),
      );
    }

    return Right(retorno);
  }

  Future<Either<Falha, ContagemIndicativaEntitie>> recuperarContagemIndicativa(
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
        ContagemIndicativaErro(
            mensagem: "Não foi possível salvar a função. O erro foi: $erro"),
      );
    }

    return Right(retorno);
  }

  Future<Either<Falha, List<ContagemIndicativaEntitie>>>
      recuperarIndicativasCompartilhadas(String uidProjeto) async {
    var resultado =
        await repository.recuperarIndicativasCompartilhadas(uidProjeto);

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
        ContagemIndicativaErro(
            mensagem: "Não foi possível salvar a função. O erro foi: $erro"),
      );
    }

    return Right(retorno);
  }
}
