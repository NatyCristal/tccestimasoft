import 'package:estimasoft/core/auth/store/usuario_autenticado_store.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsuarioAutenticado {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final UsuarioAutenticadoStore store = UsuarioAutenticadoStore();

  UsuarioAutenticado() {
    if (currentUser != null) {
      store.pegarUsuario(currentUser!);
    } else {
      store.limparDados();
    }
  }

  limparDados() {
    store.limparDados();
  }

  verificarUsuario(User usuario) async {
    store.pegarUsuario(usuario);
  }
}
