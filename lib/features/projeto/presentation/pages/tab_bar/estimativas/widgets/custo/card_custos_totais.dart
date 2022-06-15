import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CardCustosTotais extends StatelessWidget {
  final StoreEstimativaCusto storeEstimativaCusto;
  const CardCustosTotais({Key? key, required this.storeEstimativaCusto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: corDeFundoBotaoSecundaria, borderRadius: arredondamentoBordas),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Custo total do projeto",
                style: TextStyle(
                    fontSize: tamanhoSubtitulo,
                    color: corTituloTexto,
                    fontWeight: Fontes.weightTextoNormal),
              ),
              Observer(builder: (context) {
                return Text(
                  "${storeEstimativaCusto.custoProjeto.toString()} R\$",
                  style: const TextStyle(
                    fontSize: tamanhoSubtitulo,
                    color: corTituloTexto,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Valor total do projeto",
                style: TextStyle(
                    fontSize: tamanhoSubtitulo,
                    color: corTituloTexto,
                    fontWeight: Fontes.weightTextoNormal),
              ),
              Observer(builder: (context) {
                return Text(
                  "${storeEstimativaCusto.valorTotalProjeto.toString()} R\$",
                  style: const TextStyle(
                    fontSize: tamanhoSubtitulo,
                    color: corTituloTexto,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
