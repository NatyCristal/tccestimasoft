import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';

abstract class ArquivosHandler {
  ArquivosHandler? _proximo;

  ArquivosHandler();

  set proximo(ArquivosHandler proximo) => _proximo = proximo;

  ArquivosHandler ligarA(ArquivosHandler proximo) {
    _proximo = proximo;
    return proximo;
  }

  bool verificaProximo(IndiceDetalhada detalhada) {
    if (_proximo == null) {
      return true;
    }
    return _proximo!.calcular(detalhada);
  }

  bool calcular(IndiceDetalhada detalhada);
}
