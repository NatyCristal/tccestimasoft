import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/notificacoes/domain/entity/notificacao_entity.dart';

import '../../../../core/errors/falha.dart';

abstract class NotificacoesRepositpry {
  Future<Either<Falha, NotificacaoEntity>> buscarNotificacoes();

  Future enviarNotificacoes(String texto, String uidUsuario);

  Future lerNotificacoes();

  Future enviarNotificacaoParaMembros(
      String texto, String uidProjeto, List<String> uidUsuarios);
}
