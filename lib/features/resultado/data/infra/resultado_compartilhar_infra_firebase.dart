import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/resultado/data/datasource/resultado_compartilhar_datasource.dart';
import 'package:estimasoft/features/resultado/domain/repository/resultado_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ResultadoInfraCompartilharFirebase
    extends ResultadoCompartiharRepository {
  final CompartilharResultadoDatasource datasource;

  ResultadoInfraCompartilharFirebase(this.datasource);

  @override
  Future<Either<Falha, CustoEntity>> enviarEstimativasCustos(bool anonimamente,
      CustoEntity custos, String uidProjeto, String uidUsuario) async {
    try {
      var resultado = await datasource.enviarEstimativasCustos(
          anonimamente, custos, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, EquipeEntity>> enviarEstimativasEquipe(anonimamente,
      EquipeEntity equipes, String uidProjeto, String uidUsuario) async {
    try {
      var resultado = await datasource.enviarEstimativasEquipe(
          anonimamente, equipes, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, EsforcoEntity>> enviarEstimativasEsforco(
      bool anonimamente,
      EsforcoEntity esforcos,
      String uidProjeto,
      String uidUsuario) async {
    try {
      var resultado = await datasource.enviarEstimativasEsforco(
          anonimamente, esforcos, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, PrazoEntity>> enviarEstimativasPrazo(bool anonimamente,
      PrazoEntity prazos, String uidProjeto, String uidUsuario) async {
    try {
      var resultado = await datasource.enviarEstimativasPrazo(
          anonimamente, prazos, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
