import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';

import '../arquivos_handler.dart';
import '../enum_complexidade.dart';

class ComplexidadeMediaHandlerEe extends ArquivosHandler {
  @override
  bool calcular(IndiceDetalhada detalhada) {
    if ((detalhada.quantidadeTDs >= 16) && (detalhada.quantidadeTrsEArs <= 1)) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 4;
    }

    if ((detalhada.quantidadeTDs >= 5 && detalhada.quantidadeTDs <= 15) &&
        (detalhada.quantidadeTrsEArs == 2)) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 4;
    }

    if ((detalhada.quantidadeTDs <= 4) && detalhada.quantidadeTrsEArs >= 3) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 4;
    }

    return verificaProximo(detalhada);
  }
}
