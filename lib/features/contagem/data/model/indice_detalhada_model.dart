import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';

class IndiceDetalhadaModel extends IndiceDetalhada {
  IndiceDetalhadaModel(
      {required int pontoFuncao,
      required String complexidade,
      required String nome,
      required String tipo,
      required int quantidadeTRs,
      required int quantidadeTdsEArs})
      : super(
            pontoDeFuncao: pontoFuncao,
            complexidade: complexidade,
            nome: nome,
            tipo: tipo,
            quantidadeTRs: quantidadeTRs,
            quantidadeTrsEArs: quantidadeTdsEArs);

  Map<String, dynamic> toMap() {
    return {
      "PontoFuncao": pontoDeFuncao,
      "Complexidade": complexidade,
      "Nome": nome,
      'Tipo': tipo,
      'QuantidadeTRs': quantidadeTRs,
      'QuantidadeTDsARs': quantidadeTrsEArs,
    };
  }

  factory IndiceDetalhadaModel.fromMap(Map<String, dynamic> map) {
    return IndiceDetalhadaModel(
      pontoFuncao: map["PontoDeFuncao"],
      complexidade: map["Complexidade"],
      nome: map['Nome'],
      tipo: map["Tipo"],
      quantidadeTRs: map["QuantidadeTRs"],
      quantidadeTdsEArs: map["QuantidadeTDsARs"],
    );
  }
}
