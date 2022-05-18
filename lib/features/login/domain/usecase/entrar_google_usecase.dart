import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/repository/login_repository.dart';
import 'package:estimasoft/features/login/error/login_erro.dart';

class EntrarGoogleUsecase {
  final UsuarioRepository repository;

  EntrarGoogleUsecase(this.repository);

  Future realizarLoginGoogle() async {
    var result = await repository.realizarLoginGoogle();
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
        case "INVALID_ACCOUNT":
          return Left(ErroLogin(mensagem: "Conta Inválida"));
        case "SIGN_IN_CANCELLED":
          return Left(
              ErroLogin(mensagem: "O Login foi cancelado pelo usuário"));
        default:
          Left(ErroLogin(mensagem: "Algo de errado aconteceu!"));
      }
    }

    return Right(result);
  }
}
