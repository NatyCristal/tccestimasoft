// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/features/contagem/contagem_controller.dart';
import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/presentation/estimativas_controller.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/notificacoes/presentation/notificacoes_controller.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/domain/usecase/entrar_projeto_usecase.dart';
import 'package:estimasoft/features/projeto/domain/usecase/recuperar_membros_usecase.dart';
import 'package:estimasoft/features/projeto/domain/usecase/arquivo_usecase.dart';
import 'package:estimasoft/features/projeto/domain/usecase/sair_projeto_usecase.dart';
import 'package:estimasoft/features/resultado/presentation/resultado_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../usuario/presentation/usuario_controller.dart';
import '../domain/usecase/criar_projeto_usecase.dart';
import '../domain/usecase/recuperar_projetos_usecase.dart';

class ProjetoController {
  //Modulos externos
  final UsuarioController usuarioController = Modular.get<UsuarioController>();
  final ContagemController contagemController =
      Modular.get<ContagemController>();
  final EstimativasController estimativasController =
      Modular.get<EstimativasController>();
  final ResultadoController resultadoController =
      Modular.get<ResultadoController>();
  final NotificacoesController notificacoesController =
      Modular.get<NotificacoesController>();

  //referente a projetos

  List<ProjetoEntitie> projetos = [];
  List<UsuarioEntity> membrosProjetoAtual = [];
  ListResult? arquivos;
  final RecuperarMembrosUsecase _recuperarMembrosUsecase;
  final RecuperarProjetosUsecase _recuperarProjetosUsecase;
  final CriarProjetoUsecase _criarProjetoUsecase;
  final EntraProjetoUsecase _entraProjetoUsecase;
  final ArquivoUsecase _arquivosUsecase;
  final SairProjetoUsecase _sairProjetoUsecase;

  ProjetoController(
      this._criarProjetoUsecase,
      this._recuperarProjetosUsecase,
      this._recuperarMembrosUsecase,
      this._entraProjetoUsecase,
      this._arquivosUsecase,
      this._sairProjetoUsecase);

  sairProjeto(String uidProjeto, String nomeProjeto) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();

    await _sairProjetoUsecase.sairProjeto(usuarioLogado.store.uid, uidProjeto);
    await recuperarProjetos();
    List<String> uidMembros = [];

    for (var element in membrosProjetoAtual) {
      if (element.uid != usuarioLogado.store.uid) {
        uidMembros.add(element.uid);
      }
    }

    notificacoesController.gerarNotificacao(
        "Você saiu do Projeto: $nomeProjeto.", usuarioLogado.store.uid);

    notificacoesController.notificacoesUsecase.enviarNotificacaoMembros(
        "${usuarioLogado.store.nome} saiu do projeto $nomeProjeto!",
        uidProjeto,
        uidMembros);

    notificacoesController.notificacoesUsecase.enviarNotificacaoMembros(
        "${usuarioLogado.store.nome} saiu do projeto!", uidProjeto, uidMembros);

    return "Você saiu do projeto";
  }

  criarProjeto(String nomeProjeto) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();
    var resultado = await _criarProjetoUsecase.criarProjeto(
        usuarioLogado.store.uid, nomeProjeto, usuarioLogado.store.nome);
    var retorno = "";

    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) async {
      projetos.add(r);
      retorno = "Projeto cadastrado com sucesso!";

      await notificacoesController.gerarNotificacao(
          "Parabéns!! Você criou o projeto $nomeProjeto.",
          Modular.get<UsuarioAutenticado>().store.uid);
    });

    return retorno;
  }

  adicionarDescricaoProjeto(String uidProjeto, String descricao) async {
    var resultado = await _criarProjetoUsecase.adicionarDescricaoProjeto(
        uidProjeto, descricao);
    var retorno = "";

    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      retorno = r;
    });

    return retorno;
  }

  Future entrarProjetos(String uidProjeto) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();
    var resultado = await _entraProjetoUsecase.entrarEmProjeto(
        usuarioLogado.store.uid, uidProjeto);
    String retorno = "";
    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      bool igual = false;
      for (var element in projetos) {
        if (element.uidProjeto == r.uidProjeto) {
          igual = true;
        }
      }

      List<String> uidMembros = [];
      for (var element in membrosProjetoAtual) {
        if (element.uid != usuarioLogado.store.uid) {
          uidMembros.add(element.uid);
        }
      }

      notificacoesController.gerarNotificacao(
          "Você entrou no Projeto: ${r.nomeProjeto}.", usuarioLogado.store.uid);

      notificacoesController.notificacoesUsecase.enviarNotificacaoMembros(
          "${usuarioLogado.store.nome} entrou no projeto ${r.nomeProjeto}!",
          uidProjeto,
          uidMembros);
      !igual ? projetos.add(r) : projetos;
      retorno = "Entrou no projeto!";
    });
    return retorno;
  }

  Future recuperarMembrosProjeto(String uidProjeto) async {
    var resultado = await _recuperarMembrosUsecase.recuperarMembros(uidProjeto);

    var erro = "";

    List<UsuarioEntity> membros = [];
    resultado.fold((l) {
      erro = l.mensagem;
    }, (r) {
      for (var element in projetos) {
        if (element.uidProjeto == uidProjeto) {
          element.membros = r;
          membrosProjetoAtual = r;
        }
      }
    });

    return membrosProjetoAtual;
  }

  Future recuperarProjetos() async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();
    var resultado = await _recuperarProjetosUsecase
        .recuperarProjetos(usuarioLogado.store.uid);

    var erro = "";
    resultado.fold((l) {
      erro = l.mensagem;
    }, (r) {
      projetos = r;
    });

    await notificacoesController.bucaraNotificacoesUsuario();
    return projetos;
  }

  Future fazerDownloadArquivos(
      String uidProjeto, String caminhoDocumento) async {
    final ref = FirebaseStorage.instance.ref(caminhoDocumento);
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final File tempFile =
        File(appDocPath + '/' + caminhoDocumento.split("/").last);
    try {
      await ref.writeToFile(tempFile);
      await tempFile.create();
      await OpenFile.open(tempFile.path);
    } on FirebaseException {
      return "Algo aconteceu";
    }
  }

  Future removerArquivoProjeto(
      ProjetoEntitie projetoEntitie, String nomeArquivo) async {
    if (projetoEntitie.admin == Modular.get<UsuarioAutenticado>().store.uid) {
      await _arquivosUsecase.removerArquivos(
          projetoEntitie.uidProjeto, nomeArquivo);

      arquivos = await recuperarArquivos(projetoEntitie.uidProjeto);

      return "Arquivo removido com sucesso!";
    }

    return "Apenas o adiministrador por deletar arquivos";
  }

  Future<ListResult> recuperarArquivos(String uidProjeto) async {
    var resultado = await _arquivosUsecase.recuperarArquivos(uidProjeto);

    //  var erro = "";
    resultado.fold((l) {
      // erro = l.mensagem;
    }, (r) {
      arquivos = r;
    });

    return arquivos!;
  }

  Future uparArquivos(String uidProjeto, File file) async {
    await _arquivosUsecase.uparArquivos(uidProjeto, file);
  }

  Future recuperarContagem(String nomeContagem, String uidProjeto) async {
    switch (nomeContagem) {
      case "Indicativa":
        return contagemController.contagemIndicativa;
      case "Estimada":
        return contagemController.contagemIndicativa;
      default:
        break;
    }
  }

  Future salvarContagemDetalhada(
      ContagemDetalhadaEntitie contagem, String uidProjeto) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();

    var resultado = contagemController.salvarContagemDetalhada(
        contagem, uidProjeto, usuarioLogado.store.uid);

    return resultado;
  }

  Future salvarContagem(
      String nomeContagem,
      List<IndiceDescricaoContagenModel> alis,
      List<IndiceDescricaoContagenModel> aies,
      List<IndiceDescricaoContagenModel> ce,
      List<IndiceDescricaoContagenModel> ee,
      List<IndiceDescricaoContagenModel> se,
      String uidProjeto,
      int totalPF) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();

    // ignore: prefer_typing_uninitialized_variables
    var resultado;

    switch (nomeContagem) {
      case "Indicativa":
        resultado = await contagemController.salvarContagemIndicativa(
            alis, aies, totalPF, uidProjeto, usuarioLogado.store.uid);
        break;
      case "Estimada":
        resultado = await contagemController.salvarContagemEstimada(aies, alis,
            ce, ee, se, totalPF, uidProjeto, usuarioLogado.store.uid);
        break;
      default:
        resultado = "Algo aconteceu";
    }

    return resultado;
  }

//Modulos externos
  usuarioEditarNome(String nome) async {
    return await usuarioController.alterarNome(nome);
  }

  usuarioEditarEmail(String email) async {
    return await usuarioController.alterarEmail(email);
  }

  usuarioDeslogar() async {
    projetos = [];

    return await usuarioController.deslogar();
  }

  salvarEsforco(EsforcoEntity esforco, String uidProjeto, String uidUsuario,
      String tipoContagem) async {
    return await estimativasController.salvarEsforco(
        esforco, uidProjeto, uidUsuario, tipoContagem);
  }

  salvarPrazp(PrazoEntity prazoEntity, String uidProjeto, String uidUsuario,
      String tipoContagem) async {
    return await estimativasController.salvarPrazo(
        prazoEntity, uidProjeto, uidUsuario, tipoContagem);
  }

  salvarEquipe(EquipeEntity equipeEntity, String uidProjeto, String uidUsuario,
      String tipoContagem) async {
    return await estimativasController.salvarEquipe(
        equipeEntity, uidProjeto, uidUsuario, tipoContagem);
  }

  salvarCusto(CustoEntity custoEntity, String uidProjeto, String uidUsuario,
      String tipoContagem) async {
    return await estimativasController.salvarCusto(
        custoEntity, uidProjeto, uidUsuario, tipoContagem);
  }

  recuperarEstimativa(
      String uidProjeto, String uidUsuario, String estimativa) async {
    switch (estimativa) {
      case "Esforco":
        return await estimativasController.recuperarEsforcos(
            uidProjeto, uidUsuario);
      case "Prazo":
        return await estimativasController.recuperarPrazos(
            uidProjeto, uidUsuario);
      case "Equipe":
        return await estimativasController.recuperarEquipe(
            uidProjeto, uidUsuario);
      case "Custo":
        return await estimativasController.recuperarCusto(
            uidProjeto, uidUsuario);
      default:
    }
  }

  carregarTodosDados(String uidProjeto, String uidUsuario) async {
    await estimativasController.carregarEstimativas(uidProjeto, uidUsuario);
    await contagemController.carregarContagens(uidProjeto, uidUsuario);
    await recuperarMembrosProjeto(uidProjeto);
    await resultadoController.recuperarResultados(uidProjeto);

    return true;
  }
}
