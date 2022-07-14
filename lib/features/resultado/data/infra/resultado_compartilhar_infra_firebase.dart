import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/resultado/data/datasource/interfaces/resultado_compartilhar_datasource.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:estimasoft/features/resultado/domain/repository/resultado_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ResultadoInfraCompartilharFirebase
    extends ResultadoCompartiharRepository {
  final CompartilharResultadoDatasource datasource;

  ResultadoInfraCompartilharFirebase(this.datasource);

  @override
  Future<Either<Falha, ResultadoEntity>> enviarContagemDetaoyada(
      bool anonimamente,
      String texto,
      String uidProjeto,
      String uidUsuario) async {
    try {
      var resultado = await datasource.enviarContagemDetalhada(
          anonimamente, texto, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
