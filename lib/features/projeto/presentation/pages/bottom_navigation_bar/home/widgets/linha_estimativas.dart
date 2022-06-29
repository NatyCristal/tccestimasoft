import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/widgets.dart';

class LinhaEstimativas extends StatelessWidget {
  final bool quantidadeLinhas;
  final String nome;
  final String resultado;
  const LinhaEstimativas(
      {Key? key,
      required this.nome,
      required this.resultado,
      this.quantidadeLinhas = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              nome,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: corCorpoTexto),
            ),
          ),
          !quantidadeLinhas
              ? SizedBox(
                  width: 180,
                  child: Text(
                    resultado,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: corTituloTexto.withOpacity(0.8)),
                  ),
                )
              : SizedBox(
                  width: 180,
                  child: Text(
                    resultado,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: corTituloTexto.withOpacity(0.8)),
                  ),
                ),
        ],
      ),
    );
  }
}
