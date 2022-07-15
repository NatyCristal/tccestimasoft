import 'package:estimasoft/features/notificacoes/data/model/notificacao_model.dart';

abstract class NotificacoesDatasource {
  Future enviarNotivicacao(String textoNotificacao, String uidUsuario);
  Future<NotificacaoModel> buscarNoticaoes();
  Future lerNotificacao();
  Future enviarNotificacaoParaMembros(
      String texto, String uidProjeto, List<String> uidUsuarios);
}
