import 'package:estimasoft/features/notificacoes/domain/entity/notificacao_composicao.dart';

class NotificacaoComposicaoModel extends NotificacaoComposicao {
  NotificacaoComposicaoModel(
      {required String textoNotificacao, required String dataNotificacao})
      : super(
            textoNotificacao: textoNotificacao,
            dataNotificacao: dataNotificacao);

  Map<String, dynamic> toMap() {
    return {
      "DataNotificacao": dataNotificacao,
      "TextoNotificacao": textoNotificacao,
    };
  }

  factory NotificacaoComposicaoModel.fromMap(String texto, String data) {
    return NotificacaoComposicaoModel(
      dataNotificacao: data,
      textoNotificacao: texto,
    );
  }
}
