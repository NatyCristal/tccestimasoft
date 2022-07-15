import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/domain/repository/projeto_repository.dart';
import 'package:estimasoft/features/projeto/error/projeto_erro.dart';

class EntraProjetoUsecase {
  final ProjetoRepository repository;

  EntraProjetoUsecase(this.repository);

  Future<Either<Falha, ProjetoEntitie>> entrarEmProjeto(
      String uidUsuario, String uidProjeto) async {
    var result = await repository.entrarEmProjeto(uidUsuario, uidProjeto);
    var erro = "";

    result.fold((l) {
      erro = l.mensagem;
    }, (r) {});

    if (result.isLeft()) {
      switch (erro) {
        default:
          return Left(
            ErroProjeto(
                mensagem:
                    "Projeto não encontrado! Verifique o código de compartilhamento"),
          );
      }
    }

    return result;
  }
}
