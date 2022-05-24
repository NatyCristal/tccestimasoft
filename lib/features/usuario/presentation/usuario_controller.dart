import 'package:estimasoft/core/auth/store/usuario_autenticado_store.dart';
import 'package:estimasoft/features/usuario/domain/usecase/usuario_deslogar.dart';
import 'package:estimasoft/features/usuario/domain/usecase/usuario_logado.dart';
import 'package:estimasoft/features/usuario/routes/usuario_rotas.dart';
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

    String textoErro = "";
    result.fold(
        (l) => {textoErro = l.mensagem},
        (r) => {
              textoErro = "Usuario deslogado",
              UsuarioRotas.irParaLogin(),
            });

    return textoErro;
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
