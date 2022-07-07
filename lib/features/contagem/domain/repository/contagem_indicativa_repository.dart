import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';

abstract class ContagemIndicativaRepository {
  Future<Either<String, ContagemIndicativaEntitie>> salvar(
      List<IndiceDescricaoContagenModel> alis,
      List<IndiceDescricaoContagenModel> aies,
      String uidProjeto,
      String uidUsuario,
      int totalPF);

  Future<Either<String, ContagemIndicativaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario);

  Future<Either<String, List<ContagemIndicativaEntitie>>>
      recuperarIndicativasCompartilhadas(String uidProjeto);
}
