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

  List<ResultadoEntity> esforcosCompartilhados = [];
  List<ResultadoEntity> prazosCompartilhados = [];
  List<ResultadoEntity> equipesCompartilhados = [];
  List<ResultadoEntity> custosCompartilhados = [];

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
        await _resultadoRecuperarUsecase.enviarEstimativasPrazo(uidProjeto);

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
  }
}
