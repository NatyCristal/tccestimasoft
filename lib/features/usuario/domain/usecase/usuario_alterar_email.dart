import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/usuario/error/usuario_erro.dart';
import '../repository/usuario_repository.dart';

class AlterarEmailUsecase {
  final PerfilRepository repository;

  AlterarEmailUsecase(this.repository);

  Future<Either<Falha, String>> alterarEmail(String email) async {
    var result = await repository.alterarEmail(email);
    var retorno = "";

    result.fold((l) {
      retorno = l;
    }, (r) {
      retorno = r;
    });

    if (result.isLeft()) {
      switch (retorno) {
        case "email-already-in-use":
          return Left(ErroUsuario(
              mensagem: "Email informado já está associado a outra conta"));
        case "requires-recent-login":
          return Left(ErroUsuario(
              mensagem:
                  "Para alterar email precisa estar logado recentemente. Saia do aplicativo e faça o login novamente."));
        case "unavailable":
          return Left(ErroUsuario(
              mensagem:
                  "Não foi possível fazer a conexão com o servidor. Verifique sua internet"));
        case "network-request-failed":
          return Left(
              ErroUsuario(mensagem: "Verifique sua conexao com a internet"));
        case "network_error":
          return Left(ErroUsuario(mensagem: "Sem conexão com a internet"));
        case "user-not-found":
          return Left(ErroUsuario(mensagem: "Usuário não cadastrado"));
        case "invalid-email":
          return Left(ErroUsuario(mensagem: "Email inválido"));

        default:
          Left(ErroUsuario(mensagem: "Algo Aconteceu"));
      }
    }
    return Right(retorno);
  }
}
