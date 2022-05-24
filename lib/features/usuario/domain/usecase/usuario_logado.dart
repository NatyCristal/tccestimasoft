import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import '../../../../core/errors/falha.dart';
import '../../error/usuario_erro.dart';
import '../repository/usuario_repository.dart';

class UsuarioLogadoUsecase {
  final PerfilRepository repository;

  UsuarioLogadoUsecase(this.repository);

  Future<Either<Falha, UsuarioEntitie>> verificarUsuario() async {
    var result = await repository.usuarioLogado();

    var retorno;

    result.fold((l) {
      retorno = l;
    }, (r) {
      retorno = r;
    });

    if (result.isLeft()) {
      switch (retorno) {
        case "unavailable":
          return Left(ErroUsuario(
              mensagem:
                  "Não foi possível fazer a conexão com o servidor. Verifique sua internet"));
        case "network-request-failed":
          return Left(
              ErroUsuario(mensagem: "Verifique sua conexao com a internet"));
        case "network_error":
          return Left(ErroUsuario(mensagem: "Sem conexão com a internet"));
        default:
          return Left(ErroUsuario(mensagem: "Algo de errado ocorreu!"));
      }
    } else {
      if (retorno.uid == "" || retorno.nome == "" || retorno.email == "") {
        return Left(ErroUsuario(mensagem: "Usuario não autenticado"));
      }
    }
    return Right(retorno);
  }
}
