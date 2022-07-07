import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

abstract class ContagemEstimadaDatasource {
  Future<ContagemEstimadaEntitie> recuperarContagemEstimada(
      String uidProjeto, String uidUsuario);

  Future<ContagemEstimadaEntitie> salvarContagem(
      List<IndiceDescricaoContagenModel> aie,
      List<IndiceDescricaoContagenModel> ali,
      List<IndiceDescricaoContagenModel> ce,
      List<IndiceDescricaoContagenModel> ee,
      List<IndiceDescricaoContagenModel> se,
      String uidProjeto,
      String uidUsuario,
      int totalPF);

  Future<List<ContagemEstimadaEntitie>> recuperarEstimadasCompartilhadas(
      String uidProjeto);
}
