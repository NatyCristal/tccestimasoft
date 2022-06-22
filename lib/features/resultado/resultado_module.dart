import 'package:estimasoft/features/resultado/data/datasource/resultado_compartilhar_firebase_datasource.dart';
import 'package:estimasoft/features/resultado/data/datasource/resultado_recuperar_firebase_datasource.dart';
import 'package:estimasoft/features/resultado/data/infra/resulta_recuperar_infra_firebase.dart';
import 'package:estimasoft/features/resultado/data/infra/resultado_compartilhar_infra_firebase.dart';
import 'package:estimasoft/features/resultado/domain/usecase/resultado_compartilhar_usecase.dart';
import 'package:estimasoft/features/resultado/domain/usecase/resultado_recuperar_usecase.dart';
import 'package:estimasoft/features/resultado/presentation/resultado_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResultadoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => ResultadoFirebaseDatasource(), export: true),
        Bind.factory((i) => ResultadoInfraCompartilharFirebase(i()),
            export: true),
        Bind.factory((i) => ResultadoCompartilharUsecase(i()), export: true),
        Bind.factory((i) => ResultadoRecuperarFirebaseDatasource(),
            export: true),
        Bind.factory((i) => ResultadoInfraRecuperarFirebase(i()), export: true),
        Bind.factory((i) => ResultadoRecuperarUsecase(i()), export: true),
        Bind.factory(
            (i) => ResultadoController(
                  i(),
                  i(),
                ),
            export: true),
      ];
}
