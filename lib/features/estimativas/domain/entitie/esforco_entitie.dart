class EsforcoEntity {
  bool compartilhada = false;
  String contagemPontoDeFuncao;
  String linguagem;
  String produtividadeEquipe;
  String esforcoTotal;

  EsforcoEntity({
    required this.compartilhada,
    required this.contagemPontoDeFuncao,
    required this.linguagem,
    required this.produtividadeEquipe,
    required this.esforcoTotal,
  });

  split(String s) {}
}
