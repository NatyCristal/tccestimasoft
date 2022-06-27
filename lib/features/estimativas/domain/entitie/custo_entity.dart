import 'package:estimasoft/features/estimativas/data/models/insumo_estimativa_custo.dart';

class CustoEntity {
  String uidUsuario = "";
  bool compartilhada;
  String tipoContagem;
  List<InsumoEstimativaCustoModel> equipe;

  List<InsumoEstimativaCustoModel> custosVariaisFixos;

  String disponibilidadeEquipe;
  String custoTotalMensal;
  double custoHora;
  String custoPF;
  String porcentagemLucro;
  double custoTotalProjeto;
  double valorTotalProjeto;

  CustoEntity({
    required this.compartilhada,
    required this.tipoContagem,
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
