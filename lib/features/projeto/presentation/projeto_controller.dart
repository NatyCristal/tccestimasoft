import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/features/contagem/contagem_controller.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/domain/usecase/entrar_projeto_usecase.dart';
import 'package:estimasoft/features/projeto/domain/usecase/recuperar_membros_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../usuario/presentation/usuario_controller.dart';
import '../domain/usecase/criar_projeto_usecase.dart';
import '../domain/usecase/recuperar_projetos_usecase.dart';

class ProjetoController {
  //Modulos externos
  final UsuarioController usuarioController = Modular.get<UsuarioController>();
  final ContagemController contagemController =
      Modular.get<ContagemController>();

  //referente a projetos

  List<ProjetoEntitie> projetos = [];
  List<UsuarioEntitie> membrosProjetoAtual = [];
  final RecuperarMembrosUsecase _recuperarMembrosUsecase;
  final RecuperarProjetosUsecase _recuperarProjetosUsecase;
  final CriarProjetoUsecase _criarProjetoUsecase;
  final EntraProjetoUsecase _entraProjetoUsecase;

  ProjetoController(this._criarProjetoUsecase, this._recuperarProjetosUsecase,
      this._recuperarMembrosUsecase, this._entraProjetoUsecase);

  criarProjeto(String nomeProjeto) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();
    var resultado = await _criarProjetoUsecase.criarProjeto(
        usuarioLogado.store.uid, nomeProjeto);
    var retorno = "";

    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      projetos.add(r);
      retorno = "Projeto cadastrado com sucesso!";
    });

    return retorno;
  }

  Future entrarProjetos(String uidProjeto) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();
    var resultado = await _entraProjetoUsecase.entrarEmProjeto(
        usuarioLogado.store.uid, uidProjeto);
    var retorno = "";
    resultado.fold((l) {
      retorno = l.mensagem;
    }, (r) {
      bool igual = false;
      for (var element in projetos) {
        if (element.uidProjeto == r.uidProjeto) {
          igual = true;
        }
      }

      !igual ? projetos.add(r) : projetos;
      retorno = "Entrou no projeto!";
    });
    return retorno;
  }

  Future recuperarMembrosProjeto(String uidProjeto) async {
    var resultado = await _recuperarMembrosUsecase.recuperarMembros(uidProjeto);
    var erro = "";
    List<UsuarioEntitie> membros = [];
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

    // if (resultado.isLeft) {
    //   return Left(erro);
    // }

    return projetos;
  }

  Future recuperarContagem(String nomeContagem, String uidProjeto) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();

    switch (nomeContagem) {
      case "Indicativa":
        return await contagemController.recuperarContagemIndicativa(
            uidProjeto, usuarioLogado.store.uid);
      case "Estimada":
        return await contagemController.recuperarContagemEstimada(
            uidProjeto, usuarioLogado.store.uid);
      default:
        break;
    }
  }

  Future salvarContagem(
      String nomeContagem,
      List<String> alis,
      List<String> aies,
      List<String> ce,
      List<String> ee,
      List<String> se,
      String uidProjeto,
      int totalPF) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();

    var resultado;

    switch (nomeContagem) {
      case "Indicativa":
        resultado = await contagemController.salvarContagemIndicativa(
            alis, aies, totalPF, uidProjeto, usuarioLogado.store.uid);
        break;
      case "Estimada":
        resultado = await contagemController.salvarContagemEstimada(
            ce, ee, se, totalPF, uidProjeto, usuarioLogado.store.uid);
        break;
      default:
        resultado = "Algo aconteceu";
    }

    return resultado;
  }

  usuarioEditarNome(String nome) async {
    return await usuarioController.alterarNome(nome);
  }

  usuarioEditarEmail(String email) async {
    return await usuarioController.alterarEmail(email);
  }

  usuarioDeslogar() async {
    projetos = [];

    return await usuarioController.deslogar();
    // Modular.to.popAndPushNamed("/login/");
  }
}
