import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repository/usuario_repository.dart';
import '../datasource/usuario_datasource.dart';

class UsuarioRepositoryData extends PerfilRepository {
  final PerfilDatasource dataSource;

  UsuarioRepositoryData(this.dataSource);

  @override
  Future<Either<String, String>> alterarEmail(email) async {
    try {
      var result = await dataSource.alterarEmail(email);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, String>> alterarNome(nome) async {
    try {
      var result = await dataSource.alterarNome(nome);
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, String>> signOut() async {
    try {
      var result = await dataSource.signOut();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }

  @override
  Future<Either<String, UsuarioEntitie>> usuarioLogado() async {
    try {
      var result = await dataSource.usuarioLogado();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
  }
}
