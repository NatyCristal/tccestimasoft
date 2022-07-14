import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

abstract class ResultadoCompartiharRepository {
  Future<Either<Falha, ResultadoEntity>> enviarContagemDetaoyada(
      bool anonimamente, String texto, String uidProjeto, String uidUsuario);
}
