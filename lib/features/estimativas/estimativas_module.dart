import 'package:estimasoft/features/estimativas/data/infra/estimativa_esforco_infra.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_esforco_usecase.dart';
import 'package:estimasoft/features/estimativas/presentation/estimativas_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'data/datasource/estimativas_firebase_datasource.dart';

class EstimativasModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => EstimativasFirebaseDatasource(), export: true),
        Bind.factory((i) => EstimativaEsforcoFirebase(i()), export: true),
        Bind.factory((i) => EstimativaEsforcoUsecase(i()), export: true),
        Bind.factory((i) => EstimativasController(i()), export: true),
      ];
}
