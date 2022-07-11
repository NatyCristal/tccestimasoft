class EquipeEntity {
  String contagemPontoDeFuncao;
  String uidUsuario = "";
  bool compartilhada;
  String esforco;
  String prazo;
  String producaoDiaria;
  String equipeEstimada;

  EquipeEntity({
    required this.contagemPontoDeFuncao,
    required this.compartilhada,
    required this.esforco,
    required this.prazo,
    required this.producaoDiaria,
    required this.equipeEstimada,
  });
}
