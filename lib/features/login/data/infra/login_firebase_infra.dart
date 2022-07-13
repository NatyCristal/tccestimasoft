import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/repository/login_repository.dart';
import 'package:estimasoft/features/login/error/login_erro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../datasource/Login_datasource.dart';

class LoginInfraFirebase extends UsuarioRepository {
  final LoginDatasource datasource;

  LoginInfraFirebase(this.datasource);

  @override
  Future<Either<Falha, UsuarioEntity>> realizarLoginEmailSenha(
      String email, String senha) async {
    try {
      UsuarioEntity usuario =
          await datasource.realizarLoginEmailSenha(email, senha);
      return Right(usuario);
    } on PlatformException catch (e) {
      return Left(ErroLogin(mensagem: e.code));
    } on FirebaseAuthException catch (e) {
      return Left(ErroLogin(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, UsuarioEntity>> realizarLoginGoogle() async {
    try {
      var resultado = await datasource.realizarLoginGoogle();
      return Right(resultado);
    } on PlatformException catch (e) {
      return Left(ErroLogin(mensagem: e.code));
    } on FirebaseAuthException catch (e) {
      return Left(ErroLogin(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, String>> redefinirSenha(String email) async {
    try {
      var result = await datasource.recuperarSenha(email);
      return Right(result);
    } on PlatformException catch (e) {
      return Left(ErroLogin(mensagem: e.code));
    } on FirebaseAuthException catch (e) {
      return Left(ErroLogin(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, UsuarioEntity>> registrarUsuario(
      String nome, String email, String senha) async {
    try {
      UsuarioEntity usuario =
          await datasource.cadastrarUsuario(nome, email, senha);
      return Right(usuario);
    } on PlatformException catch (e) {
      return Left(ErroLogin(mensagem: e.code));
    } on FirebaseException catch (e) {
      return Left(ErroLogin(mensagem: e.code));
    }
  }
}
