import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import '../../../../core/errors/falha.dart';
import '../../error/projeto_erro.dart';
import '../repository/projeto_repository.dart';

class RecuperarMembrosUsecase {
  final ProjetoRepository repository;

  RecuperarMembrosUsecase(this.repository);

  Future<Either<Falha, List<UsuarioEntitie>>> recuperarMembros(
      String uidProjeto) async {
    var result = await repository.recuperarMembros(uidProjeto);
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
