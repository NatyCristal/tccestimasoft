import 'package:blobs/blobs.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/core/shared/widgets/botao_texto.dart';
import 'package:estimasoft/core/shared/widgets/input.dart';
import 'package:estimasoft/features/login/login_controller.dart';
import 'package:estimasoft/features/login/presentation/stores/store_login.dart';
import 'package:estimasoft/features/login/routes/login_rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class LoginPrincipalPage extends StatelessWidget {
  final LoginController controller = Modular.get<LoginController>();
  final StoreLogin store = StoreLogin();
  LoginPrincipalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: background,
        body: Center(
          child: Container(
            height: TamanhoTela.height(context, 1),
            padding: paddingPagePrincipal,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Bem vindo ao EstimaSoft",
                        style: TextStyle(
                          fontSize: tamanhoTextoTitulo,
                          color: corTituloTexto,
                          fontWeight: Fontes.weightTextoTitulo,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Entre com uma conta",
                        style: TextStyle(
                            fontSize: tamanhoSubtitulo,
                            color: corCorpoTexto,
                            fontWeight: Fontes.weightTextoNormal),
                      ),
                      SizedBox(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Stack(children: [
                                Blob.animatedFromID(
                                  id: const [
                                    '6-6-300',
                                  ],
                                  size: 150,
                                  styles: BlobStyles(
                                      fillType: BlobFillType.fill,
                                      color: corDeFundoBotaoSecundaria),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/imagens/logo_estatica.png",
                                      scale: 1.5,
                                    ),
                                  ),
                                ),
                              ])
                            ],
                          ),
                        ),
                      ),
                      Observer(builder: (context) {
                        return InputPadrao(
                          acaoClicarIcone: () => {},
                          controller: store.controllerEmail,
                          ehSenha: false,
                          rotulo: "Email",
                          erroTexto: store.textoErroEmail,
                          corDeFundoBotao: corDeFundoCards,
                          temErroCampoInput: store.temErroEmail,
                          validar: (value) {
                            store.validarEmail();
                          },
                        );
                      }),
                      Observer(builder: (context) {
                        return InputPadrao(
                            acaoClicarIcone: () => {
                                  store.existeSenha
                                      ? store.existeSenha = false
                                      : store.existeSenha = true
                                },
                            controller: store.controllerSenha,
                            validar: (value) {
                              store.validarSenha();
                            },
                            corDeFundoIcone: corDeFundoCards,
                            icone: Icons.remove_red_eye_outlined,
                            ehSenha: store.existeSenha,
                            rotulo: "Senha",
                            erroTexto: store.textoErroSenha,
                            corDeFundoBotao: corDeFundoInput,
                            temErroCampoInput: store.temErroSenha);
                      }),
                      Align(
                        alignment: Alignment.centerRight,
                        child: BotaoTexto(
                            textoBotao: "Esqueceu a senha?",
                            acaoBotao: () {
                              LoginRotas.irParaRedefinirSenha();
                            },
                            corTexto: corTituloTexto),
                      ),
                      Observer(builder: (context) {
                        return BotaoPadrao(
                          carregando: store.carregandoEntrar,
                          corDeTextoBotao: corDeTextoBotaoPrimaria,
                          acao: () async {
                            if (store.validarEmail() && store.validarSenha()) {
                              store.carregandoEntrar = true;
                              var resultado = await controller.entrar(
                                  store.controllerEmail.text,
                                  store.controllerSenha.text);

                              store.carregandoEntrar = false;
                              AlertaSnack.exbirSnackBar(context, resultado);
                            }
                          },
                          tituloBotao: "Entrar",
                          corBotao: corDeFundoBotaoPrimaria,
                        );
                      }),
                      const Text(
                        "ou",
                        style: TextStyle(
                          fontSize: tamanhoSubtitulo,
                          color: corCorpoTexto,
                        ),
                      ),
                      Observer(builder: (context) {
                        return BotaoPadrao(
                          corBordas: corTituloTexto,
                          carregando: store.carregandogoogle,
                          icone: SvgPicture.asset(
                            "assets/google_logo.svg",
                            color: corDeTextoBotaoSecundaria,
                          ),
                          acao: () async {
                            store.carregandogoogle = true;
                            var resultado = await controller.entrarGoogle();
                            store.carregandogoogle = false;
                            AlertaSnack.exbirSnackBar(context, resultado);
                          },
                          tituloBotao: "Entrar com Google",
                          corBotao: background,
                        );
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Não tem uma conta?",
                        style: TextStyle(
                            fontSize: tamanhoSubtitulo, color: corCorpoTexto),
                      ),
                      BotaoTexto(
                        textoBotao: "Registre-se",
                        acaoBotao: () {
                          LoginRotas.irParaRegistrarUsuario();
                        },
                        corTexto: corDeFundoBotaoPrimaria,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
