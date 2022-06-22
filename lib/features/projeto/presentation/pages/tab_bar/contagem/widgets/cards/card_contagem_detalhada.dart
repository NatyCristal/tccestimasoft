import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/componentes/spin_box.dart';
import 'package:flutter/material.dart';

class ContagemDetalhadaCard extends StatelessWidget {
  final StoreContagemDetalhada store;
  final IndiceDetalhada indiceDetalhada;
  const ContagemDetalhadaCard({
    Key? key,
    required this.store,
    required this.indiceDetalhada,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  indiceDetalhada.nome,
                  style: const TextStyle(color: corCorpoTexto),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  indiceDetalhada.tipo,
                  style: const TextStyle(color: corCorpoTexto),
                ),
              ),
              SizedBox(
                width: 130,
                child: SpinBox(
                  valorAlterado: indiceDetalhada.quantidadeTrsEArs,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  width: 130,
                  child: SpinBox(
                    valorAlterado: indiceDetalhada.quantidadeTRs,
                  )),
            ],
          ),
        ),
        const Divider(thickness: 0.5, color: corDeLinhaAppBar),
      ],
    );
  }
}
