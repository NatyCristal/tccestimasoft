import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';

abstract class PrazoRepository {
  Future<Either<Falha, List<PrazoEntity>>> recuperarEstimativPrazo(
      String uidProjeto, String uidUsuario);

  Future<Either<Falha, PrazoEntity>> salvarEstimativaPrazo(
      PrazoEntity prazoEntity,
      String uidProjeto,
      String uidUsuario,
      String tipoContagem);

  Future<Either<Falha, List<PrazoEntity>>> recuperarPrazosCompartilhados(
      String uidProjeto, String tipoContagem);
}
