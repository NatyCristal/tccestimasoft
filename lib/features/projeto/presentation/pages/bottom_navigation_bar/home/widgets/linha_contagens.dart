import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/widgets.dart';

class LinhaContagens extends StatelessWidget {
  final String nome;
  final String resultado;
  final String complexidade;
  const LinhaContagens(
      {Key? key,
      required this.nome,
      required this.resultado,
      required this.complexidade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 80,
          child: Text(
            nome,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: corCorpoTexto),
          ),
        ),
        SizedBox(
          width: 160,
          child: Text(
            resultado,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: corTituloTexto.withOpacity(0.8)),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            complexidade,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: corTituloTexto.withOpacity(0.8)),
          ),
        ),
      ]),
    );
  }
}
