import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/arquivos_handler.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/enum_complexidade.dart';

class ComplexidadeBaixaHandlerAli extends ArquivosHandler {
  @override
  bool calcular(IndiceDetalhada detalhada) {
    if (detalhada.quantidadeTDs <= 50 && detalhada.quantidadeTrsEArs <= 1) {
      detalhada.complexidade = Complexidades.baixa;
      detalhada.pontoDeFuncao = 7;
    }

    if ((detalhada.quantidadeTrsEArs >= 2 && detalhada.quantidadeTDs <= 5) &&
        detalhada.quantidadeTDs >= 1 &&
        detalhada.quantidadeTDs <= 19) {
      detalhada.complexidade = Complexidades.baixa;
      detalhada.pontoDeFuncao = 7;
    }

    //invoca o próximo
    return verificaProximo(detalhada);
  }
}
