import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/projeto_card.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjetosConteudo extends StatelessWidget {
  final controller = Modular.get<ProjetoController>();

  ProjetosConteudo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.recuperarProjetos(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // switch (snapshot.connectionState) {
        //   case ConnectionState.done:
        //     if (snapshot.hasError) {
        //       return const Text("Erro");
        //     } else if (snapshot.hasData) {
        return ListView.builder(
          shrinkWrap: false,
          itemCount: controller.projetos.length,
          itemBuilder: (context, index) {
            ProjetoEntitie projeto = controller.projetos[index];

            return ProjetoCard(
              projeto: projeto,
            );
          },
        );

        //     break;
        //   case ConnectionState.active:
        //     return const Text("Carregando");
        //   case ConnectionState.none:
        //     return const Text("Erro");
        //   case ConnectionState.waiting:
        //     return const Text("Carregando");
        // }
        //  return const Text("Erro");
      },
    );
  }
}
