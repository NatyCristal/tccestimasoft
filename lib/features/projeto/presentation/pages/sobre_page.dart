import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/link.dart';

import '../../../../core/shared/utils/cores_fontes.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Sobre",
          style: TextStyle(fontSize: tamanhoSubtitulo, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: Container(
        padding: paddingPagePrincipal,
        height: TamanhoTela.height(context, 1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: arredondamentoBordas,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "O EstimaSoft é um trabalho de conclusão de curso que foi desenvolvido para auxiliar a análise de ponto de função",
                      style: TextStyle(
                        color: corTituloTexto,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Guia Prático em Análise ponto de função",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.pushNamed("exibir-pdf");
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              corDeFundoBotaoPrimaria)),
                      child: const Text(
                        "Exibir Guia de Contgem",
                        style: TextStyle(color: corDeTextoBotaoPrimaria),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Link(
                      uri: Uri.parse(
                          'https://www.gov.br/governodigital/pt-br/sisp/documentos/arquivos/guia-de-contagem-de-pontos-de-funcao-do-sisp-para-projetos-dw.pdf'),
                      builder: (context, openLink) => GestureDetector(
                        onTap: openLink,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Referências: ",
                              style: TextStyle(
                                  fontWeight: Fontes.weightTextoNormal),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'https://www.gov.br/governodigital/pt-br/sisp/documentos/arquivos/guia-de-contagem-de-pontos-de-funcao-do-sisp-para-projetos-dw.pdf',
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: paddingPagePrincipal,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: corDeAcao.withOpacity(0.3),
                          borderRadius: arredondamentoBordas),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Desenvolvido por:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Prof. Dr Clayton Viera Fraga Filho\nNatália Soares da Silva"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
