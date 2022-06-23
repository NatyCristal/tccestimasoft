import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

abstract class ResultadoRecuperarDatasource {
  Future<List<ResultadoEntity>> recuperarEstimativasEsforco(String uidProjeto);

  Future<List<ResultadoEntity>> recuperarEstimativasPrazo(String uidProjeto);

  Future<List<ResultadoEntity>> recuperarEstimativasEquipe(String uidProjeto);

  Future<List<ResultadoEntity>> recuperarEstimativasCustos(String uidProjeto);

  Future<List<ResultadoEntity>> recuperarContagens(String uidProjeto);
}
