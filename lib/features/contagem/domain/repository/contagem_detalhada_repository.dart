import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';

abstract class ContagemDetalhadaRepository {
  Future<Either<String, ContagemDetalhadaEntitie>> salvar(
    ContagemDetalhadaEntitie contagemDetalhadaEntitie,
    String uidProjeto,
    String uidUsuario,
  );

  Future<Either<String, ContagemDetalhadaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario);
}
