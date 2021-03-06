import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';

abstract class PerfilRepository {
  Future<Either<String, String>> alterarNome(String nome);

  Future<Either<String, String>> alterarEmail(String email);

  Future<Either<String, String>> signOut();

  Future<Either<String, UsuarioEntity>> usuarioLogado();
}
