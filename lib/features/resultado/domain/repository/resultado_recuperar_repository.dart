import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

abstract class ResultadoRecuperarRepository {
  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasEsforco(
    String uidProjeto,
  );

  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasPrazo(
      String uidProjet);

  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasEquipe(
      String uidProjeto);

  Future<Either<Falha, List<ResultadoEntity>>> recuperarEstimativasCustos(
      String uidProjeto);

  Future<Either<Falha, List<ResultadoEntity>>> recuperaContagensIndicativas(
      String uidProjeto);

  Future<Either<Falha, List<ResultadoEntity>>> recuperarContagensDetalhada(
      String uidProjeto);

  Future<Either<Falha, List<ResultadoEntity>>> recuperarContagemEstimada(
      String uidProjeto);
}
