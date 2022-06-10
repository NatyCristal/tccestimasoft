import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/componentes/spin_box.dart';
import 'package:flutter/material.dart';

class ContagemDetalhadaCard extends StatelessWidget {
  final ScrollController scrollController;
  final String nomeDaFuncao;
  final String tipoFuncao;
  const ContagemDetalhadaCard(
      {Key? key,
      required this.tipoFuncao,
      required this.nomeDaFuncao,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: TamanhoTela.width(context, 1),
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  nomeDaFuncao,
                  style: const TextStyle(color: corCorpoTexto),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  tipoFuncao,
                  style: const TextStyle(color: corCorpoTexto),
                ),
              ),
              SizedBox(
                width: 130,
                child: SpinBox(
                    tipoFuncao: tipoFuncao, scrollController: scrollController),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 130,
                child: SpinBox(
                    tipoFuncao: tipoFuncao, scrollController: scrollController),
              ),
            ],
          ),
        ),
        SizedBox(
          width: TamanhoTela.width(context, 1),
          child: const Divider(thickness: 0.5, color: corCorpoTexto),
        ),
      ],
    );
  }
}
