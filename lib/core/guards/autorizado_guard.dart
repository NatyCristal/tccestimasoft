import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../auth/usuario_autenticado.dart';

class AutorizadoGuard extends RouteGuard {
  AutorizadoGuard() : super(redirectTo: '/login/');

  @override
  bool canActivate(String path, ParallelRoute route) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final usuarioAutenticado = Modular.get<UsuarioAutenticado>();

    if (currentUser != null) {
      usuarioAutenticado.verificarUsuario(currentUser);
      return usuarioAutenticado.store.usuarioEhValido();
    }

    return false;
  }
}
