import 'package:estimasoft/core/shared/utils/formatadores.dart';

class CadastroInsumoCustoEntity {
  String nome;
  String valor;

  CadastroInsumoCustoEntity({
    required this.nome,
    required this.valor,
  });

  @override
  String toString() => '$nome - ${Formatadores.formatadorMonetario(valor)}';
}
