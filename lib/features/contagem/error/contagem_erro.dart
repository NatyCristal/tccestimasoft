import 'package:estimasoft/core/errors/falha.dart';

class ContagemIndicativaErro extends Falha {
  ContagemIndicativaErro({required String mensagem})
      : super(mensagem: mensagem);
}

class ContagemEstimadaErro extends Falha {
  ContagemEstimadaErro({required String mensagem}) : super(mensagem: mensagem);
}
