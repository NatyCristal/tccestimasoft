import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';

class CardAdicaoContagem extends StatelessWidget {
  final String descricao;
  final Function remover;
  final Function editar;
  final String complexidade;

  final String nomeFuncao;
  final int pontosDeFuncao;
  final String tipoFuncao;
  final bool ehExibicao;
  const CardAdicaoContagem(
      {Key? key,
      required this.nomeFuncao,
      required this.pontosDeFuncao,
      required this.tipoFuncao,
      this.ehExibicao = false,
      this.complexidade = "default",
      required this.remover,
      required this.editar,
      required this.descricao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ehExibicao
            ? Colors.grey.withOpacity(0.2)
            : Colors.blue.withOpacity(0.3),
        borderRadius: arredondamentoBordas,
      ),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: TamanhoTela.width(context, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: TamanhoTela.width(context, 0.6),
                    child: Text(
                      "Nome:   $nomeFuncao",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ehExibicao ? Colors.grey : corTituloTexto,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: TamanhoTela.width(context, 0.6),
                    child: Text(
                      "Descrição:   $descricao",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ehExibicao ? Colors.grey : corTituloTexto,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 220,
                    child: Text(
                      "Pontos:   ${pontosDeFuncao.toString()} PF",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: ehExibicao ? Colors.grey : corTituloTexto,
                      ),
                    ),
                  ),
                ],
              ),
              complexidade != "default"
                  ? Row(
                      children: [
                        SizedBox(
                          width: 220,
                          child: Text(
                            "Complexidade:  $complexidade",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ehExibicao ? Colors.grey : corTituloTexto,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(
                      width: 220,
                      child: Text(
                        "Complexidade:  Baixa",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: corTituloTexto,
                        ),
                      ),
                    ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => editar(),
                child: ehExibicao
                    ? const SizedBox()
                    : const SizedBox(
                        width: 40,
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.black38,
                        ),
                      ),
              ),
              ehExibicao
                  ? const SizedBox(
                      width: 40,
                      child: Icon(
                        Icons.lock,
                        size: 20,
                        color: Colors.black38,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => remover(),
                      child: const SizedBox(
                        width: 40,
                        child: Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.black38,
                        ),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
