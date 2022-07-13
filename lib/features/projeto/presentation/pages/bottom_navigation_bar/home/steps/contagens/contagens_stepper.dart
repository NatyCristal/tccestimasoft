import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/steps/estimativas/estimativas_stepper.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../domain/entitie/projeto_entitie.dart';

class ContagensStepper extends StatefulWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ProjetoEntitie projeto;
  final StoreContagemIndicativa storeIndicativa;
  final StoreContagemEstimada storeEstimada;
  final StoreContagemDetalhada storeDetalhada;
  final Widget bottonNavigationBar;
  ContagensStepper(
      {Key? key,
      required this.projeto,
      required this.storeEstimada,
      required this.storeDetalhada,
      required this.bottonNavigationBar,
      required this.storeIndicativa})
      : super(key: key);

  @override
  State<ContagensStepper> createState() => _ContagensStepperState();
}

class _ContagensStepperState extends State<ContagensStepper> {
  int _stepAtual = 0;

  @override
  void initState() {
    if (widget.storeIndicativa.contagemIndicativaValida.totalPf > 0) {
      _stepAtual = 1;
    }
    if (widget.storeEstimada.contagemEstimadaValida.totalPF > 0) {
      _stepAtual = 2;
    }
    if (widget.storeDetalhada.contagemDetalhadaValida.totalPf > 0) {
      _stepAtual = 3;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              alertaCompartilhamentoProjeto(widget.projeto, context);
            },
            child: const Icon(Icons.share, color: corTituloTexto, size: 20),
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.projeto.nomeProjeto,
          style: const TextStyle(
            fontSize: tamanhoSubtitulo,
            color: corTituloTexto,
          ),
        ),
      ),
      body: Stepper(
        currentStep: _stepAtual,
        onStepCancel: onStepEstimativasCancel,
        onStepContinue: onStepEstimativasContinue,
        onStepTapped: (int index) {
          setState(() {
            _stepAtual = index;
          });
        },
        type: StepperType.horizontal,
        steps: getStepsContagens,
        controlsBuilder: (
          BuildContext context,
          ControlsDetails details,
        ) {
          return _stepAtual == 3
              ? const SizedBox()
              : Row(
                  children: <Widget>[
                    // Flexible(
                    //   child: BotaoPadrao(
                    //     carregando: false,
                    //     acao: onStepEstimativasCancel,
                    //     tituloBotao: "Anterior",
                    //     corBotao: corDeFundoBotaoSecundaria,
                    //     corDeTextoBotao: corDeTextoBotaoSecundaria,
                    //   ),
                    // ),

                    Flexible(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                corDeFundoBotaoPrimaria)),
                        onPressed: onStepEstimativasContinue,
                        child: const Text(
                          "Continuar",
                          style: TextStyle(color: corTextoSobCorPrimaria),
                        ),
                      ),
                      // child: BotaoPadrao(
                      //   carregando: false,
                      //   acao: onStepEstimativasContinue,
                      //   tituloBotao: "Próximo",
                      //   corBotao: corDeFundoBotaoPrimaria,
                      //   corDeTextoBotao: corDeTextoBotaoPrimaria,
                      // ),
                    ),
                  ],
                );
        },
      ),
      bottomNavigationBar: widget.bottonNavigationBar,
    );
  }

  void onStepEstimativasContinue() async {
    final isLastStep = _stepAtual == getStepsContagens.length - 1;
    bool isValid = false;

    switch (_stepAtual) {
      case 0:
        if (widget.storeIndicativa.contagemIndicativaValida.totalPf > 0) {
          isValid = true;
          break;
        }
        if (widget.storeIndicativa.alteracoes) {
          widget.storeIndicativa.carregouBotao = true;
          var retorno = await widget.controller.salvarContagem(
            "Indicativa",
            widget.storeIndicativa.alis,
            widget.storeIndicativa.aies,
            [],
            [],
            [],
            widget.projeto.uidProjeto,
            widget.storeIndicativa.totalPf,
          );

          widget.storeIndicativa
              .salvar(widget.controller.contagemController.contagemIndicativa);

          widget.storeIndicativa.carregouBotao = false;
          widget.storeIndicativa.alteracoes = false;

          AlertaSnack.exbirSnackBar(context, retorno);
          isValid = true;
        } else {
          AlertaSnack.exbirSnackBar(context, "Não existem novas alterações!");
        }

        break;
      case 1:
        if (widget.storeEstimada.contagemEstimadaValida.totalPF > 0) {
          isValid = true;
          break;
        }
        if (widget.storeEstimada.alteracoes) {
          widget.storeEstimada.carregouBotao = true;
          var retorno = await widget.controller.salvarContagem(
            "Estimada",
            widget.storeIndicativa.contagemIndicativaValida.aie,
            widget.storeIndicativa.contagemIndicativaValida.ali,
            widget.storeEstimada.ce,
            widget.storeEstimada.ee,
            widget.storeEstimada.se,
            widget.projeto.uidProjeto,
            widget.storeEstimada.totalPf +
                widget.storeIndicativa.contagemIndicativaValida.aie.length * 7 +
                widget.storeIndicativa.contagemIndicativaValida.ali.length * 7,
          );

          widget.storeEstimada
              .salvar(widget.controller.contagemController.contagemEstimada);
          widget.storeEstimada.alteracoes = false;
          widget.storeEstimada.carregouBotao = false;
          AlertaSnack.exbirSnackBar(context, retorno);
          isValid = true;
        }

        break;
      case 2:
        if (widget.storeDetalhada.validar(context)) {
          widget.storeDetalhada.carregando = true;
          var retorno = await widget.controller.salvarContagemDetalhada(
              widget.storeDetalhada.contagemDetalhadaEntitie,
              widget.projeto.uidProjeto);

          widget.storeDetalhada
              .salvar(widget.controller.contagemController.contagemDetalhada);
          widget.storeDetalhada.carregando = false;
          widget.storeDetalhada.alteracoes = false;
          AlertaSnack.exbirSnackBar(context, retorno);
          isValid = true;
        }

        break;
      case 3:
        //isValid = true;
        break;
      default:
        isValid = false;
        break;
    }

    if (!isLastStep && isValid) {
      setState(() {
        _stepAtual += 1;
      });
    }
  }

  void onStepEstimativasCancel() {
    if (_stepAtual > 0) {
      setState(() {
        _stepAtual -= 1;
      });
    }
  }

  List<Step> get getStepsContagens {
    return <Step>[
      Step(
          isActive: _stepAtual >= 0,
          state: _stepAtual >= 1 ? StepState.complete : StepState.indexed,
          title: _stepAtual == 0 ? const Text("Indicativa") : const Text(""),
          content: ContagemIndicativa(
              projetoUid: widget.projeto.uidProjeto,
              store: widget.storeIndicativa)),
      Step(
        isActive: _stepAtual >= 1,
        state: _stepAtual >= 2 ? StepState.complete : StepState.indexed,
        title: _stepAtual == 1 ? const Text("Estimada") : const Text(""),
        content: ContagemEstimada(
          projetoUid: widget.projeto.uidProjeto,
          store: widget.storeEstimada,
          storeIndicativa: widget.storeIndicativa,
        ),
      ),
      Step(
        isActive: _stepAtual >= 2,
        state: _stepAtual >= 3 ? StepState.complete : StepState.indexed,
        title: _stepAtual == 2 ? const Text("Detalhada") : const Text(""),
        content: ContagemDetalhada(
          storeEstimada: widget.storeEstimada,
          storeContagemDetalhada: widget.storeDetalhada,
          projetoUid: widget.projeto.uidProjeto,
          storeIndicativa: widget.storeIndicativa,
        ),
      ),
      Step(
        isActive: _stepAtual >= 3,
        state: _stepAtual >= 4 ? StepState.complete : StepState.indexed,
        title: _stepAtual == 3 ? const Text("Concluído") : const Text(""),
        content: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF71B4EC).withOpacity(0.3),
                radius: 40,
                child: const Icon(Icons.check_circle_sharp,
                    color: Color(0xFF71B4EC), size: 80),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Contagens concluídas",
                style: TextStyle(color: corCorpoTexto),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
