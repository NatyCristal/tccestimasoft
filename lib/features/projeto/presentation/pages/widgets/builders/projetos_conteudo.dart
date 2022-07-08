import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/projeto_card.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjetosConteudo extends StatelessWidget {
  final StoreProjetos store;
  final ScrollController scroll;
  final controller = Modular.get<ProjetoController>();
  final UsuarioAutenticado usuarioAutenticado =
      Modular.get<UsuarioAutenticado>();

  ProjetosConteudo({Key? key, required this.scroll, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.projetos.isEmpty && usuarioAutenticado.store.uid != ""
        ? FutureBuilder(
            future: controller.recuperarProjetos(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return const Text("Erro");
                  } else if (snapshot.hasData) {
                    if (controller.projetos.isEmpty) {
                      return SizedBox(
                        height: TamanhoTela.height(context, 0.9),
                        child: const Center(
                            child: Text("Não possui nenhum projeto")),
                      );
                    } else {
                      return ListView.builder(
                        controller: scroll,
                        shrinkWrap: false,
                        itemCount: controller.projetos.length,
                        itemBuilder: (context, index) {
                          store.projetos.isEmpty
                              ? store.projetos.addAll(controller.projetos)
                              : store.projetos;
                          ProjetoEntitie projeto = controller.projetos[index];

                          return ProjetoCard(
                            storeProjetos: store,
                            projeto: projeto,
                          );
                        },
                      );
                    }
                  }

                  store.carregou = true;
                  break;
                case ConnectionState.active:
                  store.carregou = true;
                  return const Carregando();
                case ConnectionState.none:
                  store.carregou = true;
                  return const Text("Erro");
                case ConnectionState.waiting:
                  return const Carregando();
              }
              return const Text("Erro");
            },
          )
        : Observer(builder: (context) {
            store.projetos.isNotEmpty;
            store.tamanhoProjetos > 0;
            return ListView.builder(
              controller: scroll,
              shrinkWrap: false,
              itemCount: controller.projetos.length,
              itemBuilder: (context, index) {
                ProjetoEntitie projeto = controller.projetos[index];

                return ProjetoCard(
                  storeProjetos: store,
                  projeto: projeto,
                );
              },
            );
          });
  }
}
