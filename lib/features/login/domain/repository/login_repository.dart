import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:dartz/dartz.dart';

abstract class UsuarioRepository {
  Future<Either<Falha, UsuarioEntitie>> realizarLoginEmailSenha(
      String email, String senha);

  Future<Either<Falha, UsuarioEntitie>> registrarUsuario(
      String nome, String email, String senha);

  Future<Either<Falha, String>> redefinirSenha(String email);

  Future<Either<Falha, UsuarioEntitie>> realizarLoginGoogle();
}
