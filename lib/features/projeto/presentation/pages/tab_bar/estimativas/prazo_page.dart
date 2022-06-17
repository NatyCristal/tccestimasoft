import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/auth/usuario_autenticado.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_estimada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/store/store_contagem_indicativa.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/conteudo/conteudo_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstimativaPrazo extends StatelessWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ProjetoEntitie projetoEntitie;
  final ScrollController scrollController = ScrollController();
  final StoreEstimativaPrazo store;
  final StoreContagemIndicativa storeIndicativa;
  final StoreContagemEstimada storeEstimada;
  final StoreContagemDetalhada storeContagemDetalhada;

  EstimativaPrazo(
      {Key? key,
      required this.storeIndicativa,
      required this.storeEstimada,
      required this.storeContagemDetalhada,
      required this.store,
      required this.projetoEntitie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      width: TamanhoTela.width(context, 1),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Observer(builder: (context) {
              return DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: [
                  "Indicativa - ${storeIndicativa.contagemIndicativaValida.totalPf.toString()} PF",
                  "Estimada - ${storeEstimada.contagemEstimadaValida.totalPF.toString()} PF",
                  "Detalhada - ${storeContagemDetalhada.totalPf.toString()} PF",
                ],
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Contagem de ponto de função",
                ),
                popupItemDisabled: (String s) {
                  bool temIgual = false;

                  temIgual = s.contains(' 0 ');

                  for (var element in store.prazos) {
                    if (s.contains(element.contagemPontoDeFuncao)) {
                      temIgual = true;
                    }
                  }

                  return temIgual;
                },
                onChanged: (value) {
                  store.contagemPF = value.toString();
                  store.validarContagem();
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: store.tipoSistema,
              dropdownSearchDecoration: const InputDecoration(
                labelText: "Tipo de sistema",
              ),
              selectedItem: store.tipoSistema[0],
              onChanged: (value) {
                store.tipoSistemaSelecionado = value.toString();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Observer(builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: arredondamentoBordas,
                  color: Colors.blue.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Prazo Total",
                          style: TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal),
                        ),
                        Text("${store.valorTotalEmDias} dias",
                            style: const TextStyle(
                                color: corCorpoTexto,
                                fontWeight: Fontes.weightTextoNormal)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Prazo mínimo (região do impossível)",
                          style: TextStyle(
                              color: corCorpoTexto,
                              fontWeight: Fontes.weightTextoNormal),
                        ),
                        Text("${store.valorEmDiasReagiaoDoImpossivel} dias",
                            style: const TextStyle(
                                color: corCorpoTexto,
                                fontWeight: Fontes.weightTextoNormal)),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(corDeFundoBotaoSecundaria)),
                  onPressed: () {
                    store.adicionarPrazo(context);
                  },
                  child: const Text("Adicionar")),
            ),
            const SizedBox(
              height: 30,
            ),
            Observer(builder: (context) {
              return store.tamanhoListaPrazo > 0
                  ? ConteudoPrazo(
                      scrollController: scrollController,
                      projetoEntitie: projetoEntitie,
                      storeEstimativaPrazo: store,
                    )
                  : const SizedBox();
            }),
            const SizedBox(
              height: 30,
            ),
            Observer(builder: (context) {
              return store.alteracao
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
                  corDeTextoBotao: corDeTextoBotaoPrimaria,
                  acao: () async {
                    if (store.prazos.isNotEmpty) {
                      store.carregando = true;

                      for (var element in store.prazos) {
                        await controller.salvarPrazp(
                            element,
                            projetoEntitie.uidProjeto,
                            Modular.get<UsuarioAutenticado>().store.uid,
                            element.contagemPontoDeFuncao.split(" - ").first);
                      }
                      store.alteracao = false;
                      store.carregando = false;
                      AlertaSnack.exbirSnackBar(context, "Prazo salvo!");
                    } else {
                      AlertaSnack.exbirSnackBar(context,
                          "Adicione uma estimativa de prazo para salvar.");
                    }
                  },
                  tituloBotao: "Salvar",
                  corBotao: corDeFundoBotaoPrimaria,
                  carregando: store.carregando);
            }),
          ],
        ),
      ),
    );
  }
}
