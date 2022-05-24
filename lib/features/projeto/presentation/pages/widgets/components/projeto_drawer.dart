import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/projetos/avatar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/projetos/lista_drawer.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../../core/auth/usuario_autenticado.dart';

class ProjetoDrawer extends StatelessWidget {
  ProjetoController controller = Modular.get<ProjetoController>();
  ProjetoDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();
    return Container(
      color: Colors.white,
      height: TamanhoTela.height(context, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
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
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: paddingPagePrincipal,
                  // height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            usuarioLogado.store.nome,
                            style: const TextStyle(
                                fontSize: tamanhoTextoCorpoTexto,
                                color: corCorpoTexto,
                                fontWeight: Fontes.weightTextoNormal),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            usuarioLogado.store.email,
                            style: const TextStyle(
                                fontSize: tamanhoTextoCorpoTexto,
                                color: corCorpoTexto,
                                fontWeight: Fontes.weightTextoNormal),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Container(
                            decoration: BoxDecoration(
                                color: corDeAcao.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8)),
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
              const ListaDrawer()
            ],
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
                    color: corDeFundoBotaoSecundaria,
                    child: const Text(
                      "SIM",
                      style: TextStyle(
                          fontWeight: Fontes.weightTextoNormal,
                          color: corDeTextoBotaoSecundaria,
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
                    color: Colors.indigo,
                    child: const Text(
                      "NÃO",
                      style: TextStyle(
                        fontWeight: Fontes.weightTextoNormal,
                        color: corTextoSobCorPrimaria,
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
    );
  }
}
