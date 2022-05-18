import '../../../core/errors/falha.dart';

class ErroUsuario extends Falha {
  ErroUsuario({required String mensagem}) : super(mensagem: mensagem);
}
