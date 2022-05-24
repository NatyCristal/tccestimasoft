import 'package:estimasoft/features/contagem/data/infra/contagem_indicativa_infra.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_indicativa_firebase_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/contagem/domain/usecase/contagem_indicativa.dart';

class ContagemController {
  final ContagemIndicativaUseCase _contagemIndicativaUseCase;
  ContagemIndicativaEntitie contagemIndicativa =
      ContagemIndicativaModelFirebase(aie: [], ali: [], totalPf: 0);

  ContagemController(this._contagemIndicativaUseCase);

  Future salvarContagemIndicativa(List<String> alis, List<String> aies,
      int totalPF, String uidProjeto, String uidUsuario) async {
    var resultado = await _contagemIndicativaUseCase.salvarContagemIndicativa(
        alis, aies, uidProjeto, uidUsuario, totalPF);
    var retorno = "";
    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      retorno = "Função adicionada com sucesso!";
    });
    return retorno;
  }

  Future recuperarContagemIndicativa(
      String uidProjeto, String uidUsuario) async {
    var resultado;
    await Future.delayed(const Duration(seconds: 3)).then((_) async {
      resultado = await _contagemIndicativaUseCase.recuperarContagemIndicativa(
          uidProjeto, uidUsuario);
    });
    var retorno = "";

    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      contagemIndicativa = r;
    });
    return contagemIndicativa;
  }
}
