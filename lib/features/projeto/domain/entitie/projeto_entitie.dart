import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';

abstract class ProjetoEntitie {
  String descricao = "";
  final String nomeAdministrador;
  final String uidProjeto;
  final String admin;
  final String dataCriacao;
  final String nomeProjeto;
  List<UsuarioEntity> membros;

  ProjetoEntitie({
    required this.descricao,
    required this.nomeAdministrador,
    required this.uidProjeto,
    required this.admin,
    required this.dataCriacao,
    required this.nomeProjeto,
    required this.membros,
  });
}
