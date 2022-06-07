import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';

abstract class ContagemEstimadaRepository {
  Future<Either<String, ContagemEstimadaEntitie>> salvar(
    List<String> ce,
    List<String> ee,
    List<String> se,
    String uidProjeto,
    String uidUsuario,
    int totalPF,
  );

  Future<Either<String, ContagemEstimadaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario);
}
