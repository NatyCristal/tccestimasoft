import 'package:estimasoft/features/login/data/infra/login_firebase_infra.dart';
import 'package:estimasoft/features/login/domain/usecase/entrar_google_usecase.dart';
import 'package:estimasoft/features/login/domain/usecase/entrar_usecase.dart';
import 'package:estimasoft/features/login/domain/usecase/redefinir_senha.dart';
import 'package:estimasoft/features/login/domain/usecase/registrar_usecase.dart';
import 'package:estimasoft/features/login/presentation/pages/login_page.dart';
import 'package:estimasoft/features/login/presentation/pages/login_redefinir_senha_page.dart';
import 'package:estimasoft/features/login/presentation/pages/login_registrar_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'data/datasource/login_firebase_datasource.dart';
import 'login_controller.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginFirebaseDatasource()),
        Bind.factory((i) => LoginInfraFirebase(i())),
        Bind.factory((i) => EntrarGoogleUsecase(i())),
        Bind.factory((i) => EntrarLoginUsecase(i())),
        Bind.factory((i) => RedefinirSenhaUsecase(i())),
        Bind.factory((i) => RegistrarUsuarioUsecase(i())),
        Bind.factory((i) => LoginController(i(), i(), i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => LoginPrincipalPage()),
        ChildRoute('/registrar', child: (context, args) => LoginRegistrar()),
        ChildRoute('/redefinir-senha',
            child: (context, args) => LoginRedefinirSenha()),
      ];
}
