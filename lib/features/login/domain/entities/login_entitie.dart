abstract class UsuarioEntity {
  String nome;
  String email;
  String uid;
  String urlFoto;

  UsuarioEntity({
    required this.nome,
    required this.email,
    required this.uid,
    required this.urlFoto,
  });
}
