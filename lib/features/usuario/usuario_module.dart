import 'package:estimasoft/core/guards/autorizado_guard.dart';
import 'package:estimasoft/features/usuario/data/datasource/usuario_firebase_datasource.dart';
import 'package:estimasoft/features/usuario/presentation/pages/editar_dados_usuario.dart';
import 'package:estimasoft/features/usuario/presentation/usuario_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/infra/usuario_infra.dart';
import 'domain/usecase/usuario_alterar_email.dart';
import 'domain/usecase/usuario_alterar_nome.dart';
import 'domain/usecase/usuario_deslogar.dart';

class PerfilModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => PerfilFirebaseDataSource()),
        Bind.factory((i) => PerfilRepositoryData(i())),
        Bind.factory((i) => SairDaConta(i())),
        Bind.factory((i) => AlterarNomeUseCase(i())),
        Bind.factory((i) => AlterarEmailUsecase(i())),
        Bind.factory((i) => UsuarioController(i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            transition: TransitionType.rightToLeft,
            guards: [AutorizadoGuard()],
            child: (context, args) => const EditarDadosUsuario()),
      ];
}
