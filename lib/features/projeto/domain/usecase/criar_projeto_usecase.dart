import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/domain/repository/projeto_repository.dart';
import 'package:estimasoft/features/projeto/error/projeto_erro.dart';

class CriarProjetoUsecase {
  final ProjetoRepository repository;

  CriarProjetoUsecase(this.repository);

  Future<Either<Falha, ProjetoEntitie>> criarProjeto(
      String uid, String nomeProjeto, String nomeAdministrador) async {
    var result =
        await repository.criarProjeto(uid, nomeProjeto, nomeAdministrador);
    var erro = "";

    result.fold((l) {
      erro = l.mensagem;
    }, (r) {});

    if (result.isLeft()) {
      switch (erro) {
        default:
          return Left(
            ErroProjeto(mensagem: "Algo de errado aconteceu!"),
          );
      }
    }

    return result;
  }
}
