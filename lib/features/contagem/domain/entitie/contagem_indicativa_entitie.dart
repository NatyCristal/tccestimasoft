import 'package:estimasoft/features/contagem/data/model/indice_descricao_contagens_model.dart';

abstract class ContagemIndicativaEntitie {
  String uidUsuario = "";
  bool compartilhada;
  final int totalPf;
  List<IndiceDescricaoContagenModel> ali;

  List<IndiceDescricaoContagenModel> aie;

  ContagemIndicativaEntitie({
    required this.compartilhada,
    required this.totalPf,
    required this.aie,
    required this.ali,
  });
}
