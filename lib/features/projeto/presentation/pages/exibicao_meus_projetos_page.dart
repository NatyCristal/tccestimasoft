import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/cards/projeto_card.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExibicaoMeusProjetosPage extends StatelessWidget {
  final StoreProjetos storeProjetos;
  final ScrollController scroll = ScrollController();
  final ProjetoController controller = Modular.get<ProjetoController>();
  ExibicaoMeusProjetosPage({Key? key, required this.storeProjetos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProjetoEntitie> meusProjetos = [];
    meusProjetos = verificaQuantidadeDeProjetos(
      controller,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Meus Projetos",
          style: TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: SingleChildScrollView(
        controller: scroll,
        child: Container(
          padding: paddingPagePrincipal,
          height: TamanhoTela.height(context, 1),
          width: double.infinity,
          child: Column(children: [
            meusProjetos.isEmpty
                ? const Center(
                    child: Text("Você não possui nenhum projeto"),
                  )
                : Expanded(
                    child: ListView.builder(
                      controller: scroll,
                      shrinkWrap: false,
                      itemCount: meusProjetos.length,
                      itemBuilder: (context, index) {
                        ProjetoEntitie projeto = meusProjetos[index];

                        return ProjetoCard(
                            projeto: projeto, storeProjetos: storeProjetos);
                      },
                    ),
                  ),
          ]),
        ),
      ),
    );
  }
}

verificaQuantidadeDeProjetos(ProjetoController controller) {
  List<ProjetoEntitie> meusProjetos = [];
  if (controller.projetos.isEmpty) return meusProjetos;

  UsuarioAutenticado usuarioAutenticado = Modular.get<UsuarioAutenticado>();

  for (var element in controller.projetos) {
    if (element.admin == usuarioAutenticado.store.uid) {
      meusProjetos.add(element);
    }
  }

  return meusProjetos;
}
