import 'package:estimasoft/features/notificacoes/data/model/notificacao_model.dart';

abstract class NotificacoesDatasource {
  Future enviarNotivicacao(String textoNotificacao);
  Future<NotificacaoModel> buscarNoticaoes();
  Future lerNotificacao();
}
