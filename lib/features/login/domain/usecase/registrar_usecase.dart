import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/repository/login_repository.dart';
import 'package:estimasoft/features/login/error/login_erro.dart';

class RegistrarUsuarioUsecase {
  final UsuarioRepository repository;

  RegistrarUsuarioUsecase(this.repository);

  Future cadastrarUsuario(String nome, String email, String senha) async {
    var result = await repository.registrarUsuario(nome, email, senha);
    var erro = "";

    result.fold((l) {
      erro = l.mensagem;
    }, (r) {});
    if (result.isLeft()) {
      switch (erro) {
        case "unavailable":
          return Left(ErroLogin(
              mensagem:
                  "Não foi possível fazer a conexão com o servidor. Verifique sua internet"));
        case "network-request-failed":
          return Left(ErroLogin(mensagem: "Sem conexão com a internet"));
        case "email-already-in-use":
          return Left(
              ErroLogin(mensagem: "Email informado já está cadastrado"));
        case "email-already-exists":
          return Left(
              ErroLogin(mensagem: "Email informado já está cadastrado"));
        case "invalid-email":
          return Left(ErroLogin(mensagem: "Email inválido"));
        default:
          return Left(ErroLogin(mensagem: "Ops! Algo de errado aconteceu"));
      }
    }

    return Right(result);
  }
}
