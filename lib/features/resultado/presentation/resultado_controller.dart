import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:estimasoft/features/resultado/domain/usecase/resultado_compartilhar_usecase.dart';
import 'package:estimasoft/features/resultado/domain/usecase/resultado_recuperar_usecase.dart';

class ResultadoController {
  final ResultadoRecuperarUsecase _resultadoRecuperarUsecase;
  final ResultadoCompartilharUsecase _resultadoCompartilharUsecase;

  ResultadoController(
      this._resultadoCompartilharUsecase, this._resultadoRecuperarUsecase);

  List<ResultadoEntity> resultadosCompartilhados = [];

  enviarContagemDetalhada(bool anonimamente, String texto, String uidProjeto,
      String uidUsuario) async {
    resultadosCompartilhados = [];
    var resultado = await _resultadoCompartilharUsecase.enviarContagemDetalhada(
        anonimamente, texto, uidProjeto, uidUsuario);

    resultado.fold((l) {}, (r) {
      resultadosCompartilhados.add(r);
    });

    return resultadosCompartilhados;
  }

  recuperarResultados(String uidProjeto) async {
    var resultadoDetalhada = await _resultadoRecuperarUsecase
        .recuperarContagensDetalhadas(uidProjeto);

    resultadoDetalhada.fold((l) => null, (r) {
      resultadosCompartilhados = r;
    });

    return resultadosCompartilhados;
  }
}
