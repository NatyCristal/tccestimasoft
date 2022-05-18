import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/data/model/projeto_firebase_model.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';

abstract class ProjetoDatasource {
  Future<List<ProjetoFirebaseModel>> recuperarProjetos(String uid);

  Future<ProjetoEntitie> criarProjeto(String uidUsuario, String nomeProjeto);

  Future removerProjeto(String uidUsuario, String uidProjeto);

  Future sairProjeto(String uidUsuario, String uidProjeto);

  Future entrarEmProjeto(
    String uidProjeto,
  );

  Future<List<UsuarioEntitie>> recuperarMembrosProjeto(String uidProjeto);
}
