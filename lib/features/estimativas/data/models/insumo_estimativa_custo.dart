import 'package:estimasoft/features/estimativas/domain/entitie/cadastro_insumo_custo_entity.dart';

class InsumoEstimativaCustoModel extends CadastroInsumoCustoEntity {
  InsumoEstimativaCustoModel({required String nome, required String valor})
      : super(nome: nome, valor: valor);

  Map<String, String> toMap() {
    return {
      "Nome": nome,
      'Valor': valor,
    };
  }

  factory InsumoEstimativaCustoModel.fromMap(Map<String, dynamic> map) {
    return InsumoEstimativaCustoModel(
      nome: map["Nome"] ?? "",
      valor: map["Valor"] ?? "",
    );
  }
}
