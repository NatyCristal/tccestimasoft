import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/aie/complexidade_baixa_handler_aie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/ali/complexidade_baixa_handler_ali.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/arquivos_handler.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/ce/complexidade_baixa_handler_ce.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/ee/complexidade_alta_handler_ee.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/ee/complexidade_baixa_handler_ee.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/ee/complexidade_media_handler_ee.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/se/complexidade_alta_handler_se.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/se/complexidade_baixa_handler_se.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/se/complexidade_media_handler_se.dart';

import 'aie/complexidade_alta_handler_aie.dart';
import 'aie/complexidade_media_handler_aie.dart';
import 'ali/complexidade_alta_handler_ali.dart';
import 'ali/complexidade_media_handler_ali.dart';
import 'ce/complexidade_alta_handler_ce.dart';
import 'ce/complexidade_media_handler_ce.dart';

class IndiceChain {
  static ArquivosHandler getChainAie() {
    ArquivosHandler processadoraAie = ComplexidadeBaixaHandlerAie()
      ..ligarA(ComplexidadeMediaHandlerAie())
          .ligarA(ComplexidadeAltaHandlerAie());

    return processadoraAie;
  }

  static ArquivosHandler getChainAli() {
    ArquivosHandler processadoraAli = ComplexidadeBaixaHandlerAli()
      ..ligarA(ComplexidadeMediaHandlerAli())
          .ligarA(ComplexidadeAltaHandlerAli());

    return processadoraAli;
  }

  static ArquivosHandler getChainSe() {
    ArquivosHandler processadoraSe = ComplexidadeBaixaHandlerSe()
      ..ligarA(ComplexidadeMediaHandlerSe())
          .ligarA(ComplexidadeAltaHandlerSe());

    return processadoraSe;
  }

  static ArquivosHandler getChainCe() {
    ArquivosHandler processadoraCe = ComplexidadeBaixaHandlerCe()
      ..ligarA(ComplexidadeMediaHandlerCe())
          .ligarA(ComplexidadeAltaHandlerCe());

    return processadoraCe;
  }

  static ArquivosHandler getChainEE() {
    ArquivosHandler processadoraEe = ComplexidadeBaixaHandlerEe()
      ..ligarA(ComplexidadeMediaHandlerEe())
          .ligarA(ComplexidadeAltaHandlerEe());

    return processadoraEe;
  }
}
