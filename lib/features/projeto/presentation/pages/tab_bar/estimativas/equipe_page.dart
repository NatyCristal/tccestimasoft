import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/conteudo/conteudo_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstimativaEquipePage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ProjetoEntitie projetoEntitie;
  final StoreEstimativaEquipe storeEstimativaEquipe;
  final StoreEstimativaEsforco storeEstimativaEsforco;
  final StoreEstimativaPrazo storeEstimativaPrazo;
  EstimativaEquipePage(
      {Key? key,
      required this.storeEstimativaPrazo,
      required this.storeEstimativaEsforco,
      required this.storeEstimativaEquipe,
      required this.projetoEntitie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    storeEstimativaEquipe
        .exibirEsforcos(controller.estimativasController.esforcos);
    storeEstimativaEquipe.exibirPrazps(controller.estimativasController.prazos);

    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      width: TamanhoTela.width(context, 1),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Observer(builder: (context) {
              return DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: storeEstimativaEquipe.menuEsforco,
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Esforço",
                ),
                popupItemDisabled: (String s) {
                  bool temIgual = false;

                  temIgual = s.contains(' 0 ');

                  for (var element in storeEstimativaEquipe.equipes) {
                    if (s.contains(element.esforco.split(" - ").last)) {
                      temIgual = true;
                    }
                  }

                  return temIgual;
                },
                onChanged: (value) {
                  storeEstimativaEquipe.esforcoSelecionado = value.toString();
                  storeEstimativaEquipe.estimarEquipe();
                },
                emptyBuilder: (context, searchEntry) => const Center(
                    child: Text('Cadastre um esforço para continuar.',
                        style: TextStyle(color: Colors.blue))),
              );
            }),
            const SizedBox(
              height: 20,
            ),
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: storeEstimativaEquipe.menuPrazo,
              dropdownSearchDecoration: const InputDecoration(
                labelText: "Prazo",
              ),
              popupItemDisabled: (String s) {
                bool temIgual = false;

                temIgual = s.contains(' 0 ');

                for (var element in storeEstimativaEquipe.equipes) {
                  if (s.contains(element.prazo)) {
                    temIgual = true;
                  }
                }

                return temIgual;
              },
              onChanged: (value) {
                storeEstimativaEquipe.prazoSelecionado = value.toString();
                storeEstimativaEquipe.estimarEquipe();
              },
              emptyBuilder: (context, searchEntry) => const Center(
                  child: Text('Cadastre um prazo para continuar.',
                      style: TextStyle(color: Colors.blue))),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: storeEstimativaEquipe.menuItem,
              dropdownSearchDecoration: const InputDecoration(
                labelText: "Produção Diária",
              ),
              selectedItem:
                  storeEstimativaEquipe.menuItem[6] + " (Recomendado)",
              popupItemDisabled: (String s) => s.contains(' 0 '),
              onChanged: (value) {
                storeEstimativaEquipe.producaoDiaria = value.toString();
                storeEstimativaEquipe.estimarEquipe();
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: arredondamentoBordas),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: TamanhoTela.width(context, 1),
              child: Observer(builder: (context) {
                return Text(
                  "Equipe Estimada ${storeEstimativaEquipe.equipeEstimadaValor.toStringAsFixed(2)} Recursos",
                  style: const TextStyle(
                      color: corCorpoTexto,
                      fontSize: tamanhoSubtitulo,
                      fontWeight: Fontes.weightTextoNormal),
                );
              }),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(corDeFundoBotaoSecundaria),
                  ),
                  onPressed: () {
                    storeEstimativaEquipe.adicionarEquipe(context);
                  },
                  child: const Text("Adicionar")),
            ),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (context) {
              return storeEstimativaEquipe.tamanhoEquipe > 0
                  ? ConteudoEquipe(
                      scrollController: scrollController,
                      projetoEntitie: projetoEntitie,
                      equipe: storeEstimativaEquipe,
                    )
                  : const SizedBox();
            }),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (context) {
              return storeEstimativaEquipe.alteracao
                  ? const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Salve as alterações!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: Fontes.weightTextoNormal),
                      ),
                    )
                  : const SizedBox();
            }),
            Observer(builder: (context) {
              return BotaoPadrao(
                  corDeTextoBotao: corTextoSobCorPrimaria,
                  acao: () async {
                    if (storeEstimativaEquipe.equipes.isNotEmpty &&
                        storeEstimativaEquipe.alteracao) {
                      storeEstimativaEquipe.carregando = true;

                      for (var element in storeEstimativaEquipe.equipes) {
                        await controller.salvarEquipe(
                            element,
                            projetoEntitie.uidProjeto,
                            Modular.get<UsuarioAutenticado>().store.uid,
                            element.esforco.split(" - ").last);
                      }
                      storeEstimativaEquipe.equipesValidas = await controller
                          .estimativasController
                          .recuperarEquipe(
                        projetoEntitie.uidProjeto,
                        Modular.get<UsuarioAutenticado>().store.uid,
                      );

                      storeEstimativaEquipe.alteracao = false;
                      storeEstimativaEquipe.carregando = false;
                      AlertaSnack.exbirSnackBar(context, "Equipe salva!");
                    } else {
                      AlertaSnack.exbirSnackBar(context,
                          "Adicione uma estimativa de esforço para salvar.");
                    }
                  },
                  tituloBotao: "Salvar",
                  corBotao: corDeFundoBotaoPrimaria,
                  carregando: storeEstimativaEquipe.carregando);
            })
          ],
        ),
      ),
    );
  }
}
