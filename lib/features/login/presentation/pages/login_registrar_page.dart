import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/core/shared/widgets/input.dart';
import 'package:estimasoft/features/login/presentation/stores/store_registrar.dart';
import 'package:estimasoft/features/login/routes/login_rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../login_controller.dart';

class LoginRegistrar extends StatelessWidget {
  final StoreLoginRegistrar store = StoreLoginRegistrar();
  final LoginController controller = Modular.get<LoginController>();
  LoginRegistrar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registrar-se",
          style: TextStyle(fontSize: tamanhoTextoTitulo, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: Container(
        padding: paddingPagePrincipal,
        height: TamanhoTela.height(context, 1),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  "assets/logo.png",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Insira os dados a baixo",
                style: TextStyle(
                    color: corTituloTexto,
                    fontSize: tamanhoSubtitulo,
                    fontWeight: Fontes.weightTextoNormal),
              ),
              const SizedBox(
                height: 30,
              ),
              Observer(builder: (context) {
                return InputPadrao(
                  acaoClicarIcone: () => {},
                  controller: store.controllerNome,
                  temErroCampoInput: store.temErroNome,
                  corDeFundoBotao: corDeFundoCards,
                  erroTexto: store.textoErroNome,
                  rotulo: "Nome",
                  ehSenha: false,
                  validar: (value) {
                    store.validarNome();
                  },
                );
              }),
              Observer(builder: (context) {
                return InputPadrao(
                  corDeFundoIcone: corDeFundoCards,
                  acaoClicarIcone: () => {},
                  controller: store.controllerEmail,
                  temErroCampoInput: store.temErroEmail,
                  corDeFundoBotao: corDeFundoCards,
                  erroTexto: store.textoErroEmail,
                  rotulo: "Email",
                  ehSenha: false,
                  validar: (value) {
                    store.validarEmail();
                  },
                );
              }),
              Observer(builder: (context) {
                return InputPadrao(
                  acaoClicarIcone: () => {},
                  controller: store.controllerSenha,
                  temErroCampoInput: store.temErroSenha,
                  corDeFundoBotao: corDeFundoInput,
                  erroTexto: store.textoErroSenha,
                  rotulo: "Senha",
                  ehSenha: store.existeSenha,
                  validar: (value) {
                    store.validarSenha();
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
                  controller: store.controllerConfirmacaoSenha,
                  corDeFundoIcone: corDeFundoCards,
                  icone: Icons.remove_red_eye_outlined,
                  temErroCampoInput: store.temErroConfirmacaoSenha,
                  corDeFundoBotao: corDeFundoInput,
                  erroTexto: store.textoErroConfirmacaoSenha,
                  rotulo: "Confirmação senha",
                  ehSenha: store.existeSenha,
                  validar: (value) {
                    store.validarSenhaComCampoConfirmacao();
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Observer(builder: (context) {
                return BotaoPadrao(
                    carregando: store.carregando,
                    acao: () async {
                      if (store.validarEmail() &&
                          store.validarNome() &&
                          store.validarSenhaComCampoConfirmacao()) {
                        store.carregando = true;
                        var retorno = await controller.registrarUsuario(
                            store.controllerNome.text,
                            store.controllerEmail.text,
                            store.controllerSenha.text);
                        store.carregando = false;
                        AlertaSnack.exbirSnackBar(context, retorno);
                        LoginRotas.irParaLogin();
                      }
                    },
                    tituloBotao: "Cadastrar",
                    corBotao: corDeFundoBotaoPrimaria,
                    corDeTextoBotao: corTextoSobCorPrimaria);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
