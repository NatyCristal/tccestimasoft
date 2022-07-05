import '../repository/projeto_repository.dart';

class SairProjetoUsecase {
  final ProjetoRepository repository;

  SairProjetoUsecase(this.repository);

  Future sairProjeto(String uidUsuario, String uidProjeto) async {
    await repository.sairProjeto(uidUsuario, uidProjeto);
  }
}
