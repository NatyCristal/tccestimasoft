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

  List<ResultadoEntity> contagensDetalhadas = [];
  List<ResultadoEntity> contagensIndicativas = [];
  List<ResultadoEntity> contagensEstimadas = [];
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
      bool entrou = false;
      for (var element in contagensDetalhadas) {
        if (element.uidMembro == contagemDetalhada.uidUsuario &&
            element.nome == "Detalhada") {
          element.valor = r.valor;
          entrou = true;
        }
      }
      if (!entrou) {
        contagensDetalhadas.add(r);
      }
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  enviarContagemEstimada(
      bool anonimamente,
      ContagemEstimadaEntitie conagemEstimada,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await _resultadoCompartilharUsecase.enviarContagemEstimada(
        anonimamente, conagemEstimada, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      bool entrou = false;
      for (var element in contagensEstimadas) {
        if (element.uidMembro == conagemEstimada.uidUsuario &&
            element.nome == "Estimada") {
          element.valor = r.valor;
          entrou = true;
        }
      }
      if (!entrou) {
        contagensEstimadas.add(r);
      }
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
      bool entrou = false;
      for (var element in contagensIndicativas) {
        if (element.uidMembro == conagemIndicativa.uidUsuario &&
            element.nome == "Indicativa") {
          element.valor = r.valor;
          entrou = true;
        }
      }
      if (!entrou) {
        contagensIndicativas.add(r);
      }
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
      bool entrou = false;
      for (var element in esforcosCompartilhados) {
        if (element.uidMembro == esforcos.uidUsuario &&
            element.nome == esforcos.contagemPontoDeFuncao.split(" - ").first) {
          element.valor = r.valor;
          entrou = true;
        }
      }
      if (!entrou) {
        esforcosCompartilhados.add(r);
      }
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
      bool entrou = false;
      for (var element in custosCompartilhados) {
        if (element.uidMembro == custos.uidUsuario &&
            element.nome == custos.tipoContagem) {
          element.valor = r.valor;
          entrou = true;
        }
      }
      if (!entrou) {
        custosCompartilhados.add(r);
      }
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
      bool entrou = false;
      for (var element in prazosCompartilhados) {
        if (element.uidMembro == prazos.uidUsuario &&
            element.nome == prazos.contagemPontoDeFuncao.split(" - ").first) {
          element.valor = r.valor;
          entrou = true;
        }
      }
      if (!entrou) {
        prazosCompartilhados.add(r);
      }
    });

    if (resultado.isRight()) {
      return resultado;
    }
  }

  enviarEstimativaEquipe(bool anonimamente, EquipeEntity equipe,
      String uidProjeto, String uidUsuario) async {
    var resultado = await _resultadoCompartilharUsecase.enviarEstimativasEquipe(
        anonimamente, equipe, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      bool entrou = false;
      for (var element in equipesCompartilhados) {
        if (element.uidMembro == equipe.uidUsuario &&
            element.nome == equipe.esforco.split(" - ").last) {
          element.valor = r.valor;
          entrou = true;
        }
      }
      if (!entrou) {
        equipesCompartilhados.add(r);
      }
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

    var resultadoContagens = await _resultadoRecuperarUsecase
        .recuperarContagensIndicativas(uidProjeto);

    resultadoContagens.fold((l) => null, (r) {
      contagensIndicativas = r;
    });

    var resultadoEstimada =
        await _resultadoRecuperarUsecase.recuperarContagensEstimada(uidProjeto);

    resultadoEstimada.fold((l) => null, (r) {
      contagensEstimadas = r;
    });

    var resultadoDetalhada = await _resultadoRecuperarUsecase
        .recuperarContagensDetalhadas(uidProjeto);

    resultadoDetalhada.fold((l) => null, (r) {
      contagensDetalhadas = r;
    });
  }
}
