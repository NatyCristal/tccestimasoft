import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:flutter/material.dart';
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
      onTap: (() =>
          Modular.to.pushNamed("projeto-informacao", arguments: projeto)),
      child: Container(
        padding: paddingPagePrincipal,
        decoration: BoxDecoration(
            image: const DecorationImage(
              opacity: 0.3,
              image: AssetImage("assets/projeto3.png"),
            ),
            color: corBackground
                .withOpacity(0.4), // const Color(0XFFD8DCDF).withOpacity(0.3),
            borderRadius: arredondamentoBordas),
        margin: const EdgeInsets.all(5),
        height: 100,
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
                    maxLines: 1,
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
                            child: const Text(
                              "SIM",
                              style: TextStyle(
                                  fontWeight: Fontes.weightTextoNormal,
                                  color: corDeTextoBotaoSecundaria,
                                  fontSize: 14),
                            ),
                            onPressed: () async {
                              var retorno =
                                  await Modular.get<ProjetoController>()
                                      .sairProjeto(projeto.uidProjeto);

                              storeProjetos.projetos.setAll(
                                  0, Modular.get<ProjetoController>().projetos);

                              Navigator.of(context, rootNavigator: true).pop();
                              AlertaSnack.exbirSnackBar(context, retorno);
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
                  "Criado por: ",
                  style: TextStyle(
                      color: corCorpoTexto,
                      fontSize: tamanhoTextoCorpoTexto,
                      fontWeight: Fontes.weightTextoNormal),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    projeto.nomeAdministrador,
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
