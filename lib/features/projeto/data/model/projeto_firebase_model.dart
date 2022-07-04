import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import '../../domain/entitie/projeto_entitie.dart';

class ProjetoFirebaseModel extends ProjetoEntitie {
  ProjetoFirebaseModel({
    requerid,
    nomeAdminstrador,
    required dataCriacao,
    required nomeProjeto,
    required membros,
    required admin,
    required uidProjeto,
  }) : super(
          nomeAdministrador: nomeAdminstrador,
          admin: admin,
          nomeProjeto: nomeProjeto,
          membros: membros,
          dataCriacao: dataCriacao,
          uidProjeto: uidProjeto,
        );

  Map<String, dynamic> toMap() {
    return {
      "nomeAdministrador": nomeAdministrador,
      "admin": admin,
      'nomeProjeto': nomeProjeto,
      'dataCriacao': dataCriacao,
      "membros": [membros[0].uid],
    };
  }

  factory ProjetoFirebaseModel.fromMap(
      Map<String, dynamic> map, String projetoUid) {
    List<UsuarioEntitie> membros = [];
    return ProjetoFirebaseModel(
        nomeAdminstrador: map["nomeAdministrador"] ?? "",
        uidProjeto: projetoUid,
        admin: map["admin"],
        nomeProjeto: map['nomeProjeto'],
        dataCriacao: map['dataCriacao'],
        membros: membros);
  }
}
