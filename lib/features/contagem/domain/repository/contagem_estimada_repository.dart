import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

abstract class ContagemEstimadaRepository {
  Future<Either<String, ContagemEstimadaEntitie>> salvar(
    List<IndiceDescricaoContagenModel> aie,
    List<IndiceDescricaoContagenModel> ali,
    List<IndiceDescricaoContagenModel> ce,
    List<IndiceDescricaoContagenModel> ee,
    List<IndiceDescricaoContagenModel> se,
    String uidProjeto,
    String uidUsuario,
    int totalPF,
  );

  Future<Either<String, ContagemEstimadaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario);

  Future<Either<String, List<ContagemEstimadaEntitie>>>
      recuperarEstimadasCompartilhadas(String uidProjeto);
}
