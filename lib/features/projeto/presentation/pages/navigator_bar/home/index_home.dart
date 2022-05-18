import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/membros/lista_membros.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IndexHome extends StatelessWidget {
  final ProjetoEntitie projeto;
  const IndexHome({Key? key, required this.projeto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      width: double.infinity,
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
            "Arquivos do projeto",
            style: TextStyle(
                color: corCorpoTexto, fontSize: tamanhoTextoCorpoTexto),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 70,
                width: 60,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 70,
                width: 60,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 70,
                width: 60,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 70,
                width: 60,
                color: Colors.blue,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Estivativas Compartilhadas",
            style: TextStyle(
                color: corCorpoTexto, fontSize: tamanhoTextoCorpoTexto),
          ),
          SizedBox(
            height: 80,
          ),
          const Text(
            "Uau que estimativa grande",
            style:
                TextStyle(color: corCorpoTexto, fontSize: tamanhoTextoTitulo),
          )
        ],
      ),
    );
  }
}
