import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/arquivos_handler.dart';

import '../enum_complexidade.dart';

class ComplexidadeAltaHandlerAie extends ArquivosHandler {
  @override
  bool calcular(IndiceDetalhada detalhada) {
    if ((detalhada.quantidadeTrsEArs >= 6 && detalhada.quantidadeTDs >= 20)) {
      detalhada.complexidade = Complexidades.alta;
      detalhada.pontoDeFuncao = 10;
    }

    if ((detalhada.quantidadeTrsEArs >= 2 &&
            detalhada.quantidadeTrsEArs <= 6) &&
        detalhada.quantidadeTrsEArs >= 51) {
      detalhada.complexidade = Complexidades.alta;
      detalhada.pontoDeFuncao = 10;
    }
    return verificaProximo(detalhada);
  }
}
