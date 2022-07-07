import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class CardAdicaoContagemExpanded extends StatelessWidget {
  final String complexidade;
  final String nomeFuncao;
  final String descricao;
  final int quantidadePf;
  const CardAdicaoContagemExpanded(
      {Key? key,
      required this.nomeFuncao,
      required this.descricao,
      required this.quantidadePf,
      this.complexidade = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nomeFuncao),
              Text(quantidadePf.toString() + " PF"),
            ],
          ),
        ),
        collapsed: const Text("TEstes"),
        expanded: Text(" asdasd asd as a sd a ASDASDAS a asdSDAS Aa dasd "),
      ),
    );
  }
}
