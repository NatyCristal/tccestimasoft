import 'package:estimasoft/features/contagem/data/model/indice_detalhada_model.dart';

class ContagemDetalhadaEntitie {
  String uidUsuario = "";
  bool compartilhada;
  List<IndiceDetalhadaModel> funcaoDados;
  List<IndiceDetalhadaModel> funcaoTransacional;
  int totalPf;
  int totalFuncaoDados;
  int totalFuncaoTransacional;

  ContagemDetalhadaEntitie({
    required this.compartilhada,
    required this.funcaoDados,
    required this.funcaoTransacional,
    required this.totalPf,
    required this.totalFuncaoDados,
    required this.totalFuncaoTransacional,
  });
}
