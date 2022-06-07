import 'package:estimasoft/features/contagem/data/datasource/contagem_estimada_firebase.dart';
import 'package:estimasoft/features/contagem/data/datasource/contagem_indicativa_firebase.dart';
import 'package:estimasoft/features/contagem/data/infra/contagem_estimada_infra.dart';
import 'package:estimasoft/features/contagem/data/infra/contagem_indicativa_infra.dart';
import 'package:estimasoft/features/contagem/domain/usecase/contagem_estimada.dart';
import 'package:estimasoft/features/contagem/domain/usecase/contagem_indicativa.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'contagem_controller.dart';

class ContagemModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => ContagemIndicativaFirebase(), export: true),
        Bind.factory((i) => ContagemIndicativaInfra(i()), export: true),
        Bind.factory((i) => ContagemIndicativaUseCase(i()), export: true),
        Bind.factory((i) => ContagemEstimadaUsecase(i()), export: true),
        Bind.factory((i) => ContagemEstimadaFirebase(), export: true),
        Bind.factory((i) => ContagemEstimadaInfra(i()), export: true),
        Bind.factory((i) => ContagemEstimadaUsecase(i()), export: true),
        Bind.factory((i) => ContagemController(i(), i()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [];
}
