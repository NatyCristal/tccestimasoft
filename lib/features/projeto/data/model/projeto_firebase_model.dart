import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import '../../domain/entitie/projeto_entitie.dart';

class ProjetoFirebaseModel extends ProjetoEntitie {
  ProjetoFirebaseModel({
    required descricao,
    required nomeAdminstrador,
    required dataCriacao,
    required nomeProjeto,
    required membros,
    required admin,
    required uidProjeto,
  }) : super(
          descricao: descricao,
          nomeAdministrador: nomeAdminstrador,
          admin: admin,
          nomeProjeto: nomeProjeto,
          membros: membros,
          dataCriacao: dataCriacao,
          uidProjeto: uidProjeto,
        );

  Map<String, dynamic> toMap() {
    return {
      "descricao": descricao,
      "nomeAdministrador": nomeAdministrador,
      "admin": admin,
      'nomeProjeto': nomeProjeto,
      'dataCriacao': dataCriacao,
      "membros": [membros[0].uid],
    };
  }

  factory ProjetoFirebaseModel.fromMap(
      Map<String, dynamic> map, String projetoUid) {
    List<UsuarioEntity> membros = [];
    return ProjetoFirebaseModel(
        descricao: map["descricao"] ?? "",
        nomeAdminstrador: map["nomeAdministrador"] ?? "",
        uidProjeto: projetoUid,
        admin: map["admin"],
        nomeProjeto: map['nomeProjeto'],
        dataCriacao: map['dataCriacao'],
        membros: membros);
  }
}
