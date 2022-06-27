import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';

abstract class EsforcoRepository {
  Future<Either<Falha, List<EsforcoEntity>>> recuperarEstimativaEsforco(
      String uidProjeto, String uidUsuario);

  Future<Either<Falha, EsforcoEntity>> salvarEstimativaEsforco(
      EsforcoEntity esforcoEntity,
      String uidProjeto,
      String uidUsuario,
      String tipoContagem);

  Future<Either<Falha, List<EsforcoEntity>>> recuperarEsforcosCompartilhados(
      String uidProjeto, String tipoContagem);
}
