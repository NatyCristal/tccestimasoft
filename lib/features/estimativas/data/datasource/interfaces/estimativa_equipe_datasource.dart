import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';

abstract class EstimativaEquipeDatasource {
  Future<List<EquipeEntity>> recuperarEstimativaEquipe(
      String uidProjeto, String uidUsuario);

  Future<EquipeEntity> salvarEstimativaEquipe(EquipeEntity equipeEntity,
      String uidProjeto, String uidUsuario, String tipoContagem);

  Future<List<EquipeEntity>> recuperarEquipesCompartilhadas(
      String uidProjeto, String tipoContagem);
}
