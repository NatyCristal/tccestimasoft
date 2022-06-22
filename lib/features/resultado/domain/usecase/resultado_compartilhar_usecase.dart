import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/contagem/error/contagem_erro.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:estimasoft/features/resultado/domain/repository/resultado_repository.dart';

class ResultadoCompartilharUsecase {
  final ResultadoCompartiharRepository repository;

  ResultadoCompartilharUsecase(this.repository);

  Future<Either<Falha, ResultadoEntity>> enviarEstimativasCusto(
      bool anonimamente,
      CustoEntity custos,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await repository.enviarEstimativasCustos(
        anonimamente, custos, uidProjeto, uidUsuario);

    var erro = "";
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

  Future<Either<Falha, ResultadoEntity>> enviarEstimativasEquipe(
      bool anonimamente,
      EquipeEntity equipes,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await repository.enviarEstimativasEquipe(
        anonimamente, equipes, uidProjeto, uidUsuario);

    var erro = "";
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

  Future<Either<Falha, ResultadoEntity>> enviarEstimativasEsforco(
      bool anonimamente,
      EsforcoEntity esforcos,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await repository.enviarEstimativasEsforco(
        anonimamente, esforcos, uidProjeto, uidUsuario);

    var erro = "";
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

  Future<Either<Falha, ResultadoEntity>> enviarEstimativasPrazo(
      bool anonimamente,
      PrazoEntity prazos,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await repository.enviarEstimativasPrazo(
        anonimamente, prazos, uidProjeto, uidUsuario);

    var erro = "";
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
