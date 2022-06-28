import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/arquivos_handler.dart';

import '../enum_complexidade.dart';

class ComplexidadeAltaHandlerCe extends ArquivosHandler {
  @override
  bool calcular(IndiceDetalhada detalhada) {
    if ((detalhada.quantidadeTDs >= 20 &&
        (detalhada.quantidadeTrsEArs <= 3 &&
            detalhada.quantidadeTrsEArs >= 2))) {
      detalhada.complexidade = Complexidades.alta;
      detalhada.pontoDeFuncao = 6;
    }

    if (detalhada.quantidadeTrsEArs >= 4 && detalhada.quantidadeTDs >= 6) {
      detalhada.complexidade = Complexidades.alta;
      detalhada.pontoDeFuncao = 6;
    }
    return verificaProximo(detalhada);
  }
}
