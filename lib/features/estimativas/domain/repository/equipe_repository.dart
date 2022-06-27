import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';

abstract class EquipeRepository {
  Future<Either<Falha, List<EquipeEntity>>> recuperarEstimativaEquipe(
      String uidProjeto, String uidUsuario);

  Future<Either<Falha, EquipeEntity>> salvarEstimativaEquipe(
      EquipeEntity equipeEntity,
      String uidProjeto,
      String uidUsuario,
      String tipoContagem);

  Future<Either<Falha, List<EquipeEntity>>> recuperarEquipesCompartilhadas(
      String uidProjeto, String tipoContagem);
}
