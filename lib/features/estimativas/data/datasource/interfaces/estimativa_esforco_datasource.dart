import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';

abstract class EstimativaEsforcoDatasource {
  Future<List<EsforcoEntity>> recuperarEstimativaEsforco(
      String uidProjeto, String uidUsuario);

  Future<EsforcoEntity> salvarEstimativaEsforco(EsforcoEntity esforcoEntity,
      String uidProjeto, String uidUsuario, String tipoContagem);
}
