import 'package:estimasoft/core/guards/autorizado_guard.dart';
import 'package:estimasoft/features/projeto/data/datasource/projeto_firebase_datasource.dart';
import 'package:estimasoft/features/projeto/domain/usecase/recuperar_membros_usecase.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/projeto_bottom_navigator_bar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/projetos_principal_page.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../usuario/data/datasource/usuario_firebase_datasource.dart';
import 'data/infra/projeto_firebase_infra.dart';
import 'domain/usecase/criar_projeto_usecase.dart';
import 'domain/usecase/recuperar_projetos_usecase.dart';

class ProjetoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => PerfilFirebaseDataSource()),
        Bind.factory((i) => ProjetoFirebaseDatasource(i())),
        Bind.factory((i) => ProjetoFirebaseInfra(i())),
        Bind.factory((i) => RecuperarMembrosUsecase(i())),
        Bind.factory((i) => CriarProjetoUsecase(i())),
        Bind.factory((i) => RecuperarProjetosUsecase(i())),
        Bind.lazySingleton((i) => ProjetoController(i(), i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => ProjetosPrincipalPage(),
            guards: [AutorizadoGuard()]),
        ChildRoute('/projeto-informacao',
            child: (context, args) => ProjetoMenuPage(
                  projeto: args.data,
                ),
            guards: [AutorizadoGuard()]),
      ];
}
