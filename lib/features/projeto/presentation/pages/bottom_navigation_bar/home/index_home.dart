import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/membros/lista_membros.dart';
import 'package:flutter/material.dart';
import 'widgets/exemplo_chart.dart';

class IndexHome extends StatelessWidget {
  final ProjetoEntitie projeto;
  const IndexHome({Key? key, required this.projeto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Membros",
              style: TextStyle(
                  color: corCorpoTexto, fontSize: tamanhoTextoCorpoTexto),
            ),
            ListaMembros(
              projeto: projeto,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Arquivos e Documentos",
              style: TextStyle(
                  color: corCorpoTexto, fontSize: tamanhoTextoCorpoTexto),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 70,
                  width: 60,
                  child: const Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 70,
                  width: 60,
                  child: const Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 70,
                  width: 60,
                  child: const Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 70,
                  width: 60,
                  child: const Icon(
                    Icons.image,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Estimativas Compartilhadas",
              style: TextStyle(
                  color: corCorpoTexto, fontSize: tamanhoTextoCorpoTexto),
            ),
            const SizedBox(
              height: 10,
            ),
            const BarChartSample7()
          ],
        ),
      ),
    );
  }
}
