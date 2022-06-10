import 'package:estimasoft/core/auth/store/usuario_autenticado_store.dart';
import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/features/usuario/domain/usecase/usuario_deslogar.dart';
import 'package:estimasoft/features/usuario/domain/usecase/usuario_logado.dart';
import 'package:estimasoft/features/usuario/routes/usuario_rotas.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../domain/usecase/usuario_alterar_email.dart';
import '../domain/usecase/usuario_alterar_nome.dart';

class UsuarioController {
  final UsuarioAutenticadoStore storeAutenticado = UsuarioAutenticadoStore();
  final UsuarioLogadoUsecase _usuarioLogadoUsecase;
  final SairDaConta _sairDaConta;
  final AlterarNomeUseCase _alterarNomeUseCase;
  final AlterarEmailUsecase _alterarEmailUsecase;

  UsuarioController(this._sairDaConta, this._alterarNomeUseCase,
      this._alterarEmailUsecase, this._usuarioLogadoUsecase);

  deslogar() async {
    var result = await _sairDaConta.sairDaConta();
    UsuarioAutenticado usuarioAutenticado = Modular.get<UsuarioAutenticado>();
    String textoErro = "";
    result.fold(
        (l) => {textoErro = l.mensagem},
        (r) => {
              textoErro = "Usuario deslogado",
              usuarioAutenticado.limparDados(),
              UsuarioRotas.irParaLogin(),
            });

    return textoErro;
  }

  alterarNome(
    String nome,
  ) async {
    var result = await _alterarNomeUseCase.alterarNome(nome);
    String textoRetorno = "";

    result.fold((l) {
      textoRetorno = l.mensagem;
    }, (r) {
      Modular.get<UsuarioAutenticado>().store.nome = nome;
      textoRetorno = r;
    });

    return textoRetorno;
  }

  alterarEmail(String email) async {
    var result = await _alterarEmailUsecase.alterarEmail(email);
    String textoRetorno = "";
    result.fold((l) {
      textoRetorno = l.mensagem;
    }, (r) {
      Modular.get<UsuarioAutenticado>().store.email = email;
      textoRetorno = r;
    });

    return textoRetorno;
  }

  usuarioAutenticado() async {
    var resultado = await _usuarioLogadoUsecase.verificarUsuario();

    bool retorno = false;
    resultado.fold(
        (l) => {
              retorno = false,
            },
        (r) => {
              storeAutenticado.usuario(r),
              retorno = true,
            });
    return retorno;
  }
}
