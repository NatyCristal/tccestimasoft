class PrazoEntity {
  String uidUsuario = "";
  bool compartilhada;
  String contagemPontoDeFuncao;
  String tipoSistema;
  double prazoTotal;
  String prazoMinimo;

  PrazoEntity({
    required this.compartilhada,
    required this.contagemPontoDeFuncao,
    required this.tipoSistema,
    required this.prazoTotal,
    required this.prazoMinimo,
  });
}
