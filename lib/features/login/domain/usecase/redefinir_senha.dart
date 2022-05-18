import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/repository/login_repository.dart';
import 'package:estimasoft/features/login/error/login_erro.dart';

class RedefinirSenhaUsecase {
  final UsuarioRepository repository;

  RedefinirSenhaUsecase(this.repository);

  recuperarSenha(String email) async {
    var result = await repository.redefinirSenha(email);
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
        case "expired-action-code":
          return Left(ErroLogin(mensagem: "Código expirou"));
        case "invalid-action-code":
          return Left(ErroLogin(mensagem: "Código  inválido ou já foi usado."));
        case "user-disabled":
          return Left(ErroLogin(mensagem: "Usuário desativado"));
        case "user-not-found":
          return Left(ErroLogin(mensagem: "Usuário não encontrado"));
        default:
          return Left(ErroLogin(mensagem: "Ops! Algo de errado aconteceu"));
      }
    }
    return Right(result);
  }
}
