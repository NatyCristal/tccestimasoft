abstract class ContagemIndicativaEntitie {
  bool compartilhada;
  final int totalPf;
  final List<String> aie;
  final List<String> ali;

  ContagemIndicativaEntitie({
    required this.compartilhada,
    required this.totalPf,
    required this.aie,
    required this.ali,
  });
}
