import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';

abstract class EstimativaPrazo {
  Future<List<PrazoEntity>> recuperarEstimativaPrazo(
      String uidProjeto, String uidUsuario);

  Future<PrazoEntity> salvarEstimativaPrazo(PrazoEntity prazo,
      String uidProjeto, String uidUsuario, String tipoContagem);
}
