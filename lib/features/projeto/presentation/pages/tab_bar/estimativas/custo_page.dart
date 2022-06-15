import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/core/shared/widgets/botao.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_custo.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/stores/store_estimativa_equipe.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/custo/card_custos_gerais.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/custo/card_custos_totais.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/custo/card_custos_variaveis.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/estimativas/widgets/custo/card_membros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EstimativaCustoPage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  final StoreEstimativaCusto storeEstimativaCusto;
  final StoreEstimativaEquipe storeEstimativaEquipe;
  EstimativaCustoPage(
      {Key? key,
      required this.storeEstimativaCusto,
      required this.storeEstimativaEquipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        height: TamanhoTela.height(context, 1),
        width: TamanhoTela.width(context, 1),
        padding: paddingPagePrincipal,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardMembros(
                storeEstimativaCusto: storeEstimativaCusto,
                scrollController: scrollController,
              ),
              CardCustosVariaveisFixos(
                  scroll: scrollController,
                  storeEstimativaCusto: storeEstimativaCusto),
              CardCustosGerais(storeEstimativaCusto: storeEstimativaCusto),
              CardCustosTotais(storeEstimativaCusto: storeEstimativaCusto),
              Observer(builder: (context) {
                return BotaoPadrao(
                    corDeTextoBotao: corTextoSobCorPrimaria,
                    acao: () {},
                    tituloBotao: "Salvar",
                    corBotao: corDeFundoBotaoPrimaria,
                    carregando: storeEstimativaCusto.carregando);
              })
            ],
          ),
        ),
      ),
    );
  }
}
