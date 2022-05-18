import 'package:dartz/dartz.dart';

abstract class PerfilRepository {
  Future<Either<String, String>> alterarNome(String nome);

  Future<Either<String, String>> alterarEmail(String email);

  Future<Either<String, String>> signOut();
}
