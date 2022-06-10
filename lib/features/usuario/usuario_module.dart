import 'package:estimasoft/features/usuario/data/datasource/usuario_firebase_datasource.dart';
import 'package:estimasoft/features/usuario/domain/usecase/usuario_logado.dart';
import 'package:estimasoft/features/usuario/presentation/pages/editar_dados_usuario.dart';
import 'package:estimasoft/features/usuario/presentation/usuario_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/guards/autorizado_guard.dart';
import 'data/infra/usuario_infra.dart';
import 'domain/usecase/usuario_alterar_email.dart';
import 'domain/usecase/usuario_alterar_nome.dart';
import 'domain/usecase/usuario_deslogar.dart';

class UsuarioModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => UsuarioFirebaseDataSource(), export: true),
        Bind.factory((i) => UsuarioRepositoryData(i()), export: true),
        Bind.factory((i) => UsuarioLogadoUsecase(i()), export: true),
        Bind.factory((i) => SairDaConta(i()), export: true),
        Bind.factory((i) => AlterarNomeUseCase(i()), export: true),
        Bind.factory((i) => AlterarEmailUsecase(i()), export: true),
        Bind.singleton((i) => UsuarioController(i(), i(), i(), i()),
            export: true)
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            transition: TransitionType.rightToLeft,
            guards: [AutorizadoGuard()],
            child: (context, args) => EditarDadosUsuario()),
      ];
}
