import 'package:estimasoft/features/notificacoes/data/datasource/notificacoes_datasource.dart';
import 'package:estimasoft/features/notificacoes/domain/entity/notificacao_entity.dart';
import 'package:estimasoft/core/errors/falha.dart';
import 'package:dartz/dartz.dart';
import 'package:estimasoft/features/notificacoes/domain/repository/notificacoes_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InfraFireabseNotificacoes extends NotificacoesRepositpry {
  final NotificacoesDatasource datasource;

  InfraFireabseNotificacoes(this.datasource);

  @override
  Future<Either<Falha, NotificacaoEntity>> buscarNotificacoes() async {
    try {
      var resultado = await datasource.buscarNoticaoes();
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future<Either<Falha, NotificacaoEntity>> enviarNotificacoes(
      String texto, String uidUsuario) async {
    try {
      var resultado = await datasource.enviarNotivicacao(texto, uidUsuario);
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future lerNotificacoes() async {
    try {
      var resultado = await datasource.lerNotificacao();
      return Right(resultado);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }

  @override
  Future enviarNotificacaoParaMembros(
      String texto, String uidProjeto, List<String> uidUsuarios) async {
    try {
      await datasource.enviarNotificacaoParaMembros(
          texto, uidProjeto, uidUsuarios);
    } on FirebaseException catch (e) {
      return Left(Falha(mensagem: e.code));
    }
  }
}
