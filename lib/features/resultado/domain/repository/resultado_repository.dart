import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

abstract class ResultadoCompartiharRepository {
  Future<Either<Falha, ResultadoEntity>> enviarEstimativasEsforco(
      bool anonimamente,
      EsforcoEntity esforcos,
      String uidProjeto,
      String uidUsuario);

  Future<Either<Falha, ResultadoEntity>> enviarEstimativasPrazo(
      bool anonimamente,
      PrazoEntity prazos,
      String uidProjeto,
      String uidUsuario);

  Future<Either<Falha, ResultadoEntity>> enviarEstimativasEquipe(
      bool anonimamente,
      EquipeEntity equipes,
      String uidProjeto,
      String uidUsuario);

  Future<Either<Falha, ResultadoEntity>> enviarEstimativasCustos(
      bool anonimamente,
      CustoEntity custos,
      String uidProjeto,
      String uidUsuario);

  Future<Either<Falha, ResultadoEntity>> enviarContagemIndicativa(
      bool anonimamente,
      ContagemIndicativaEntitie contagemIndicativa,
      String uidProjeto,
      String uidUsuario);

  Future<Either<Falha, ResultadoEntity>> enviarContagemEstimada(
      bool anonimamente,
      ContagemEstimadaEntitie contagemEstimada,
      String uidProjeto,
      String uidUsuario);

  Future<Either<Falha, ResultadoEntity>> enviarContagemDetaoyada(
      bool anonimamente,
      ContagemDetalhadaEntitie contagemDetalhadaEntitie,
      String uidProjeto,
      String uidUsuario);
}
