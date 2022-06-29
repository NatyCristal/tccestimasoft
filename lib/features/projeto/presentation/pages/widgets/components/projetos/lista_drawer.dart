import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../cards/card_drawer.dart';

class ListaDrawer extends StatelessWidget {
  final ProjetoController controller;
  const ListaDrawer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardDrawer(
            nomeCard: "Meus Projetos",
            acao: () {
              Modular.to.pushNamed('meus-projetos');
            }),
        CardDrawer(
            nomeCard: "Projetos compartilhados",
            acao: () {
              Modular.to.pushNamed(
                'projetos-compartilhados',
              );
            }),
        CardDrawer(nomeCard: "Compartilhar", acao: () {}),
      ],
    );
  }
}
