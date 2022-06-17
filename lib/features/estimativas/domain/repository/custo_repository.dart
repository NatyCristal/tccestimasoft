import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';

abstract class CustoRepository {
  Future<Either<Falha, List<CustoEntity>>> recuperarCusto(
      String uidProjeto, String uidUsuario);

  Future<Either<Falha, CustoEntity>> salvarCusto(CustoEntity custoEntity,
      String uidProjeto, String uidUsuario, String tipoContagem);
}
