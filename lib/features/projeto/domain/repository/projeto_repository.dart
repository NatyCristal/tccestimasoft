import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import '../entitie/projeto_entitie.dart';

abstract class ProjetoRepository {
  Future<Either<Falha, List<ProjetoEntitie>>> rrecuperarProjetos(String uid);

  Future<Either<Falha, ProjetoEntitie>> criarProjeto(
      String uidUsuario, String nomeProjeto);

  Future<Either<Falha, String>> removerProjeto(
      String uidUsuario, String uidProjeto);

  Future<Either<Falha, String>> sairProjeto(
      String uidUsuario, String uidProjeto);

  Future<Either<Falha, ProjetoEntitie>> entrarEmProjeto(
    String uidProjeto,
  );

  Future<Either<Falha, List<UsuarioEntitie>>> recuperarMembros(
    String uidProjeto,
  );
}
