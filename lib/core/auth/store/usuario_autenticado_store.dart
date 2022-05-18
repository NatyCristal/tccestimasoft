import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'usuario_autenticado_store.g.dart';

class UsuarioAutenticadoStore = UsuarioAutenticadoStoreBase
    with _$UsuarioAutenticadoStore;

abstract class UsuarioAutenticadoStoreBase with Store {
  @observable
  String email = "";
  @observable
  String nome = "";
  @observable
  String urlFoto = "";
  @observable
  String uid = "";

  @action
  limparDados() {
    email = "";
    nome = "";
    urlFoto = "";
    uid = "";
  }

  @action
  pegarUsuario(User usuario) {
    email = usuario.email ?? "";
    nome = usuario.displayName ?? "";
    urlFoto = usuario.photoURL ?? "";
    uid = usuario.uid;
  }

  @action
  usuarioEhValido() {
    return uid != "" && nome != "" ? true : false;
  }
}
