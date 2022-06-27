class ContagemEstimadaEntitie {
  String uidUsuario = "";
  bool compartilhada;
  final List<String> aie;
  final List<String> ali;
  final List<String> ee;
  final List<String> ce;
  final List<String> se;

  final int totalPF;

  ContagemEstimadaEntitie(
      {required this.compartilhada,
      required this.ali,
      required this.aie,
      required this.ee,
      required this.ce,
      required this.se,
      required this.totalPF});
}
