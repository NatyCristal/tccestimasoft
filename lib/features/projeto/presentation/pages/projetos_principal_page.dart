import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/builders/projetos_conteudo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/projeto_drawer.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProjetosPrincipalPage extends StatelessWidget {
  final StoreProjetos store = StoreProjetos();
  final ProjetoController controller = Modular.get<ProjetoController>();
  ProjetosPrincipalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nomeProjeto = "";
    return Scaffold(
      drawer: Drawer(
        child: ProjetoDrawer(),
      ),
      body: FloatingSearchBar(
        backgroundColor: corDeFundoBotaoSecundaria,
        hint: "Pesquise....",
        title: const Text(
          "Pesquise em Projetos",
          style: TextStyle(color: corCorpoTexto),
        ),
        borderRadius: arredondamentoBordas,
        body: FloatingSearchBarScrollNotifier(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: TamanhoTela.height(context, 1),
              padding: paddingPagePrincipal,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Lista de Projetos",
                        style: TextStyle(
                            color: corCorpoTexto,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ProjetosConteudo(),
                  ),
                ],
              ),
            ),
          ),
        ),
        builder: (BuildContext context, Animation<double> transition) {
          return const SingleChildScrollView(child: SizedBox());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: corDeFundoBotaoPrimaria,
        onPressed: () {
          Alert(
            closeFunction: () => {
              Navigator.of(context, rootNavigator: true).pop(),
              store.nomeProjetoErro = "",
            },
            context: context,
            title: "Dê um nome para o projeto",
            style: const AlertStyle(
              titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
            ),
            content: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Observer(builder: (context) {
                  return store.nomeProjetoErro == ""
                      ? TextField(
                          onChanged: (value) {
                            store.nomeProjeto = value.toString();
                            store.validarNomeProjeto();
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.account_tree_rounded),
                            labelText: 'Nome',
                          ),
                        )
                      : TextField(
                          onChanged: (value) {
                            store.nomeProjeto = value.toString();
                            store.validarNomeProjeto();
                          },
                          decoration: InputDecoration(
                            errorText: store.nomeProjetoErro,
                            icon: const Icon(Icons.account_tree_rounded),
                            labelText: 'Nome',
                          ),
                        );
                }),
              ],
            ),
            buttons: [
              DialogButton(
                color: corDeFundoBotaoSecundaria,
                child: const Text(
                  "Salvar",
                  style: TextStyle(
                      fontWeight: Fontes.weightTextoNormal,
                      color: corDeTextoBotaoSecundaria,
                      fontSize: 14),
                ),
                onPressed: () async {
                  if (store.validarNomeProjeto()) {
                    var resultado =
                        await controller.criarProjeto(store.nomeProjeto);
                    Navigator.of(context, rootNavigator: true).pop();
                    AlertaSnack.exbirSnackBar(context, resultado);
                  }
                },
                width: 120,
              ),
              DialogButton(
                color: Colors.indigo,
                child: const Text(
                  "Cancelar",
                  style: TextStyle(
                    fontWeight: Fontes.weightTextoNormal,
                    color: corTextoSobCorPrimaria,
                    fontSize: 14,
                  ),
                ),
                onPressed: () => {
                  Navigator.of(context, rootNavigator: true).pop(),
                  store.nomeProjetoErro = "",
                },
                width: 120,
              )
            ],
          ).show();
        },
        child: const Icon(
          Icons.add,
          color: corTextoSobCorPrimaria,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
      ),
    );
  }
}
