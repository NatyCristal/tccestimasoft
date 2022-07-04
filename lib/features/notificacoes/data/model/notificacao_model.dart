import 'package:estimasoft/features/notificacoes/domain/entity/notificacao_entity.dart';

class NotificacaoModel extends NotificacaoEntity {
  NotificacaoModel(
      {required List<String> notificacoes, required bool notificacaoLida})
      : super(notificacoes: notificacoes, notificacaoLida: notificacaoLida);

  Map<String, dynamic> toMap() {
    return {
      "lida": notificacaoLida,
      "notificacoes": notificacoes.toList(),
    };
  }

  factory NotificacaoModel.fromMap(Map<String, dynamic> map) {
    return NotificacaoModel(
      notificacaoLida: map["lida"] ?? false,
      notificacoes: map['notificacoes'] ?? [],
    );
  }
}
