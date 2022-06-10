import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/core/shared/widgets/input.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/projetos/avatar.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/usuario/presentation/pages/store/store_editar_dados_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EditarDadosUsuario extends StatelessWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final UsuarioAutenticado usuarioAutenticado =
      Modular.get<UsuarioAutenticado>();
  final StoreEditarDadosUsuario store = StoreEditarDadosUsuario();

  EditarDadosUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Meus dados",
          style: TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: TamanhoTela.height(context, 0.8),
          width: TamanhoTela.width(context, 1),
          padding: paddingPagePrincipal,
          child: Column(
            children: [
              const AvatarUsuario(),
              const SizedBox(
                height: 30,
              ),
              Observer(builder: (context) {
                return InputPadrao(
                  acaoClicarIcone: () => {},
                  temErroCampoInput: store.temErroNome,
                  corDeFundoBotao: corDeFundoInput,
                  erroTexto: store.textoErroNome,
                  rotulo: "Nome",
                  ehSenha: false,
                  validar: (value) {
                    store.validarNome();
                  },
                  controller: store.controllerNome,
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Observer(builder: (context) {
                return InputPadrao(
                  acaoClicarIcone: () => {},
                  temErroCampoInput:
                      store.temErroEmail, //"",//store.temErroEmail,
                  corDeFundoBotao: corDeFundoInput,
                  erroTexto: store.textoErroEmail, //"" store.textoErroEmail,
                  rotulo: "Email",
                  ehSenha: false,
                  validar: (value) {
                    store.validarEmail();
                  },
                  controller: store.controllerEmail,
                );
              }),
              const SizedBox(
                height: 30,
              ),
              Observer(builder: (context) {
                return BotaoPadrao(
                    corDeTextoBotao: corDeTextoBotaoPrimaria,
                    acao: () async {
                      if (store.controllerNome.text !=
                              usuarioAutenticado.store.nome &&
                          store.validarNome()) {
                        store.carregou = true;
                        var retorno = await controller
                            .usuarioEditarNome(store.controllerNome.text);
                        AlertaSnack.exbirSnackBar(context, retorno);
                        store.carregou = false;
                      }
                      if (store.controllerEmail.text !=
                              usuarioAutenticado.store.email &&
                          store.validarEmail()) {
                        store.carregou = true;
                        var retorno = await controller
                            .usuarioEditarEmail(store.controllerEmail.text);
                        AlertaSnack.exbirSnackBar(context, retorno);
                        store.carregou = false;
                      }
                    },
                    tituloBotao: "Alterar",
                    corBotao: corDeFundoBotaoPrimaria,
                    carregando: store.carregou);
              })
            ],
          ),
        ),
      ),
    );
  }
}
