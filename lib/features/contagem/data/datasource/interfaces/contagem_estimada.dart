import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

abstract class ContagemEstimadaDatasource {
  Future<ContagemEstimadaEntitie> recuperarContagemEstimada(
      String uidProjeto, String uidUsuario);

  Future<ContagemEstimadaEntitie> salvarContagem(
      List<String> aie,
      List<String> ali,
      List<String> ce,
      List<String> ee,
      List<String> se,
      String uidProjeto,
      String uidUsuario,
      int totalPF);

  Future<List<ContagemEstimadaEntitie>> recuperarEstimadasCompartilhadas(
      String uidProjeto);
}
