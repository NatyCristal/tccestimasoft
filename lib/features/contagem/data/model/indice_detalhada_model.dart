import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';

class IndiceDetalhadaModel extends IndiceDetalhada {
  IndiceDetalhadaModel(
      {required String descricao,
      required int pontoFuncao,
      required String complexidade,
      required String nome,
      required String tipo,
      required int quantidadeTRs,
      required int quantidadeTrsEArs})
      : super(
            descricao: descricao,
            pontoDeFuncao: pontoFuncao,
            complexidade: complexidade,
            nome: nome,
            tipo: tipo,
            quantidadeTDs: quantidadeTRs,
            quantidadeTrsEArs: quantidadeTrsEArs);

  Map<String, dynamic> toMap() {
    return {
      "Descricao": descricao,
      "PontoFuncao": pontoDeFuncao,
      "Complexidade": complexidade,
      "Nome": nome,
      'Tipo': tipo,
      'QuantidadeTRs': quantidadeTDs,
      'QuantidadeTDsARs': quantidadeTrsEArs,
    };
  }

  factory IndiceDetalhadaModel.fromMap(Map<String, dynamic> map) {
    return IndiceDetalhadaModel(
      descricao: map["Descricao"] ?? "",
      pontoFuncao: map["PontoFuncao"],
      complexidade: map["Complexidade"],
      nome: map['Nome'],
      tipo: map["Tipo"],
      quantidadeTRs: map["QuantidadeTRs"],
      quantidadeTrsEArs: map["QuantidadeTDsARs"],
    );
  }
}
