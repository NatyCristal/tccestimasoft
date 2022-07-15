import 'package:estimasoft/features/notificacoes/data/model/notificacao_composicao_model.dart';

class NotificacaoEntity {
  List<NotificacaoComposicaoModel> notificacoes;
  bool notificacaoLida;
  NotificacaoEntity({
    required this.notificacoes,
    required this.notificacaoLida,
  });
}
