import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import '../arquivos_handler.dart';
import '../enum_complexidade.dart';

class ComplexidadeMediaHandlerAli extends ArquivosHandler {
  @override
  bool calcular(IndiceDetalhada detalhada) {
    if ((detalhada.quantidadeTrsEArs <= 1) && (detalhada.quantidadeTDs >= 51)) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 10;
    }

    if ((detalhada.quantidadeTrsEArs >= 2 &&
            detalhada.quantidadeTrsEArs <= 5) &&
        (detalhada.quantidadeTDs >= 20 && detalhada.quantidadeTDs <= 50)) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 10;
    }

    if ((detalhada.quantidadeTrsEArs >= 6) &&
        (detalhada.quantidadeTDs >= 1 && detalhada.quantidadeTDs <= 19)) {
      detalhada.complexidade = Complexidades.media;
      detalhada.pontoDeFuncao = 10;
    }

    return verificaProximo(detalhada);
  }
}
