import 'package:estimasoft/features/login/domain/usecase/entrar_google_usecase.dart';
import 'package:estimasoft/features/login/domain/usecase/entrar_usecase.dart';
import 'package:estimasoft/features/login/domain/usecase/redefinir_senha.dart';
import 'package:estimasoft/features/login/domain/usecase/registrar_usecase.dart';
import 'package:estimasoft/features/login/presentation/stores/store_login.dart';
import 'package:estimasoft/features/login/routes/login_rotas.dart';

class LoginController {
  final RegistrarUsuarioUsecase _registrarUsuarioUsecase;
  final RedefinirSenhaUsecase _redefinirSenhaUsecase;
  final EntrarLoginUsecase _entrarLoginUsecase;
  final EntrarGoogleUsecase _entrarGoogleUsecase;

  StoreLogin store = StoreLogin();

  LoginController(this._entrarLoginUsecase, this._entrarGoogleUsecase,
      this._redefinirSenhaUsecase, this._registrarUsuarioUsecase);

  redefinirSenha(String email) async {
    var result = await _redefinirSenhaUsecase.recuperarSenha(email);

    String textoRetorno = "";
    result.fold((l) {
      textoRetorno = l.mensagem;
    }, (r) {
      textoRetorno =
          "Email enviado com sucesso! Verifique sua caixa de entrada ou spam";
      LoginRotas.irParaLogin();
    });

    return textoRetorno;
  }

  registrarUsuario(
    String nome,
    String email,
    String senha,
  ) async {
    var result =
        await _registrarUsuarioUsecase.cadastrarUsuario(nome, email, senha);

    String textoRetorno = "";
    result.fold((l) {
      textoRetorno = l.mensagem;
    }, (r) {
      textoRetorno = "Usuário cadastrado com sucesso!";
      LoginRotas.irParaLogin();
    });

    return textoRetorno;
  }

  entrar(String email, String senha) async {
    var resultado = await _entrarLoginUsecase.entrarLogin(email, senha);

    String textoRetorno = "";

    resultado.fold((l) {
      textoRetorno = l.mensagem;
    }, (r) {
      textoRetorno = "Login realizado com sucesso!";
      LoginRotas.irParaHomePage();
    });

    return textoRetorno;
  }

  entrarGoogle() async {
    var result = await _entrarGoogleUsecase.realizarLoginGoogle();

    String textoRetorno = "";

    result.fold((l) {
      textoRetorno = l.mensagem;
      return textoRetorno;
    }, (r) {
      textoRetorno = "Login realizado com sucesso!";
      LoginRotas.irParaHomePage();
    });

    return textoRetorno;
  }
}
