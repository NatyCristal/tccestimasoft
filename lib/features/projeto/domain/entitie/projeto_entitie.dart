import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';

abstract class ProjetoEntitie {
  final String nomeAdministrador;
  final String uidProjeto;
  final String admin;
  final String dataCriacao;
  final String nomeProjeto;
  List<UsuarioEntitie> membros;

  ProjetoEntitie({
    required this.nomeAdministrador,
    required this.uidProjeto,
    required this.admin,
    required this.dataCriacao,
    required this.nomeProjeto,
    required this.membros,
  });
}
