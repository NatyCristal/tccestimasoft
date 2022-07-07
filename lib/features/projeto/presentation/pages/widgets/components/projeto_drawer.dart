import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/projetos/avatar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/projetos/lista_drawer.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../../core/auth/usuario_autenticado.dart';

class ProjetoDrawer extends StatelessWidget {
  final StoreProjetos storeProjetos;
  final ProjetoController controller = Modular.get<ProjetoController>();
  ProjetoDrawer({Key? key, required this.storeProjetos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();
    return SingleChildScrollView(
      child: Container(
        color: background,
        height: TamanhoTela.height(context, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: background,
              height: TamanhoTela.height(context, 0.9),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 56),
                            padding: paddingPagePrincipal,
                            width: double.infinity,
                            color: background,
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 30,
                                ),
                                AvatarUsuario(),
                              ],
                            )),
                        Container(
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: paddingPagePrincipal,
                              // height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        usuarioLogado.store.nome,
                                        style: const TextStyle(
                                            fontSize: tamanhoTextoCorpoTexto,
                                            color: corCorpoTexto,
                                            fontWeight:
                                                Fontes.weightTextoNormal),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        usuarioLogado.store.email,
                                        style: const TextStyle(
                                            fontSize: tamanhoTextoCorpoTexto,
                                            color: corCorpoTexto,
                                            fontWeight:
                                                Fontes.weightTextoNormal),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Modular.to.pushNamed("/usuario");
                                      },
                                      icon: Container(
                                        decoration: BoxDecoration(
                                            color: corDeAcao.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height: 25,
                                        width: 25,
                                        child: const Icon(
                                          Icons.edit,
                                          color: corDeAcao,
                                          size: 18,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        ListaDrawer(
                          storeProjetos: storeProjetos,
                          controller: controller,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Deseja deslogar do aplicativo?",
                  style: const AlertStyle(
                    titleStyle: TextStyle(color: corTituloTexto, fontSize: 18),
                  ),
                  buttons: [
                    DialogButton(
                      color: corDeAcao.withOpacity(0.7),
                      child: const Text(
                        "SIM",
                        style: TextStyle(
                            fontWeight: Fontes.weightTextoNormal,
                            color: corTituloTexto,
                            fontSize: 14),
                      ),
                      onPressed: () async {
                        var retorno = await controller.usuarioDeslogar();
                        AlertaSnack.exbirSnackBar(context, retorno);
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      width: 120,
                    ),
                    DialogButton(
                      color: corDeFundoBotaoSecundaria,
                      child: const Text(
                        "NÃO",
                        style: TextStyle(
                          fontWeight: Fontes.weightTextoNormal,
                          color: corTextoSobSecundaria,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      width: 120,
                    )
                  ],
                ).show()
              },
              child: Container(
                color: background,
                padding: paddingPagePrincipal,
                height: 50,
                width: TamanhoTela.width(context, 1),
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout_outlined,
                      color: corTituloTexto,
                      size: 22,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Sair",
                        style: TextStyle(
                          fontSize: tamanhoSubtitulo,
                          color: corTituloTexto,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
