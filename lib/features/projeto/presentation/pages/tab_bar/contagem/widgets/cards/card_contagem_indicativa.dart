import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:flutter/material.dart';

class CardContagemIndicativa extends StatelessWidget {
  final StoreContagemIndicativa store;
  final String nomeFuncao;
  final int pontosDeFuncao;
  final String tipoFuncao;
  const CardContagemIndicativa(
      {Key? key,
      required this.nomeFuncao,
      required this.pontosDeFuncao,
      required this.store,
      required this.tipoFuncao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        borderRadius: arredondamentoBordas,
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: TamanhoTela.width(context, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 220,
                    child: Text(
                      "Nome:   $nomeFuncao",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: corTituloTexto,
                      ),
                    ),
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
                      style: const TextStyle(
                        color: corTituloTexto,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  store.editar(nomeFuncao, tipoFuncao);
                },
                child: const SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.black38,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  store.removerFuncao(nomeFuncao, tipoFuncao);
                },
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
