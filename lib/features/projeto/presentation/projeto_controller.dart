import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/domain/usecase/recuperar_membros_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../domain/usecase/criar_projeto_usecase.dart';
import '../domain/usecase/recuperar_projetos_usecase.dart';

class ProjetoController {
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
}
