import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/notificacoes/data/model/notificacao_composicao_model.dart';
import 'package:estimasoft/features/notificacoes/data/model/notificacao_model.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/shared/utils/cores_fontes.dart';

class NotificacaoPage extends StatelessWidget {
  final controller = Modular.get<ProjetoController>();
  NotificacaoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Notificações",
            style: TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
          ),
          shape: const Border(
            bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 220, 220, 220).withOpacity(0.1),
          padding: paddingPagePrincipal,
          height: TamanhoTela.height(context, 1),
          width: TamanhoTela.width(context, 1),
          child: ListView.builder(
            itemCount: controller
                .notificacoesController.notificacao.notificacoes.length,
            itemBuilder: (context, index) {
              NotificacaoComposicaoModel noticacao = controller
                  .notificacoesController.notificacao.notificacoes[controller
                      .notificacoesController.notificacao.notificacoes.length -
                  1 -
                  index];

              return Container(
                padding: paddingPagePrincipal,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(noticacao.textoNotificacao)),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          noticacao.dataNotificacao,
                          style: const TextStyle(color: corCorpoTexto),
                        )),
                    Divider(color: corDeAcao.withOpacity(0.9)),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
