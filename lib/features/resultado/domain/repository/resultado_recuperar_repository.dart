import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

abstract class ResultadoRecuperarRepository {
  Future<Either<Falha, List<ResultadoEntity>>> recuperarContagensDetalhada(
      String uidProjeto);
}
