import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cards/card_drawer.dart';

class ListaDrawer extends StatelessWidget {
  final StoreProjetos storeProjetos;
  final ProjetoController controller;
  const ListaDrawer(
      {Key? key, required this.controller, required this.storeProjetos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardDrawer(
            nomeCard: "Meus Projetos",
            acao: () {
              Modular.to.pushNamed('meus-projetos', arguments: [storeProjetos]);
            }),
        CardDrawer(
            nomeCard: "Projetos compartilhados",
            acao: () {
              Modular.to.pushNamed('projetos-compartilhados',
                  arguments: storeProjetos);
            }),
        CardDrawer(
            nomeCard: "Notificações",
            acao: () async {
              await controller.notificacoesController.lerNoficicacoes();
              Modular.to.pushNamed("notificacoes");
            }),
        CardDrawer(
            nomeCard: "Sobre",
            acao: () {
              Modular.to.pushNamed("sobre");
            }),
      ],
    );
  }
}
