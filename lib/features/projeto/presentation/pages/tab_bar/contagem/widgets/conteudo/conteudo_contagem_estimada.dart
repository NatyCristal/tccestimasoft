import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConteudoContagemEstimada extends StatelessWidget {
  final StoreContagemEstimada store;
  final String uidProjeto;
  final ProjetoController controller = Modular.get<ProjetoController>();
  ConteudoContagemEstimada(
      {Key? key, required this.uidProjeto, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.recuperarContagem("Estimada", uidProjeto),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              store.carregou = true;
              return const Text("Erro");
            }
            if (snapshot.hasData && !store.carregou) {
              store.iniciarSessao(
                  controller.contagemController.contagemEstimada);
              store.carregou = true;
              break;
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
