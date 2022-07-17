import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/custo_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/equipe_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/esforco_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/prazo_page.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../../../../core/auth/usuario_autenticado.dart';
import '../../../../tab_bar/estimativas/stores/store_estimativa_prazo.dart';

class EstimativasStepperPage extends StatefulWidget {
  final StoreProjetosIndexMenu storeProjetosIndexMenu;
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ProjetoEntitie projeto;
  final StoreEstimativaEsforco storeEstimativaEsforco;
  final StoreEstimativaEquipe storeEstimativaEquipe;
  final StoreEstimativaCusto storeEstimativaCusto;
  final StoreEstimativaPrazo storeEstimativaPrazo;
  final StoreContagemIndicativa storeIndicativa;
  final StoreContagemEstimada storeEstimada;
  final StoreContagemDetalhada storeDetalhada;
  final Widget bottonNavigationBar;

  EstimativasStepperPage({
    Key? key,
    required this.projeto,
    required this.storeEstimativaEsforco,
    required this.storeEstimativaEquipe,
    required this.storeEstimativaCusto,
    required this.storeEstimativaPrazo,
    required this.storeIndicativa,
    required this.storeEstimada,
    required this.storeDetalhada,
    required this.bottonNavigationBar,
    required this.storeProjetosIndexMenu,
  }) : super(key: key);

  @override
  State<EstimativasStepperPage> createState() => _EstimativasStepperPageState();
}

class _EstimativasStepperPageState extends State<EstimativasStepperPage> {
  int _stepAtual = 0;

  @override
  void initState() {
    if (widget.storeEstimativaEsforco.esforcosValidos.isNotEmpty) {
      _stepAtual = 1;
      widget.storeEstimativaEsforco.isVisualizacao = true;
    }
    if (widget.storeEstimativaPrazo.prazosValidos.isNotEmpty) {
      _stepAtual = 2;
      widget.storeEstimativaPrazo.isVisualizacao = true;
    }
    if (widget.storeEstimativaEquipe.equipesValidas.isNotEmpty) {
      _stepAtual = 3;
      widget.storeEstimativaEquipe.isVisualizacao = true;
    }
    if (widget.storeEstimativaCusto.custosValidos.isNotEmpty) {
      _stepAtual = 4;
      widget.storeEstimativaCusto.isVisualizacao = true;
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
          maxLines: 3,
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
        steps: getStepsEstimativas,
        controlsBuilder: (
          BuildContext context,
          ControlsDetails details,
        ) {
          return _stepAtual == 4
              ? const SizedBox()
              : Row(
                  children: <Widget>[
                    widget.storeDetalhada.contagemDetalhadaValida.totalPf == 0
                        ? const SizedBox()
                        : Flexible(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      corDeFundoBotaoPrimaria)),
                              onPressed: onStepEstimativasContinue,
                              child: Observer(builder: (context) {
                                return widget.storeProjetosIndexMenu.carregando
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: corTextoSobCorPrimaria,
                                        ),
                                      )
                                    : const Text(
                                        "Continuar",
                                        style: TextStyle(
                                            color: corTextoSobCorPrimaria),
                                      );
                              }),
                            ),
                          ),
                  ],
                );
        },
      ),
      bottomNavigationBar: widget.bottonNavigationBar,
    );
  }

  void onStepEstimativasContinue() async {
    final isLastStep = _stepAtual == getStepsEstimativas.length - 1;
    bool isValid = false;

    switch (_stepAtual) {
      case 0:
        if (widget.storeEstimativaEsforco.isVisualizacao) {
          isValid = true;
          break;
        }
        if (widget.storeEstimativaEsforco.esforcos.isNotEmpty &&
            !widget.storeProjetosIndexMenu.carregando) {
          widget.storeProjetosIndexMenu.carregando = true;

          for (var element in widget.storeEstimativaEsforco.esforcos) {
            await widget.controller.salvarEsforco(
                element,
                widget.projeto.uidProjeto,
                Modular.get<UsuarioAutenticado>().store.uid,
                element.contagemPontoDeFuncao.split(" - ").first);
          }
          widget.storeEstimativaEsforco.esforcosValidos =
              await widget.controller.estimativasController.recuperarEsforcos(
                  widget.projeto.uidProjeto,
                  Modular.get<UsuarioAutenticado>().store.uid);
          widget.storeEstimativaEsforco.alteracores = false;
          AlertaSnack.exbirSnackBar(context, "Esforço salvo!");
          isValid = true;
          widget.storeProjetosIndexMenu.carregando = false;
          widget.storeEstimativaEsforco.isVisualizacao = true;
        } else {
          AlertaSnack.exbirSnackBar(
              context, "Adicione um esforço para continuar.");
        }
        break;
      case 1:
        if (widget.storeEstimativaPrazo.prazos.isNotEmpty) {
          widget.storeProjetosIndexMenu.carregando = true;
          for (var element in widget.storeEstimativaPrazo.prazos) {
            await widget.controller.salvarPrazp(
                element,
                widget.projeto.uidProjeto,
                Modular.get<UsuarioAutenticado>().store.uid,
                element.contagemPontoDeFuncao.split(" - ").first);
          }

          widget.storeEstimativaPrazo.prazosValidos =
              await widget.controller.estimativasController.recuperarPrazos(
                  widget.projeto.uidProjeto,
                  Modular.get<UsuarioAutenticado>().store.uid);
          widget.controller.estimativasController.prazos;

          widget.storeEstimativaPrazo.alteracao = false;

          AlertaSnack.exbirSnackBar(context, "Prazo salvo!");
          widget.storeEstimativaPrazo.isVisualizacao = true;
          isValid = true;
          widget.storeProjetosIndexMenu.carregando = false;
        } else {
          AlertaSnack.exbirSnackBar(
              context, "Adicione um prazo para continuar.");
        }
        break;
      case 2:
        if (widget.storeEstimativaEquipe.equipes.isNotEmpty &&
            widget.storeEstimativaEquipe.alteracao &&
            !widget.storeProjetosIndexMenu.carregando) {
          widget.storeProjetosIndexMenu.carregando = true;
          for (var element in widget.storeEstimativaEquipe.equipes) {
            await widget.controller.salvarEquipe(
                element,
                widget.projeto.uidProjeto,
                Modular.get<UsuarioAutenticado>().store.uid,
                element.contagemPontoDeFuncao);
          }
          widget.storeEstimativaEquipe.equipesValidas =
              await widget.controller.estimativasController.recuperarEquipe(
            widget.projeto.uidProjeto,
            Modular.get<UsuarioAutenticado>().store.uid,
          );

          widget.storeEstimativaEquipe.alteracao = false;

          AlertaSnack.exbirSnackBar(context, "Equipe salva!");
          widget.storeEstimativaEquipe.isVisualizacao = true;
          isValid = true;
          widget.storeProjetosIndexMenu.carregando = false;
        } else {
          AlertaSnack.exbirSnackBar(
              context, "Adicione uma equipe para continuar.");
        }
        break;
      case 3:
        if (widget.storeEstimativaCusto.custos.isNotEmpty &&
            widget.storeEstimativaCusto.alteracao) {
          widget.storeProjetosIndexMenu.carregando = true;
          for (var element in widget.storeEstimativaCusto.custos) {
            await Modular.get<ProjetoController>().salvarCusto(
                element,
                widget.projeto.uidProjeto,
                Modular.get<UsuarioAutenticado>().store.uid,
                element.tipoContagem);
          }
          widget.storeEstimativaCusto.custosValidos =
              await Modular.get<ProjetoController>()
                  .estimativasController
                  .recuperarCusto(widget.projeto.uidProjeto,
                      Modular.get<UsuarioAutenticado>().store.uid);
          widget.storeEstimativaCusto.alteracao = false;

          AlertaSnack.exbirSnackBar(context, "Custo salvo com sucesso!");
          widget.storeEstimativaCusto.isVisualizacao = true;
          isValid = true;
          widget.storeProjetosIndexMenu.carregando = false;
        } else {
          AlertaSnack.exbirSnackBar(
              context, "Adicione um custo para continuar.");
        }
        break;
      case 4:
        isValid = true;
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

  List<Step> get getStepsEstimativas {
    return <Step>[
      Step(
        isActive: _stepAtual >= 0,
        state: _stepAtual >= 1 ? StepState.complete : StepState.indexed,
        title: _stepAtual == 0
            ? Text(widget.storeDetalhada.contagemDetalhadaValida.totalPf == 0
                ? "Estimativas"
                : "Esforço")
            : const Text(""),
        content: widget.storeDetalhada.contagemDetalhadaValida.totalPf == 0
            ? SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.3),
                      radius: 40,
                      child: Icon(Icons.cancel,
                          color: Colors.red.withOpacity(0.6), size: 80),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Finalize as contagens",
                      style: TextStyle(color: corCorpoTexto),
                    ),
                  ],
                ),
              )
            : EstimativaEsforcoPage(
                projetoEntitie: widget.projeto,
                storeEstimativaEsforco: widget.storeEstimativaEsforco,
                storeIndicativa: widget.storeIndicativa,
                storeContagemDetalhada: widget.storeDetalhada,
                storeContagemEstimada: widget.storeEstimada,
              ),
      ),
      Step(
        isActive: _stepAtual >= 1,
        state: _stepAtual >= 2 ? StepState.complete : StepState.indexed,
        title: _stepAtual == 1 ? const Text("Prazo") : const Text(""),
        content: EstimativaPrazoPage(
          projetoEntitie: widget.projeto,
          store: widget.storeEstimativaPrazo,
          storeIndicativa: widget.storeIndicativa,
          storeContagemDetalhada: widget.storeDetalhada,
          storeEstimada: widget.storeEstimada,
        ),
      ),
      Step(
        isActive: _stepAtual >= 2,
        state: _stepAtual >= 3 ? StepState.complete : StepState.indexed,
        title: _stepAtual == 2 ? const Text("Equipe") : const Text(""),
        content: EstimativaEquipePage(
          storeContagemDetalhada: widget.storeDetalhada,
          storeContagemEstimada: widget.storeEstimada,
          storeContagemIndicativa: widget.storeIndicativa,
          projetoEntitie: widget.projeto,
          storeEstimativaEquipe: widget.storeEstimativaEquipe,
          storeEstimativaEsforco: widget.storeEstimativaEsforco,
          storeEstimativaPrazo: widget.storeEstimativaPrazo,
        ),
      ),
      Step(
        isActive: _stepAtual >= 3,
        state: _stepAtual >= 4 ? StepState.complete : StepState.indexed,
        title: _stepAtual == 3 ? const Text("Custo") : const Text(""),
        content: EstimativaCustoPage(
          storeEstimativaPrazo: widget.storeEstimativaPrazo,
          projetoEntitie: widget.projeto,
          storeEstimativaEsforco: widget.storeEstimativaEsforco,
          storeContagemIndicativa: widget.storeIndicativa,
          storeContagemEstimada: widget.storeEstimada,
          storeContagemDetalhada: widget.storeDetalhada,
          storeEstimativaEquipe: widget.storeEstimativaEquipe,
          storeEstimativaCusto: widget.storeEstimativaCusto,
        ),
      ),
      Step(
        isActive: _stepAtual >= 4,
        state: _stepAtual >= 5 ? StepState.complete : StepState.indexed,
        title: _stepAtual == 4 ? const Text("Concluído") : const Text(""),
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
                "Estimativas concluídas",
                style: TextStyle(color: corCorpoTexto),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}

alertaCompartilhamentoProjeto(ProjetoEntitie projetoEntitie, context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Id de compartilhamento:",
    style: const AlertStyle(
      titleStyle: TextStyle(color: corTituloTexto, fontSize: 20),
    ),
    content: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          projetoEntitie.uidProjeto,
          style: const TextStyle(
              color: corCorpoTexto,
              fontSize: 18,
              fontWeight: Fontes.weightTextoLeve),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        color: corDeFundoBotaoSecundaria,
        child: const Text(
          "Copiar",
          style: TextStyle(
              fontWeight: Fontes.weightTextoNormal,
              color: corDeTextoBotaoSecundaria,
              fontSize: 14),
        ),
        onPressed: () async {
          ClipboardData data = ClipboardData(text: projetoEntitie.uidProjeto);

          await Clipboard.setData(data).then((value) {
            AlertaSnack.exbirSnackBar(context, "Código copiado");
            Navigator.of(context, rootNavigator: true).pop();
          });
        },
        width: 120,
      ),
    ],
  ).show();
}
