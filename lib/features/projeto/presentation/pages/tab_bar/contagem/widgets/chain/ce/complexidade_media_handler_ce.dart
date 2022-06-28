import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';

import '../arquivos_handler.dart';
import '../enum_complexidade.dart';

class ComplexidadeMediaHandlerCe extends ArquivosHandler {
  @override
  bool calcular(IndiceDetalhada detalhada) {
    if ((detalhada.quantidadeTDs >= 20) && (detalhada.quantidadeTrsEArs <= 1)) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 4;
    }

    if ((detalhada.quantidadeTDs >= 6 && detalhada.quantidadeTDs <= 19) &&
        (detalhada.quantidadeTrsEArs >= 2 &&
            detalhada.quantidadeTrsEArs <= 3)) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 4;
    }

    if ((detalhada.quantidadeTDs <= 5) && detalhada.quantidadeTrsEArs >= 4) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 4;
    }

    return verificaProximo(detalhada);
  }
}
