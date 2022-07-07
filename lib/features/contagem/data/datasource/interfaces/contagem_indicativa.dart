import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';

abstract class ContagemIndicativaDatasource {
  Future<ContagemIndicativaEntitie> salvar(
      List<IndiceDescricaoContagenModel> alis,
      List<IndiceDescricaoContagenModel> aies,
      String uidProjeto,
      String iudUsuario,
      int totalPf);

  Future<ContagemIndicativaEntitie> recuperarContagem(
      String uidProjeto, String uidUsuario);

  Future<List<ContagemIndicativaEntitie>> recuperarIndicativasCompartilhadas(
      String uidProjeto);
}
