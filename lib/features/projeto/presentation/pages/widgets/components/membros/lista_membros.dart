import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/membros/avatar_membros.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListaMembros extends StatelessWidget {
  final ProjetoEntitie projeto;
  final ProjetoController controller = Modular.get<ProjetoController>();
  ListaMembros({Key? key, required this.projeto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: background.withOpacity(0.5),
          borderRadius: arredondamentoBordas),
      height: 60,
      child: FutureBuilder(
        future: controller.recuperarMembrosProjeto(projeto.uidProjeto),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // switch (snapshot.connectionState) {
          //   case ConnectionState.done:
          //     if (snapshot.hasError) {
          //       return const Text("Erro");
          //     } else if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: false,
            itemCount: controller.membrosProjetoAtual.length,
            scrollDirection: Axis.horizontal,
            // physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              UsuarioEntitie membro = controller.membrosProjetoAtual[index];
              // ProjetoEntitie projeto = controller.projetos[index];

              return AvatarMembro(
                membro: membro,
              );

              // return ProjetoCard(
              //   projeto: projeto,
              // );
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
      ),
    );
  }
}
