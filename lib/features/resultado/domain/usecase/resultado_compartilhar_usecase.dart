import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/contagem/error/contagem_erro.dart';
import 'package:estimasoft/features/resultado/data/model/resultado_model.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:estimasoft/features/resultado/domain/repository/resultado_repository.dart';

class ResultadoCompartilharUsecase {
  final ResultadoCompartiharRepository repository;

  ResultadoCompartilharUsecase(this.repository);

  Future<Either<Falha, ResultadoEntity>> enviarContagemDetalhada(
      bool anonimamente,
      String texto,
      String uidProjeto,
      String uidUsuario) async {
    var resultado = await repository.enviarContagemDetaoyada(
        anonimamente, texto, uidProjeto, uidUsuario);

    var erro = "";
    ResultadoEntity retorno =
        ResultadoModel(anonimo: false, nome: "", valor: "", uidMembro: "");

    resultado.fold((l) {
      erro = l.mensagem;
    }, (r) {
      retorno = r;
    });

    if (resultado.isLeft()) {
      return Left(
        ContagemEstimadaErro(
            mensagem: "Não foi possível salvar a função. O erro foi: $erro"),
      );
    }

    return Right(retorno);
  }
}
