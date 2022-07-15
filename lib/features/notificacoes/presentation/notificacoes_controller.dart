import 'package:estimasoft/features/notificacoes/data/model/notificacao_model.dart';
import 'package:estimasoft/features/notificacoes/domain/entity/notificacao_entity.dart';
import 'package:estimasoft/features/notificacoes/domain/usecase/notificacoes_usecase.dart';

class NotificacoesController {
  final NotificacoesUsecase notificacoesUsecase;
  NotificacaoEntity notificacao =
      NotificacaoModel(notificacoes: [], notificacaoLida: true);
  NotificacoesController(this.notificacoesUsecase);

  Future bucaraNotificacoesUsuario() async {
    var resultado = await notificacoesUsecase.buscarNotificacao();

    resultado.fold((l) {}, (r) {
      notificacao = r;
    });

    if (resultado.isRight()) {
      return notificacao;
    }
  }

  Future lerNoficicacoes() async {
    await notificacoesUsecase.lerNotificacoes();
    notificacao.notificacaoLida = true;

    return true;
  }

  Future gerarNotificacao(String texto, String uidUsuario) async {
    var resultado =
        await notificacoesUsecase.gerarNotificacao(texto, uidUsuario);

    ///notificacao.notificacaoLida = true;

    resultado.fold((l) {}, (r) {
      notificacao = r;
    });

    if (resultado.isRight()) {
      return notificacao;
    }
  }

  Future enviarNotificacaoMembros(
      String texto, String uidUsuario, List<String> uidMembros) async {
    await notificacoesUsecase.enviarNotificacaoMembros(
        texto, uidUsuario, uidMembros);
  }
}
