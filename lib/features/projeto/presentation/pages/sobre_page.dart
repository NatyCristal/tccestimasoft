import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';
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
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: arredondamentoBordas,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "O Estimasoft é o resultado de um Trabalho de Conclusão de Curso (TCC) em Sistemas de Informação pela Universidade Federal do Espírito Santo.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: corTituloTexto,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/imagens/logo_ufes_2.png"),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  "Natália Soares da Silva\nProf. Dr. Clayton Viera Fraga Filho"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              SizedBox(
                child: Link(
                  uri: Uri.parse(
                      'https://www.gov.br/governodigital/pt-br/sisp/documentos/arquivos/guia-de-contagem-de-pontos-de-funcao-do-sisp-para-projetos-dw.pdf'),
                  builder: (context, openLink) => GestureDetector(
                    onTap: openLink,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Referências: ",
                          style:
                              TextStyle(fontWeight: Fontes.weightTextoNormal),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
