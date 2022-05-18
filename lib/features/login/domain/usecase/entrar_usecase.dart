import 'package:estimasoft/features/login/domain/repository/login_repository.dart';
import 'package:estimasoft/features/login/error/login_erro.dart';
import 'package:dartz/dartz.dart';

class EntrarLoginUsecase {
  final UsuarioRepository repository;

  EntrarLoginUsecase(this.repository);

  Future entrarLogin(String email, String senha) async {
    var result = await repository.realizarLoginEmailSenha(email, senha);
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
          return Left(
              ErroLogin(mensagem: "Verifique sua conexao com a internet"));
        case "network_error":
          return Left(ErroLogin(mensagem: "Sem conexão com a internet"));
        case "user-not-found":
          return Left(ErroLogin(mensagem: "Usuário não cadastrado"));
        case "invalid-email":
          return Left(ErroLogin(mensagem: "Email inválido"));
        case "invalid-password":
          return Left(ErroLogin(mensagem: "Dados informados incorretos"));
        default:
          return Left(ErroLogin(mensagem: "Algo de errado aconteceu!"));
      }
    }

    return Right(result);
  }
}
