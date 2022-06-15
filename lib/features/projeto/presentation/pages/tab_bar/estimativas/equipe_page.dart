import 'package:dropdown_search/dropdown_search.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_esforco.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_prazo.dart';
import 'package:flutter/material.dart';

class EstimativaEquipePage extends StatelessWidget {
  final StoreEstimativaEquipe storeEstimativaEquipe;
  final StoreEstimativaEsforco storeEstimativaEsforco;
  final StoreEstimativaPrazo storeEstimativaPrazo;
  const EstimativaEquipePage(
      {Key? key,
      required this.storeEstimativaPrazo,
      required this.storeEstimativaEsforco,
      required this.storeEstimativaEquipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingPagePrincipal,
      height: TamanhoTela.height(context, 1),
      width: TamanhoTela.width(context, 1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: [
                storeEstimativaEsforco.valorTotalEsforco.toString() + " Esforço"
              ],
              dropdownSearchDecoration: const InputDecoration(
                labelText: "Esforço",
              ),
              //      popupItemDisabled: (String s) => s.contains(' 0 '),
              onChanged: (value) {
                //   store.contagemPF = value.toString();
                //  store.validarContagem();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: [storeEstimativaPrazo.prazoTotal.toString() + " Dias"],
              dropdownSearchDecoration: const InputDecoration(
                labelText: "Prazo",
              ),
              //      popupItemDisabled: (String s) => s.contains(' 0 '),

              onChanged: (value) {
                //   store.contagemPF = value.toString();
                //  store.validarContagem();
              },
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
              //      popupItemDisabled: (String s) => s.contains(' 0 '),
              onChanged: (value) {
                //   store.contagemPF = value.toString();
                //  store.validarContagem();
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
              child: Text(
                "Equipe Estimada ${storeEstimativaEquipe.equipeEstimada} recursos",
                style: const TextStyle(
                    color: corCorpoTexto,
                    fontSize: tamanhoSubtitulo,
                    fontWeight: Fontes.weightTextoNormal),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            BotaoPadrao(
                corDeTextoBotao: corTextoSobCorPrimaria,
                acao: () {},
                tituloBotao: "Salvar",
                corBotao: corDeFundoBotaoPrimaria,
                carregando: false)
          ],
        ),
      ),
    );
  }
}
