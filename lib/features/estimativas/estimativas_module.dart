import 'package:estimasoft/features/estimativas/data/datasource/estimativa_firebase_custo_datasource.dart';
import 'package:estimasoft/features/estimativas/data/datasource/estimativa_firebase_equipe_datasource.dart';
import 'package:estimasoft/features/estimativas/data/datasource/estimativa_firebase_prazo_datasource.dart';
import 'package:estimasoft/features/estimativas/data/infra/estimativa_custo_infra.dart';
import 'package:estimasoft/features/estimativas/data/infra/estimativa_equipe_infra.dart';
import 'package:estimasoft/features/estimativas/data/infra/estimativa_esforco_infra.dart';
import 'package:estimasoft/features/estimativas/data/infra/estimativa_prazo_infra.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_custo_usecase.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_equipe_usecase.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_esforco_usecase.dart';
import 'package:estimasoft/features/estimativas/domain/usecase/estimativa_prazo_usecase.dart';
import 'package:estimasoft/features/estimativas/presentation/estimativas_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'data/datasource/estimativas_firebase_esforco_datasource.dart';

class EstimativasModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => EstimativaFirebaseEsforcoDatasource(),
            export: true),
        Bind.factory((i) => EstimativaEsforcoFirebase(i()), export: true),
        Bind.factory((i) => EstimativaEsforcoUsecase(i()), export: true),
        //
        Bind.factory((i) => EstimativaFirebasePrazoDatasource(), export: true),
        Bind.factory((i) => EstimativaPrazoFirebase(i()), export: true),
        Bind.factory((i) => EstimativaPrazoUsecase(i()), export: true),
        //
        Bind.factory((i) => EstimativaEquipeFirebaseDatasource(), export: true),
        Bind.factory((i) => EstimativaEquipeFirebase(i()), export: true),
        Bind.factory((i) => EquipeUsecase(i()), export: true),
        //
        Bind.factory((i) => EstimativaCustoFirebaseDatasource(), export: true),
        Bind.factory((i) => EstimativaCustoFirebase(i()), export: true),
        Bind.factory((i) => CustoUsecase(i()), export: true),

        Bind.factory((i) => EstimativasController(i(), i(), i(), i()),
            export: true),
      ];
}
