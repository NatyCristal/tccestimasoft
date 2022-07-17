import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

abstract class ResultadoRecuperarDatasource {
  Future<List<ResultadoEntity>> recuperarContagensDetalhadas(String uidProjeto);
}
