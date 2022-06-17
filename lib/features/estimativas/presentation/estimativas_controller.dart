import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_custo_usecase.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_equipe_usecase.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_esforco_usecase.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_prazo_usecase.dart';

class EstimativasController {
  final EstimativaEsforcoUsecase _estimativaEsforco;
  final EstimativaPrazoUsecase _estimativaPrazoUsecase;
  final EquipeUsecase _equipeUsecase;
  final CustoUsecase _custoUsecase;

  List<EquipeEntity> equipe = [];
  List<EsforcoEntity> esforcos = [];
  List<PrazoEntity> prazos = [];
  List<CustoEntity> custos = [];
  EstimativasController(this._estimativaEsforco, this._estimativaPrazoUsecase,
      this._equipeUsecase, this._custoUsecase);

  salvarEsforco(EsforcoEntity esforco, String uidProjeto, String uidUsuario,
      String tipoContagem) async {
    var resultado = await _estimativaEsforco.salvarEstimativaEsforco(
        esforco, uidProjeto, uidUsuario, tipoContagem);
    String retorno = "";

    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      retorno = "Esforço salvo!";
    });

    return retorno;
  }

  recuperarEsforcos(String uidProjeto, String uidUsuario) async {
    var retorno = await _estimativaEsforco.recuperarEstimativaEsforco(
      uidProjeto,
      uidUsuario,
    );

    retorno.fold((l) {}, (r) {
      esforcos = r;
    });

    return esforcos;
  }

  salvarPrazo(PrazoEntity prazoEntity, String uidProjeto, String uidUsuario,
      String tipoContagem) async {
    var resultado = await _estimativaPrazoUsecase.salvarEstimativaPrazo(
        prazoEntity, uidProjeto, uidUsuario, tipoContagem);
    String retorno = "";

    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      retorno = "Prazo salvo!";
    });

    return retorno;
  }

  recuperarPrazos(String uidProjeto, String uidUsuario) async {
    var retorno = await _estimativaPrazoUsecase.recuperarEstimativaPrazo(
      uidProjeto,
      uidUsuario,
    );

    retorno.fold((l) {}, (r) {
      prazos = r;
    });

    return prazos;
  }

  salvarEquipe(EquipeEntity equipeEntity, String uidProjeto, String uidUsuario,
      String tipoContagem) async {
    var resultado = await _equipeUsecase.salvarEstimativaEquipe(
        equipeEntity, uidProjeto, uidUsuario, tipoContagem);
    String retorno = "";

    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      retorno = "Equipe salva!";
    });

    return retorno;
  }

  recuperarEquipe(String uidProjeto, String uidUsuario) async {
    var retorno =
        await _equipeUsecase.recuperarEstimativaEquipe(uidProjeto, uidUsuario);

    retorno.fold((l) {}, (r) {
      equipe = r;
    });

    return equipe;
  }

  salvarCusto(CustoEntity custoEntity, String uidProjeto, String uidUsuario,
      String tipoContagem) async {
    var resultado = await _custoUsecase.salvarEstimativaCusto(
        custoEntity, uidProjeto, uidUsuario, tipoContagem);
    String retorno = "";

    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      retorno = "Custo salvo!";
    });

    return retorno;
  }

  recuperarCusto(String uidProjeto, String uidUsuario) async {
    var retorno =
        await _custoUsecase.recuperarEstimativaCusto(uidProjeto, uidUsuario);

    retorno.fold((l) {}, (r) {
      custos = r;
    });

    return custos;
  }

  carregarEstimativas(String uidProjeto, uidUsuario) async {
    esforcos = await recuperarEsforcos(uidProjeto, uidUsuario);
    prazos = await recuperarPrazos(uidProjeto, uidUsuario);
    equipe = await recuperarEquipe(uidProjeto, uidUsuario);
    custos = await recuperarCusto(uidProjeto, uidUsuario);
  }
}
