import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';

class ContagemEstimadaEntitie {
  String uidUsuario = "";
  bool compartilhada;
  final List<IndiceDescricaoContagenModel> aie;
  final List<IndiceDescricaoContagenModel> ali;
  final List<IndiceDescricaoContagenModel> ee;
  final List<IndiceDescricaoContagenModel> ce;
  final List<IndiceDescricaoContagenModel> se;

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
