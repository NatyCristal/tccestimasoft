import '../models/login_usuario_firebase_model.dart';

abstract class LoginDatasource {
  Future<LoginUsuarioFirebaseModel> realizarLoginEmailSenha(
      String email, String senha);

  Future<LoginUsuarioFirebaseModel> cadastrarUsuario(
      String nome, String email, String senha);

  Future<String> recuperarSenha(String email);

  Future<LoginUsuarioFirebaseModel> realizarLoginGoogle();
}
