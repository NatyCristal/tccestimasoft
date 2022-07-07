import 'package:estimasoft/features/contagem/domain/entitie/indice_descricao_contagens.dart';

class IndiceDescricaoContagenModel extends IndiceDescricaoContagens {
  IndiceDescricaoContagenModel(
      {required String complexidade,
      required String nomeFuncao,
      required String descricao,
      required int quantidadePF,
      required String tipoFuncao})
      : super(
          nomeFuncao: nomeFuncao,
          descricao: descricao,
          quantidadePF: quantidadePF,
          tipoFuncao: tipoFuncao,
          complexidade: complexidade,
        );

  Map<String, dynamic> toMap() {
    return {
      "NomeFuncao": nomeFuncao,
      "Descricao": descricao,
      "QuantidadePf": quantidadePF,
      'TipoFuncao': tipoFuncao,
      'Complexidade': complexidade,
    };
  }

  factory IndiceDescricaoContagenModel.fromMap(Map<String, dynamic> map) {
    return IndiceDescricaoContagenModel(
      nomeFuncao: map["NomeFuncao"],
      descricao: map["Descricao"],
      quantidadePF: map["QuantidadePf"],
      tipoFuncao: map["TipoFuncao"],
      complexidade: map["Complexidade"],
    );
  }
}
