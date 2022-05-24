import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/features/contagem/contagem_controller.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
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

  ProjetoController(this._criarProjetoUsecase, this._recuperarProjetosUsecase,
      this._recuperarMembrosUsecase);

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

      default:
    }
  }

  Future salvarContagem(String nomeContagem, List<String> alis,
      List<String> aies, String uidProjeto, int totalPF) async {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();

    var resultado;

    switch (nomeContagem) {
      case "Indicativa":
        resultado = await contagemController.salvarContagemIndicativa(
            alis, aies, totalPF, uidProjeto, usuarioLogado.store.uid);

        break;
      default:
        resultado = "Algo aconteceu";
    }

    return resultado;
  }

  usuarioDeslogar() async {
    return await usuarioController.deslogar();
  }
}
