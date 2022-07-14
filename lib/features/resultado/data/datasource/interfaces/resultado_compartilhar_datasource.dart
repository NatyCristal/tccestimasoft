import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

abstract class CompartilharResultadoDatasource {
  Future<ResultadoEntity> enviarContagemDetalhada(
      bool anonimamente, String texto, String uidProjeto, String uidUsuario);
}
