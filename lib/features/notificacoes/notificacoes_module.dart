import 'package:estimasoft/features/notificacoes/data/infra/infra_notificacoes_firebase.dart';
import 'package:estimasoft/features/notificacoes/domain/usecase/notificacoes_usecase.dart';
import 'package:estimasoft/features/notificacoes/presentation/notificacoes_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasource/notificacoes_datasource_firebase.dart';

class NotificacoesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => NotificacoesDatasourceFirebase(), export: true),
        Bind.factory((i) => InfraFireabseNotificacoes(i()), export: true),
        Bind.factory((i) => NotificacoesUsecase(i()), export: true),
        Bind.lazySingleton(
            (i) => NotificacoesController(
                  i(),
                ),
            export: true),
      ];
}
