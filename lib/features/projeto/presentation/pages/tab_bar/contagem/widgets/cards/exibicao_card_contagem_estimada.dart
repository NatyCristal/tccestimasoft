import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExibicaoCardEstimada extends StatelessWidget {
  final String nome;

  final String tipo;
  final String complexidade;
  final int pontoDeFuncao;
  final String descricao;
  const ExibicaoCardEstimada(
      {Key? key,
      required this.nome,
      required this.tipo,
      required this.complexidade,
      required this.pontoDeFuncao,
      required this.descricao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFBF7D4),
      child: ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nome: $nome",
              ),
              Text(
                "Tipo: $tipo",
              ),
            ],
          ),
        ),
        collapsed: const Text(""),
        expanded: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Descrição: $descricao",
              ),
              Text("Complexidade: $complexidade"),
              Text("Ponto de função: $pontoDeFuncao"),
            ],
          ),
        ),
      ),
    );
  }
}
