import 'package:estimasoft/features/usuario/domain/usecase/usuario_deslogar.dart';

import '../domain/usecase/usuario_alterar_email.dart';
import '../domain/usecase/usuario_alterar_nome.dart';

class UsuarioController {
  final SairDaConta _sairDaConta;
  final AlterarNomeUseCase _alterarNomeUseCase;
  final AlterarEmailUsecase _alterarEmailUsecase;

  UsuarioController(
      this._sairDaConta, this._alterarNomeUseCase, this._alterarEmailUsecase);
}
