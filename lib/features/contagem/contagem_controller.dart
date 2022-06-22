import 'package:estimasoft/features/contagem/data/model/contagem_estimada_firebase_model.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_indicativa_firebase_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/contagem/domain/usecase/contagem_detalhada.dart';
import 'package:estimasoft/features/contagem/domain/usecase/contagem_estimada.dart';
import 'package:estimasoft/features/contagem/domain/usecase/contagem_indicativa.dart';

class ContagemController {
  final ContagemIndicativaUseCase _contagemIndicativaUseCase;
  final ContagemEstimadaUsecase _contagemEstimadaUseCase;
  final ContagemDetalhadaUsecase _contagemDetalhadaUsecase;

  ContagemIndicativaEntitie contagemIndicativa =
      ContagemIndicativaModelFirebase(aie: [], ali: [], totalPf: 0);

  ContagemEstimadaEntitie contagemEstimada =
      ContagemEstimadaFirebaseModel(ce: [], ee: [], se: [], totalPF: 0);
  ContagemDetalhadaEntitie contagemDetalhada = ContagemDetalhadaEntitie(
      funcaoDados: [],
      funcaoTransacional: [],
      totalPf: 0,
      totalFuncaoDados: 0,
      totalFuncaoTransacional: 0);

  ContagemController(this._contagemIndicativaUseCase,
      this._contagemEstimadaUseCase, this._contagemDetalhadaUsecase);

  Future salvarContagemIndicativa(List<String> alis, List<String> aies,
      int totalPF, String uidProjeto, String uidUsuario) async {
    var resultado = await _contagemIndicativaUseCase.salvarContagemIndicativa(
        alis, aies, uidProjeto, uidUsuario, totalPF);
    var retorno = "";
    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      retorno = "Contagem salva com sucesso!";
      contagemIndicativa = r;
    });
    return retorno;
  }

  Future recuperarContagemIndicativa(
      String uidProjeto, String uidUsuario) async {
    var resultado = await _contagemIndicativaUseCase
        .recuperarContagemIndicativa(uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      contagemIndicativa = r;
    });

    return contagemIndicativa;
  }

  Future recuperarContagemEstimada(String uidProjeto, String uidUsuario) async {
    var resultado = await _contagemEstimadaUseCase.recuperarContagemEstimada(
        uidProjeto, uidUsuario);

    //var retorno = "";

    resultado.fold((l) {
      //retorno = l.mensagem;
    }, (r) {
      contagemEstimada = r;
    });
    return contagemIndicativa;
  }

  Future salvarContagemEstimada(
      List<String> ce,
      List<String> ee,
      List<String> se,
      int totalPF,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await _contagemEstimadaUseCase.salvarContagemEstimada(
        ce, ee, se, uidProjeto, uidUsuario, totalPF);
    var retorno = "";
    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      contagemEstimada = r;
      retorno = "Contagem salva com sucesso!";
    });
    return retorno;
  }

  Future recuperarContagemDetalhada(
      String uidProjeto, String uidUsuario) async {
    var resultado = await _contagemDetalhadaUsecase.recuperarContagemDetalhada(
        uidProjeto, uidUsuario);

    // var retorno = "";

    resultado.fold((l) {
      /// retorno = l.mensagem;
    }, (r) {
      contagemDetalhada = r;
    });
    return contagemIndicativa;
  }

  Future salvarContagemDetalhada(
      ContagemDetalhadaEntitie contagemEstimadaEntitie,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await _contagemDetalhadaUsecase.salva(
        contagemEstimadaEntitie, uidProjeto, uidUsuario);

    var retorno = "";
    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      contagemDetalhada = r;
      retorno = "Contagem salva com sucesso!";
    });
    return retorno;
  }

  carregarContagens(String uidProjeto, String uidUsuario) async {
    contagemIndicativa =
        await recuperarContagemIndicativa(uidProjeto, uidUsuario);
    contagemIndicativa =
        await recuperarContagemEstimada(uidProjeto, uidUsuario);
    // contagemDetalhada =
    //   await recuperarContagemDetalhada(uidProjeto, uidUsuario);
  }
}
