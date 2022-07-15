import '../../domain/entity/notificacao_entity.dart';
import 'notificacao_composicao_model.dart';

class NotificacaoModel extends NotificacaoEntity {
  NotificacaoModel(
      {required List<NotificacaoComposicaoModel> notificacoes,
      required bool notificacaoLida})
      : super(notificacoes: notificacoes, notificacaoLida: notificacaoLida);

  Map<String, dynamic> toMap() {
    return {
      "exibirNotificacao": notificacaoLida,
      "notificacoes": {
        for (var e in notificacoes)
          notificacoes.indexOf(e).toString(): e.toMap()
      },
    };
  }

  factory NotificacaoModel.fromMap(Map<String, dynamic> map) {
    List<NotificacaoComposicaoModel> notificacoes = [];
    Map<String, dynamic> teste = map['notificacoes'] ?? [];

    final sorted = Map.fromEntries(teste.entries.toList()
      ..sort((e1, e2) =>
          e1.value["DataNotificacao"].compareTo(e2.value["DataNotificacao"])));

    sorted.forEach((key, value) {
      notificacoes.add(NotificacaoComposicaoModel.fromMap(
          value["TextoNotificacao"], value["DataNotificacao"]));
    });

    return NotificacaoModel(
      notificacaoLida: map["exibirNotificacao"] ?? false,
      notificacoes: notificacoes,
    );
  }
}
