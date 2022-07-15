import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/notificacoes/domain/entity/notificacao_entity.dart';
import 'package:estimasoft/features/notificacoes/domain/repository/notificacoes_repository.dart';
import 'package:estimasoft/features/notificacoes/error/erro_notificacoes.dart';

import '../../../../core/errors/falha.dart';

class NotificacoesUsecase {
  final NotificacoesRepositpry repository;

  NotificacoesUsecase(this.repository);

  Future<Either<Falha, NotificacaoEntity>> buscarNotificacao() async {
    var result = await repository.buscarNotificacoes();

    if (result.isLeft()) {
      return Left(ErroNotificacoes(mensagem: "Algo de errado aconteceu!"));
    }

    return result;
  }

  Future<Either<Falha, NotificacaoEntity>> gerarNotificacao(
      String texto, String uidUsuario) async {
    var result = await repository.enviarNotificacoes(texto, uidUsuario);

    if (result.isLeft()) {
      return Left(ErroNotificacoes(mensagem: "Algo de errado aconteceu!"));
    }

    return result;
  }

  Future lerNotificacoes() async {
    await repository.lerNotificacoes();
  }

  Future enviarNotificacaoMembros(
      String texto, String uidProjeto, List<String> uidUsuarios) async {
    await repository.enviarNotificacaoParaMembros(
        texto, uidProjeto, uidUsuarios);
  }
}
