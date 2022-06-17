import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';

abstract class CustoDatasource {
  Future<List<CustoEntity>> recuperarEstimativaCusto(
      String uidProjeto, String uidUsuario);

  Future<CustoEntity> salvarEstimativaCusto(CustoEntity custoEntity,
      String uidProjeto, String uidUsuario, String tipoContagem);
}
