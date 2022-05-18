import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/core/shared/widgets/input.dart';
import 'package:estimasoft/features/login/presentation/stores/store_recuperar_senha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../login_controller.dart';

class LoginRedefinirSenha extends StatelessWidget {
  final LoginController controller = Modular.get<LoginController>();
  final StoreLoginRecuperarSenha store = StoreLoginRecuperarSenha();
  LoginRedefinirSenha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Redefinir Senha",
            style: TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
          ),
          shape: const Border(
            bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
          ),
        ),
        body: Container(
          height: TamanhoTela.height(context, 1),
          padding: paddingPagePrincipal,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Para recuperar o acesso insira seu email para enviarmos as instruções de refefinição de senha",
                  style: TextStyle(
                      fontSize: tamanhoSubtitulo, color: corCorpoTexto),
                ),
                const SizedBox(
                  height: 30,
                ),
                Observer(builder: (context) {
                  return InputPadrao(
                    acaoClicarIcone: () => {},
                    temErroCampoInput: store.temErroEmail,
                    corDeFundoBotao: corDeFundoCards,
                    erroTexto: store.textoErroEmail,
                    rotulo: "Email",
                    ehSenha: false,
                    validar: (value) {
                      store.validarEmail();
                    },
                    controller: store.controllerEmail,
                  );
                }),
                Observer(builder: (context) {
                  return BotaoPadrao(
                    carregando: store.carregando,
                    corDeTextoBotao: corTextoSobCorPrimaria,
                    acao: () async {
                      if (store.validarEmail()) {
                        store.carregando = true;
                        var retorno = await controller
                            .redefinirSenha(store.controllerEmail.text);
                        store.carregando = false;
                        AlertaSnack.exbirSnackBar(context, retorno);
                      }
                    },
                    tituloBotao: "Enviar",
                    corBotao: corDeFundoBotaoPrimaria,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
