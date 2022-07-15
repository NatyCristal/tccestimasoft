import 'package:estimasoft/features/notificacoes/data/model/notificacao_composicao_model.dart';
import 'package:estimasoft/features/notificacoes/domain/entity/notificacao_composicao.dart';

class NotificacaoEntity {
  List<NotificacaoComposicaoModel> notificacoes;
  bool notificacaoLida;
  NotificacaoEntity({
    required this.notificacoes,
    required this.notificacaoLida,
  });
}
