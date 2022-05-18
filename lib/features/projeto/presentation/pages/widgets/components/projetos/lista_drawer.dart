import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/card_drawer.dart';
import 'package:flutter/widgets.dart';

class ListaDrawer extends StatelessWidget {
  const ListaDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardDrawer(nomeCard: "Meus Projetos", acao: () {}),
        CardDrawer(nomeCard: "Projetos compartilhados", acao: () {}),
        CardDrawer(nomeCard: "Compartilhar", acao: () {}),
      ],
    );
  }
}
