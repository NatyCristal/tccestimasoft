import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InformacoesInstrucoesPage extends StatefulWidget {
  const InformacoesInstrucoesPage({Key? key}) : super(key: key);

  @override
  State<InformacoesInstrucoesPage> createState() =>
      _InformacoesInstrucoesPageState();
}

class _InformacoesInstrucoesPageState extends State<InformacoesInstrucoesPage> {
  final controller = PageController();
  bool ehUltimaPagina = false;

  final scrolcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: TamanhoTela.height(context, 1),
        width: TamanhoTela.width(context, 1),
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() => ehUltimaPagina = index == 4);
          },
          controller: controller,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60),
              color: Colors.blue,
              child: SingleChildScrollView(
                controller: scrolcontroller,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          // style: ButtonStyle(
                          //     backgroundColor: MaterialStateProperty.all(
                          //         corDeAcao.withOpacity(0.1))),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (prefs.getBool('naoExibirNovamente') == true) {
                              Modular.to.canPop();
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            } else {
                              prefs.setBool('naoExibirNovamente', true);
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            }
                          },
                          child: const Text(
                            "N??o exibir novamente",
                            style: TextStyle(color: corDeAcao),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 320,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/imagens/informativo/contagem_pf.jpg"),
                                fit: BoxFit.cover)),
                        child: const Text(
                          "Contagem Ponto de Fun????o",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: arredondamentoBordas),
                        padding: paddingPagePrincipal,
                        child: SingleChildScrollView(
                          controller: scrolcontroller,
                          child: Column(
                            children: [
                              Text(
                                "A m??trica PF mede o tamanho funcional de um projeto de software, considerando a vis??o do usu??rio. \nO tamanho funcional ?? definido por meio dos requisitos funcionais do usu??rio. A an??lise de Pontos de Fun????o (APF) ?? o m??todo padr??o para a medi????o de projetos de desenvolvimento. \n\nTem como objetivo medir o que o software faz por meio de uma avalia????o padronizada dos requisitos do sistema.",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: corTituloTexto.withOpacity(0.8)),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: TamanhoTela.height(context, 1),
              padding: const EdgeInsets.only(top: 60),
              color: Colors.greenAccent,
              child: SingleChildScrollView(
                controller: scrolcontroller,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          // style: ButtonStyle(
                          //     backgroundColor: MaterialStateProperty.all(
                          //         corDeAcao.withOpacity(0.1))),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (prefs.getBool('naoExibirNovamente') == true) {
                              Modular.to.canPop();
                              Modular.to.pushNamed(
                                "exibicao-projetos",
                              );
                            } else {
                              prefs.setBool('naoExibirNovamente', true);
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            }
                          },
                          child: const Text(
                            "N??o exibir novamente",
                            style: TextStyle(color: corDeAcao),
                          ),
                        ),
                      ),
                      const Text(
                        "Procedimento de contagem de Pontos de fun????o",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 320,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/imagens/informativo/fluxo_contagem_pf.png"),
                                fit: BoxFit.contain)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.1),
                            borderRadius: arredondamentoBordas),
                        padding: paddingPagePrincipal,
                        child: Column(
                          children: [
                            Text(
                              "A figura acima ilustra o procedimento de contagem de pontos de fun????o descrito nas se????es seguintes.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: TamanhoTela.height(context, 1),
              padding: const EdgeInsets.only(top: 60),
              color: Colors.cyan,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: scrolcontroller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          // style: ButtonStyle(
                          //     backgroundColor: MaterialStateProperty.all(
                          //         corDeAcao.withOpacity(0.1))),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (prefs.getBool('naoExibirNovamente') == true) {
                              Modular.to.canPop();
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            } else {
                              prefs.setBool('naoExibirNovamente', true);
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            }
                          },
                          child: const Text(
                            "N??o exibir novamente",
                            style: TextStyle(color: corDeAcao),
                          ),
                        ),
                      ),
                      const Text(
                        "Fun????es de dados",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 320,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/imagens/informativo/funcao_dados_pf.jpg"),
                                fit: BoxFit.contain)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.cyan.withOpacity(0.1),
                            borderRadius: arredondamentoBordas),
                        padding: paddingPagePrincipal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Arquivo L??gico Interno (ALI)",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "S??o grupos de dados que s??o mantidos pelo sistema e relacionados logicamente. ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Arquivo de Interface Externa (AIE)",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "S??o grupos de dados que s??o referenciados pelo sistema (dados de outra aplica????o) e relacionados logicamente.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: TamanhoTela.height(context, 1),
              padding: const EdgeInsets.only(top: 60),
              color: Colors.orange,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: scrolcontroller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          // style: ButtonStyle(
                          //     backgroundColor: MaterialStateProperty.all(
                          //         corDeAcao.withOpacity(0.1))),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (prefs.getBool('naoExibirNovamente') == true) {
                              Modular.to.canPop();
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            } else {
                              prefs.setBool('naoExibirNovamente', true);
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            }
                          },
                          child: const Text(
                            "N??o exibir novamente",
                            style: TextStyle(color: corDeAcao),
                          ),
                        ),
                      ),
                      const Text(
                        "Fun????o Transacional",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 350,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/imagens/informativo/funcao_transacional_pf.jpg"),
                                fit: BoxFit.contain)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: arredondamentoBordas),
                        padding: paddingPagePrincipal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Entrada Externa (EE)",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Uma entrada externa trata-se de um processo elementar. Ele processa dados ou informa????es de controle, que v??m de fora da fronteira da aplica????o. ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Consulta Externa (CE)",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "?? apresentar informa????es ao usu??rio atrav??s da recupera????o de dados ou das informa????es de controle. A l??gica de processamento n??o cont??m f??rmula matem??tica ou c??lculo, nem cria dado derivado.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Sa??da Externa (SE)",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Uma sa??da externa apresenta informa????es ao usu??rio atrav??s de l??gica de processamento que n??o seja somente recupera????o de dados ou informa????es de controle.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: TamanhoTela.height(context, 1),
              padding: const EdgeInsets.only(top: 60),
              color: Colors.red,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: scrolcontroller,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            if (prefs.getBool('naoExibirNovamente') == true) {
                              Modular.to.canPop();
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            } else {
                              prefs.setBool('naoExibirNovamente', true);
                              Modular.to.pushNamedAndRemoveUntil(
                                  "/projeto/exibicao-projetos",
                                  (Route<dynamic> route) => false);
                            }
                          },
                          child: const Text(
                            "N??o exibir novamente",
                            style: TextStyle(color: corDeAcao),
                          ),
                        ),
                      ),
                      const Text(
                        "Contagens",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 350,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/imagens/informativo/contagens.jpg"),
                                fit: BoxFit.contain)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: arredondamentoBordas),
                        padding: paddingPagePrincipal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Indicativa",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "A contagem indicativa ?? determinada pela quantidade das fun????es do tipo dado (ALIs e AIEs)",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Estimada",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Para realizar uma contagem estimativa s??o necess??rias informa????es a respeito das fun????es transacionais (EEs, CEs e SEs), sendo necess??rio requisitos mais detalhados.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Detalhada",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "A contagem detalhada ?? a contagem usual de pontos de fun????o e ?? realizada da ap??s determinar todas as fun????es de todos os tipos (ALI, AIE, EE, SE, CE).\nDetermina-se a complexidade de cada fun????o (Baixa, M??dia, Alta);",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: corTituloTexto.withOpacity(0.8)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                                "Para mais detalhes, clique para exibir o guia de contagem",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  Modular.to.pushNamed("exibir-pdf");
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        corDeFundoBotaoPrimaria)),
                                child: const Text(
                                  "Exibir Guia de Contgems",
                                  style:
                                      TextStyle(color: corDeTextoBotaoPrimaria),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: ehUltimaPagina
          ? TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                if (prefs.getBool('naoExibirNovamente') == true) {
                  Modular.to.canPop();
                  Modular.to.pushNamedAndRemoveUntil(
                      "/projeto/exibicao-projetos",
                      (Route<dynamic> route) => false);
                } else {
                  Modular.to.pushNamedAndRemoveUntil(
                      "/projeto/exibicao-projetos",
                      (Route<dynamic> route) => false);
                }
              },
              child: const Text(
                "VAMOS L??",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Modular.to.canPop();
                      Modular.to.pushNamedAndRemoveUntil(
                          "/projeto/exibicao-projetos",
                          (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      "PULAR",
                      style: TextStyle(color: corDeAcao),
                    ),
                  ),
                  Center(
                      child: SmoothPageIndicator(
                    onDotClicked: ((index) => controller.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut)),
                    controller: controller,
                    count: 5,
                    effect: const WormEffect(activeDotColor: corDeAcao),
                  )),
                  TextButton(
                    onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut),
                    child: const Text(
                      "PR??XIMO",
                      style: TextStyle(color: corDeAcao),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
