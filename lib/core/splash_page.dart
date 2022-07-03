import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'auth/usuario_autenticado.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      final usuarioAutenticado = Modular.get<UsuarioAutenticado>();
      if (usuarioAutenticado.store.uid == "") {
        Modular.to.pushReplacementNamed('/login/');
      } else {
        Modular.to.pushReplacementNamed('/projeto/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
            width: 200, height: 200, child: Lottie.asset('assets/splash.json')),
      ),
    ));
  }
}
