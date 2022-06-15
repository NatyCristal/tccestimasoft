import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_esforco_usecase.dart';

class EstimativasController {
  final EstimativaEsforcoUsecase _estimativaEsforco;

  List<EsforcoEntity> esforcos = [];
  EstimativasController(this._estimativaEsforco);

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

  carregarEstimativas(String uidProjeto, uidUsuario) async {
    esforcos = await recuperarEsforcos(uidProjeto, uidUsuario);
  }
}
