import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_esforco_usecase.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_prazo_usecase.dart';

class EstimativasController {
  final EstimativaEsforcoUsecase _estimativaEsforco;
  final EstimativaPrazoUsecase _estimativaPrazoUsecase;

  List<EsforcoEntity> esforcos = [];
  List<PrazoEntity> prazos = [];
  EstimativasController(this._estimativaEsforco, this._estimativaPrazoUsecase);

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

  carregarEstimativas(String uidProjeto, uidUsuario) async {
    esforcos = await recuperarEsforcos(uidProjeto, uidUsuario);
    prazos = await recuperarPrazos(uidProjeto, uidUsuario);
  }
}
