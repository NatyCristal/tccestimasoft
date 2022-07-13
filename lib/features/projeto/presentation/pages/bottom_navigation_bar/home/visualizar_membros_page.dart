import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/home/widget/card_membros_home.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../core/shared/utils/cores_fontes.dart';

class VisualizarMembros extends StatelessWidget {
  final ProjetoEntitie projetoEntitie;
  const VisualizarMembros({Key? key, required this.projetoEntitie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Membros do projeto",
          style: TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: Container(
        padding: paddingPagePrincipal,
        child: SingleChildScrollView(
          child: SizedBox(
            height: TamanhoTela.height(context, 1),
            width: TamanhoTela.width(context, 1),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: Modular.get<ProjetoController>()
                          .membrosProjetoAtual
                          .length,
                      itemBuilder: (context, index) {
                        UsuarioEntity usuario = Modular.get<ProjetoController>()
                            .membrosProjetoAtual[index];

                        return CardMembrosHome(
                          ehAdmin: usuario.uid == projetoEntitie.admin
                              ? true
                              : false,
                          usuarioEntitie: usuario,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
