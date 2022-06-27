import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';

abstract class ContagemIndicativaDatasource {
  Future<ContagemIndicativaEntitie> salvar(List<String> alis, List<String> aies,
      String uidProjeto, String iudUsuario, int totalPf);

  Future<ContagemIndicativaEntitie> recuperarContagem(
      String uidProjeto, String uidUsuario);

  Future<List<ContagemIndicativaEntitie>> recuperarIndicativasCompartilhadas(
      String uidProjeto);
}
