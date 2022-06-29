import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';

abstract class ContagemDetalhadaDatasource {
  Future<ContagemDetalhadaEntitie> recuperarContagemDetalhada(
      String uidProjeto, String uidUsuario);

  Future<ContagemDetalhadaEntitie> salvarContageDetalhada(
      ContagemDetalhadaEntitie contagemDetalhadaEntitie,
      String uidProjeto,
      String uidUsuario);

  Future<List<ContagemDetalhadaEntitie>> recuperarDetalhadasCompartilhadas(
      String uidProjeto);
}
