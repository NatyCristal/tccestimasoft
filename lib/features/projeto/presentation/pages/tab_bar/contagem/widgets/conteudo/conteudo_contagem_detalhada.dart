import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConteudoContagemDetalhada extends StatelessWidget {
  final StoreContagemDetalhada storeContagemDetalhada;
  final StoreContagemIndicativa storeContagemIndicativa;
  final StoreContagemEstimada store;
  final String uidProjeto;
  final ProjetoController controller = Modular.get<ProjetoController>();
  ConteudoContagemDetalhada(
      {Key? key,
      required this.uidProjeto,
      required this.store,
      required this.storeContagemIndicativa,
      required this.storeContagemDetalhada})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: recuperarParametros(controller, uidProjeto),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              store.carregou = true;
              return const Text("Erro");
            }
            if (snapshot.hasData) {
              storeContagemIndicativa.contagemIndicativaValida =
                  controller.contagemController.contagemIndicativa;
              store.contagemEstimadaValida =
                  controller.contagemController.contagemEstimada;

              storeContagemDetalhada.receberDados(store.contagemEstimadaValida,
                  storeContagemIndicativa.contagemIndicativaValida);
            }

            break;
          case ConnectionState.active:
            return const Carregando();
          case ConnectionState.none:
            store.carregou = true;
            return const Text("Erro nenhum");
          case ConnectionState.waiting:
            return const Carregando();
        }
        return const SizedBox();
      },
    );
  }
}

recuperarParametros(ProjetoController controller, String projetos) async {
  await controller.contagemController.recuperarContagemIndicativa(
      projetos, Modular.get<UsuarioAutenticado>().store.uid);
  return await controller.contagemController.recuperarContagemEstimada(
      projetos, Modular.get<UsuarioAutenticado>().store.uid);
}
