import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';

abstract class ContagemIndicativaRepository {
  Future<Either<String, ContagemIndicativaEntitie>> salvar(List<String> alis,
      List<String> aies, String uidProjeto, String uidUsuario, int totalPF);

  Future<Either<String, ContagemIndicativaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario);
}
