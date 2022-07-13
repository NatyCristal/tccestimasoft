import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';

class LoginUsuarioFirebaseModel extends UsuarioEntity {
  LoginUsuarioFirebaseModel(
      {required String nome,
      required String email,
      required String uid,
      required String urlFoto})
      : super(
          nome: nome,
          email: email,
          uid: uid,
          urlFoto: urlFoto,
        );

  Map<String, dynamic> toMap() {
    return {'email': email, 'nome': nome, "uid": uid, "urlFoto": urlFoto};
  }

  factory LoginUsuarioFirebaseModel.fromMap(Map<String, dynamic> map) {
    return LoginUsuarioFirebaseModel(
      email: map['email'],
      nome: map['nome'],
      uid: map['uid'],
      urlFoto: map['urlFoto'] ?? "",
    );
  }
}
