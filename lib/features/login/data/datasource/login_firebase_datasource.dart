import 'package:estimasoft/features/login/data/models/login_usuario_firebase_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Login_datasource.dart';

class LoginFirebaseDatasource extends LoginDatasource {
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Future<LoginUsuarioFirebaseModel> cadastrarUsuario(
      String nome, String email, String senha) async {
    User? user;
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );

    await _auth.currentUser!.updateDisplayName(nome);
    user = _auth.currentUser;

    LoginUsuarioFirebaseModel usuario = LoginUsuarioFirebaseModel(
      email: user?.email ?? "",
      nome: user?.displayName ?? "",
      urlFoto: user?.photoURL ?? "",
      uid: user?.uid ?? "",
    );

    if (usuario.uid != "") {
      await firestore
          .collection("Usuarios")
          .doc(usuario.uid)
          .set(usuario.toMap());
    }
    return usuario;
  }

  @override
  Future<LoginUsuarioFirebaseModel> realizarLoginEmailSenha(
      String email, String senha) async {
    User? user;
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
    user = userCredential.user;

    LoginUsuarioFirebaseModel usuario = LoginUsuarioFirebaseModel(
      email: user?.email ?? "",
      nome: user?.displayName ?? "",
      urlFoto: user?.photoURL ?? "",
      uid: user?.uid ?? "",
    );

    return usuario;
  }

  @override
  Future<LoginUsuarioFirebaseModel> realizarLoginGoogle() async {
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      user = userCredential.user;
    }
    // if (googleSignInAccount == null) {
    //   return throw PlatformException(code: 'SIGN_IN_CANCELLED');
    // }

    LoginUsuarioFirebaseModel usuario = LoginUsuarioFirebaseModel(
      email: user?.email ?? "",
      nome: user?.displayName ?? "",
      urlFoto: user?.photoURL ?? "",
      uid: user?.uid ?? "",
    );

    if (usuario.uid != "") {
      await firestore
          .collection("Usuarios")
          .doc(usuario.uid)
          .set(usuario.toMap());
    }

    return usuario;
  }

  @override
  Future<String> recuperarSenha(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return "Link de recuperação foi enviado!";
  }
}
