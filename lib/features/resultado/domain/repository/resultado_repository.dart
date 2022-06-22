import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';

abstract class ResultadoCompartiharRepository {
  Future<Either<Falha, EsforcoEntity>> enviarEstimativasEsforco(
      bool anonimamente,
      EsforcoEntity esforcos,
      String uidProjeto,
      String uidUsuario);

  Future<Either<Falha, PrazoEntity>> enviarEstimativasPrazo(bool anonimamente,
      PrazoEntity prazos, String uidProjeto, String uidUsuario);

  Future<Either<Falha, EquipeEntity>> enviarEstimativasEquipe(bool anonimamente,
      EquipeEntity equipes, String uidProjeto, String uidUsuario);

  Future<Either<Falha, CustoEntity>> enviarEstimativasCustos(bool anonimamente,
      CustoEntity custos, String uidProjeto, String uidUsuario);
}
