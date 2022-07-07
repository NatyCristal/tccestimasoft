import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import '../../domain/repository/contagem_estimada_repository.dart';
import '../datasource/interfaces/contagem_estimada.dart';

class ContagemEstimadaInfra extends ContagemEstimadaRepository {
  final ContagemEstimadaDatasource datasource;

  ContagemEstimadaInfra(this.datasource);

  @override
  Future<Either<String, ContagemEstimadaEntitie>> salvar(
      List<IndiceDescricaoContagenModel> aie,
      List<IndiceDescricaoContagenModel> ali,
      List<IndiceDescricaoContagenModel> ce,
      List<IndiceDescricaoContagenModel> ee,
      List<IndiceDescricaoContagenModel> se,
      String uidProjeto,
      String uidUsuario,
      int totalPF) async {
    try {
      var resultado = await datasource.salvarContagem(
          aie, ali, ce, ee, se, uidProjeto, uidUsuario, totalPF);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, ContagemEstimadaEntitie>> recuperarContagem(
      String uidProjeto, String uidUsuario) async {
    try {
      var resultado =
          await datasource.recuperarContagemEstimada(uidProjeto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, List<ContagemEstimadaEntitie>>>
      recuperarEstimadasCompartilhadas(String uidProjeto) async {
    try {
      var resultado =
          await datasource.recuperarEstimadasCompartilhadas(uidProjeto);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(e.code);
    }
  }
}
