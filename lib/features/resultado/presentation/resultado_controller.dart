import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:estimasoft/features/resultado/domain/usecase/resultado_compartilhar_usecase.dart';
import 'package:estimasoft/features/resultado/domain/usecase/resultado_recuperar_usecase.dart';

class ResultadoController {
  final ResultadoRecuperarUsecase _resultadoRecuperarUsecase;
  final ResultadoCompartilharUsecase _resultadoCompartilharUsecase;

  ResultadoController(
      this._resultadoCompartilharUsecase, this._resultadoRecuperarUsecase);

  List<ResultadoEntity> contagens = [];
  List<ResultadoEntity> esforcosCompartilhados = [];
  List<ResultadoEntity> prazosCompartilhados = [];
  List<ResultadoEntity> equipesCompartilhados = [];
  List<ResultadoEntity> custosCompartilhados = [];

  enviarContagemDetalhada(
      bool anonimamente,
      ContagemDetalhadaEntitie contagemDetalhada,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await _resultadoCompartilharUsecase.enviarContagemDetalhada(
        anonimamente, contagemDetalhada, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      contagens.add(r);
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  enviarContagemEstimada(
      bool anonimamente,
      ContagemEstimadaEntitie conagemIndicativa,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await _resultadoCompartilharUsecase.enviarContagemEstimada(
        anonimamente, conagemIndicativa, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      contagens.add(r);
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  enviaContagemIndicativas(
      bool anonimamente,
      ContagemIndicativaEntitie conagemIndicativa,
      String uidProjeto,
      String uidUsuario) async {
    var resultado =
        await _resultadoCompartilharUsecase.enviarContagemIndicativa(
            anonimamente, conagemIndicativa, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      contagens.add(r);
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  enviarEstimativasEsforco(bool anonimamente, EsforcoEntity esforcos,
      String uidProjeto, String uidUsuario) async {
    var resultado =
        await _resultadoCompartilharUsecase.enviarEstimativasEsforco(
            anonimamente, esforcos, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      esforcosCompartilhados.add(r);
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  enviarEstimativaCusto(bool anonimamente, CustoEntity custos,
      String uidProjeto, String uidUsuario) async {
    var resultado = await _resultadoCompartilharUsecase.enviarEstimativasCusto(
        anonimamente, custos, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      custosCompartilhados.add(r);
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  enviarEstimativaPrazo(bool anonimamente, PrazoEntity prazos,
      String uidProjeto, String uidUsuario) async {
    var resultado = await _resultadoCompartilharUsecase.enviarEstimativasPrazo(
        anonimamente, prazos, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      prazosCompartilhados.add(r);
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  enviarEstimativaEquipe(bool anonimamente, EquipeEntity custos,
      String uidProjeto, String uidUsuario) async {
    var resultado = await _resultadoCompartilharUsecase.enviarEstimativasEquipe(
        anonimamente, custos, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      equipesCompartilhados.add(r);
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  recuperarResultados(String uidProjeto) async {
    var resultadoEsforco =
        await _resultadoRecuperarUsecase.enviarEstimativasEsforco(uidProjeto);

    resultadoEsforco.fold((l) => null, (r) {
      esforcosCompartilhados = r;
    });

    var resultadoPrazo =
        await _resultadoRecuperarUsecase.recuperarEstimativasPrazo(uidProjeto);

    resultadoPrazo.fold((l) => null, (r) {
      prazosCompartilhados = r;
    });

    var resultadoEquipe =
        await _resultadoRecuperarUsecase.recuperarEstimativasEquipe(uidProjeto);

    resultadoEquipe.fold((l) => null, (r) {
      equipesCompartilhados = r;
    });

    var resultadoCusto =
        await _resultadoRecuperarUsecase.recuperarEstimativasCusto(uidProjeto);

    resultadoCusto.fold((l) => null, (r) {
      custosCompartilhados = r;
    });

    var resultadoContagens =
        await _resultadoRecuperarUsecase.recuperarContagens(uidProjeto);

    resultadoContagens.fold((l) => null, (r) {
      contagens = r;
    });
  }
}
