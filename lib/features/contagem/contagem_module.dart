import 'package:estimasoft/features/contagem/data/datasource/contagem_indicativa_firebase.dart';
import 'package:estimasoft/features/contagem/data/infra/contagem_indicativa_infra.dart';
import 'package:estimasoft/features/contagem/domain/usecase/contagem_indicativa.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'contagem_controller.dart';

class ContagemModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => ContagemIndicativaFirebase(), export: true),
        Bind.factory((i) => ContagemIndicativaInfra(i()), export: true),
        Bind.factory((i) => ContagemIndicativaUseCase(i()), export: true),
        Bind.singleton((i) => ContagemController(i()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [];
}
