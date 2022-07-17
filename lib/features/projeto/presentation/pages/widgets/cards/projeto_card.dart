import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProjetoCard extends StatelessWidget {
  final StoreProjetos storeProjetos;
  final ProjetoEntitie projeto;
  final Color corBackground;
  const ProjetoCard({
    Key? key,
    required this.projeto,
    this.corBackground = const Color(0XFFD8DCDF),
    required this.storeProjetos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      onTap: (() => Modular.to.pushNamed("projeto-informacao",
          arguments: [projeto, storeProjetos])),
      child: Container(
        padding: paddingPagePrincipal,
        decoration: BoxDecoration(
            image: const DecorationImage(
              opacity: 0.3,
              image: AssetImage("assets/projeto3.png"),
            ),
            color: corBackground.withOpacity(0.4),
            borderRadius: arredondamentoBordas),
        margin: const EdgeInsets.all(5),

        // width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 160,
                  child: Text(
                    projeto.nomeProjeto,
                    maxLines: 3,
                    style: const TextStyle(
                      color: corTituloTexto,
                      fontWeight: Fontes.weightTextoNormal,
                    ),
                  ),
                ),

                GestureDetector(
                    onTap: () {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Deseja sair do projeto?",
                        style: const AlertStyle(
                          titleStyle: TextStyle(
                              color: corTituloTexto,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        buttons: [
                          DialogButton(
                            color: corDeAcao.withOpacity(0.7),
                            child: Observer(builder: (context) {
                              return storeProjetos.carregandoSairProjetos
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: corTituloTexto),
                                    )
                                  : const Text(
                                      "SIM",
                                      style: TextStyle(
                                          fontWeight: Fontes.weightTextoNormal,
                                          color: corDeTextoBotaoSecundaria,
                                          fontSize: 14),
                                    );
                            }),
                            onPressed: () async {
                              if (!storeProjetos.carregandoSairProjetos) {
                                storeProjetos.carregandoSairProjetos = true;

                                var retorno =
                                    await Modular.get<ProjetoController>()
                                        .sairProjeto(projeto.uidProjeto,
                                            projeto.nomeProjeto);

                                storeProjetos.projetos.removeWhere(
                                    (element) => element.uidProjeto != "");
                                storeProjetos.tamanhoProjetos =
                                    Modular.get<ProjetoController>()
                                        .projetos
                                        .length;
                                storeProjetos.projetos.addAll(
                                    Modular.get<ProjetoController>().projetos);

                                AlertaSnack.exbirSnackBar(context, retorno);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                storeProjetos.exibirNotificacao = true;
                                storeProjetos.carregandoSairProjetos = false;
                              }
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop(),
                            width: 120,
                          )
                        ],
                      ).show();
                    },
                    child: const SizedBox(
                      width: 30,
                      height: 20,
                      child: Icon(
                        Icons.more_vert_rounded,
                        size: 30,
                        color: corCorpoTexto,
                      ),
                    ))

                //  Text("oie")
              ],
            ),
            const SizedBox(height: 10),
            Text(
              projeto.dataCriacao,
              style: const TextStyle(
                fontSize: tamanhoTextoCorpoTexto,
                color: corCorpoTexto,
                fontWeight: Fontes.weightTextoNormal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Administrador: ",
                  style: TextStyle(
                      color: corCorpoTexto,
                      fontSize: tamanhoTextoCorpoTexto,
                      fontWeight: Fontes.weightTextoNormal),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    projeto.admin == Modular.get<UsuarioAutenticado>().store.uid
                        ? "Você"
                        : projeto.nomeAdministrador,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: corCorpoTexto,
                        fontSize: tamanhoTextoCorpoTexto,
                        fontWeight: Fontes.weightTextoNormal),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
