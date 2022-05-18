import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/domain/repository/projeto_repository.dart';
import 'package:estimasoft/features/projeto/error/projeto_erro.dart';
import '../../../../../core/errors/falha.dart';

class RecuperarProjetosUsecase {
  final ProjetoRepository repository;

  RecuperarProjetosUsecase(this.repository);

  Future<Either<Falha, List<ProjetoEntitie>>> recuperarProjetos(
      String uid) async {
    var result = await repository.rrecuperarProjetos(uid);
    var erro = "";

    result.fold((l) {
      erro = l.mensagem;
    }, (r) {});

    if (result.isLeft()) {
      switch (erro) {
        case "unavailable":
          return Left(
            ErroProjeto(
                mensagem:
                    "Não foi possível fazer a conexão com o servidor. Verifique sua internet"),
          );
        default:
          return Left(
            ErroProjeto(mensagem: "Algo de errado aconteceu!"),
          );
      }
    }

    return result;
  }
}
