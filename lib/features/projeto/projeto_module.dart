import 'package:estimasoft/core/guards/autorizado_guard.dart';
import 'package:estimasoft/features/contagem/contagem_module.dart';
import 'package:estimasoft/features/estimativas/estimativas_module.dart';
import 'package:estimasoft/features/projeto/data/datasource/projeto_firebase_datasource.dart';
import 'package:estimasoft/features/projeto/domain/usecase/entrar_projeto_usecase.dart';
import 'package:estimasoft/features/projeto/domain/usecase/recuperar_membros_usecase.dart';
import 'package:estimasoft/features/projeto/domain/usecase/arquivo_usecase.dart';
import 'package:estimasoft/features/projeto/domain/usecase/sair_projeto_usecase.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/projeto_bottom_navigator_bar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/exibicao_estimativa_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/exibicao_projetos_compartilhados_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/exibicao_meus_projetos_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/guia_contagem.dart';
import 'package:estimasoft/features/projeto/presentation/pages/insercao_arquivos_projetos_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/instrucoes_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/notificacao_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/projetos_principal_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/sobre_page.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/projeto/presentation/store/store_projeto_principal.dart';
import 'package:estimasoft/features/resultado/resultado_module.dart';
import 'package:estimasoft/features/usuario/usuario_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../usuario/data/datasource/usuario_firebase_datasource.dart';
import 'data/infra/projeto_firebase_infra.dart';
import 'domain/usecase/criar_projeto_usecase.dart';
import 'domain/usecase/recuperar_projetos_usecase.dart';

class ProjetoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => UsuarioFirebaseDataSource()),
        Bind.factory((i) => ProjetoFirebaseDatasource(i())),
        Bind.factory((i) => ProjetoFirebaseInfra(i())),
        Bind.factory((i) => RecuperarMembrosUsecase(i())),
        Bind.factory((i) => CriarProjetoUsecase(i())),
        Bind.factory((i) => RecuperarProjetosUsecase(i())),
        Bind.factory((i) => EntraProjetoUsecase(i())),
        Bind.factory((i) => ArquivoUsecase(i())),
        Bind.factory((i) => SairProjetoUsecase(i())),
        Bind.lazySingleton(
            (i) => ProjetoController(i(), i(), i(), i(), i(), i())),
      ];

  @override
  List<Module> get imports => [
        UsuarioModule(),
        ContagemModule(),
        EstimativasModule(),
        ResultadoModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const InformacoesInstrucoesPage(),
            guards: [AutorizadoGuard()]),
        ChildRoute('/notificacoes',
            child: (context, args) => const NotificacaoPage(),
            guards: [AutorizadoGuard()]),
        ChildRoute('/exibir-pdf',
            child: (context, args) => const GuiaContagemSobre(),
            guards: [AutorizadoGuard()]),
        ChildRoute('/sobre',
            child: (context, args) => const SobrePage(),
            guards: [AutorizadoGuard()]),
        ChildRoute('/exibicao-projetos',
            child: (context, args) =>
                ProjetosPrincipalPage(store: StoreProjetos()),
            guards: [AutorizadoGuard()]),
        ChildRoute('/projeto-informacao',
            child: (context, args) => ProjetoMenuPage(
                  projeto: args.data,
                ),
            guards: [AutorizadoGuard()]),
        ChildRoute('/meus-projetos',
            child: (context, args) => ExibicaoMeusProjetosPage(
                  storeProjetos: args.data[0],
                ),
            guards: [AutorizadoGuard()]),
        ChildRoute('/projetos-compartilhados',
            child: (context, args) => ExibicaoProjetosCompartilhadosPage(
                  storeProjetos: args.data,
                ),
            guards: [AutorizadoGuard()]),
        ChildRoute('/inserir-arquivos',
            child: (context, args) => InsercaoArquivosUpload(
                  projetoEntitie: args.data[0],
                  storeProjetosIndexMenu: args.data[1],
                ),
            guards: [AutorizadoGuard()]),
        ChildRoute('/visualizar-estimativa',
            child: (context, args) => VisualizarEstimativas(
                  estimativas: args.data[0],
                  tipoDeEstimativa: args.data[1],
                  uidProjeto: args.data[2],
                ),
            guards: [AutorizadoGuard()])
      ];
}
