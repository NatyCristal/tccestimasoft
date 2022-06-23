import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
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
  Future<Either<Falha, ResultadoEntity>> enviarEstimativasCustos(
      bool anonimamente,
      CustoEntity custos,
      String uidProjeto,
      String uidUsuario) async {
    try {
      var resultado = await datasource.enviarEstimativasCustos(
          anonimamente, custos, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, ResultadoEntity>> enviarEstimativasEquipe(anonimamente,
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
  Future<Either<Falha, ResultadoEntity>> enviarEstimativasEsforco(
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
  Future<Either<Falha, ResultadoEntity>> enviarEstimativasPrazo(
      bool anonimamente,
      PrazoEntity prazos,
      String uidProjeto,
      String uidUsuario) async {
    try {
      var resultado = await datasource.enviarEstimativasPrazo(
          anonimamente, prazos, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, ResultadoEntity>> enviarContagemDetaoyada(
      bool anonimamente,
      ContagemDetalhadaEntitie contagemDetalhadaEntitie,
      String uidProjeto,
      String uidUsuario) async {
    try {
      var resultado = await datasource.enviarContagemDetalhada(
          anonimamente, contagemDetalhadaEntitie, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, ResultadoEntity>> enviarContagemEstimada(
      bool anonimamente,
      ContagemEstimadaEntitie contagemEstimada,
      String uidProjeto,
      String uidUsuario) async {
    try {
      var resultado = await datasource.enviarContagemEstimada(
          anonimamente, contagemEstimada, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, ResultadoEntity>> enviarContagemIndicativa(
      bool anonimamente,
      ContagemIndicativaEntitie contagemIndicativa,
      String uidProjeto,
      String uidUsuario) async {
    try {
      var resultado = await datasource.enviarContagemIndicativa(
          anonimamente, contagemIndicativa, uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
