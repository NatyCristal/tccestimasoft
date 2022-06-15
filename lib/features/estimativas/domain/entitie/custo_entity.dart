class CustoEntity {
  Map<String, String> equipe;
  Map<String, String> custosVariaisFixos;

  String disponibilidadeEquipe;
  String custoTotalMensal;
  double custoHora;
  String custoPF;
  String porcentagemLucro;
  double custoTotalProjeto;
  double valorTotalProjeto;

  CustoEntity({
    required this.equipe,
    required this.custosVariaisFixos,
    required this.disponibilidadeEquipe,
    required this.custoTotalMensal,
    required this.custoHora,
    required this.porcentagemLucro,
    required this.custoTotalProjeto,
    required this.valorTotalProjeto,
    required this.custoPF,
  });
}
