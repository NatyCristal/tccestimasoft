import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';

abstract class PerfilDatasource {
  Future alterarEmail(String email);

  Future alterarNome(String nome);

  Future signOut();

  Future vincularProjetoUsuario(String uidProjeto, String uidUsuario);

  Future<List<String>> recuperarListaDeProjetos(String uidUsuario);

  Future<List<UsuarioEntity>> recuperarMembros(List<String> uidUsuarios);

  UsuarioEntity usuarioLogado();

  Future removerProjetoUsuario(String uidUsuario, String uidProjeto);
}
