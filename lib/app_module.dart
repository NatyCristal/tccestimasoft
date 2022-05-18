import 'package:estimasoft/core/splash_page.dart';
import 'package:estimasoft/features/login/login_module.dart';
import 'package:estimasoft/features/projeto/projeto_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'core/auth/usuario_autenticado.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<UsuarioAutenticado>((i) => Get.put(UsuarioAutenticado()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            transition: TransitionType.leftToRight,
            child: (context, args) => const SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/projeto', module: ProjetoModule()),
      ];
}
