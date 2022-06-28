import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/arquivos_handler.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/enum_complexidade.dart';

class ComplexidadeBaixaHandlerSe extends ArquivosHandler {
  @override
  bool calcular(IndiceDetalhada detalhada) {
    if (detalhada.quantidadeTDs <= 19 && detalhada.quantidadeTrsEArs <= 1) {
      detalhada.complexidade = Complexidades.baixa;
      detalhada.pontoDeFuncao = 4;
    }

    if ((detalhada.quantidadeTDs <= 19) &&
        detalhada.quantidadeTrsEArs >= 2 &&
        detalhada.quantidadeTrsEArs <= 3) {
      detalhada.complexidade = Complexidades.baixa;
      detalhada.pontoDeFuncao = 4;
    }

    //invoca o próximo
    return verificaProximo(detalhada);
  }
}
