import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:estimasoft/features/projeto/domain/repository/projeto_repository.dart';
import 'package:estimasoft/features/projeto/error/projeto_erro.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ArquivoUsecase {
  final ProjetoRepository repository;

  ArquivoUsecase(this.repository);

  Future<Either<Falha, TaskSnapshot>> uparArquivos(
      String uidProjeto, File file) async {
    var result = await repository.uparArquivos(uidProjeto, file);
    var erro = "";

    result.fold((l) {
      erro = l.mensagem;
    }, (r) {});

    if (result.isLeft()) {
      switch (erro) {
        default:
          return Left(
            ErroProjeto(mensagem: "Algo de errado aconteceu!"),
          );
      }
    }

    return result;
  }

  Future<Either<Falha, ListResult>> recuperarArquivos(String uidProjeto) async {
    var result = await repository.recuperarArquivos(uidProjeto);
    var erro = "";

    result.fold((l) {
      erro = l.mensagem;
    }, (r) {});

    if (result.isLeft()) {
      switch (erro) {
        default:
          return Left(
            ErroProjeto(mensagem: "Algo de errado aconteceu!"),
          );
      }
    }

    return result;
  }

  Future removerArquivos(String uidProjeto, String nomeArquivo) async {
    return await repository.removerArquivo(uidProjeto, nomeArquivo);
  }

  Future<Either<Falha, String>> realizarDownloadArquivo(
      String uidProjeto, String nomeArquivo) async {
    var result = await repository.realizarLoginArquivo(uidProjeto, nomeArquivo);

    var erro = "";

    result.fold((l) {
      erro = l.mensagem;
    }, (r) {});

    if (result.isLeft()) {
      switch (erro) {
        default:
          return Left(
            ErroProjeto(mensagem: "Algo de errado aconteceu!"),
          );
      }
    }

    return result;
  }
}
