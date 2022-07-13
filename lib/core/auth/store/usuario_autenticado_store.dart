import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
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
  usuario(UsuarioEntity usuario) {
    email = usuario.email;
    nome = usuario.nome;
    urlFoto = usuario.urlFoto;
    uid = usuario.uid;
  }

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
