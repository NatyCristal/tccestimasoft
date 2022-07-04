import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/features/contagem/data/model/indice_detalhada_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/indice_detalhada.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/arquivos_handler.dart';
import 'package:estimasoft/features/projeto/presentation/pages/tab_bar/contagem/widgets/chain/indice_chain.dart';
import 'package:mobx/mobx.dart';

part 'store_contagem_detalhada.g.dart';

class StoreContagemDetalhada = StoreContagemDetalhadaBase
    with _$StoreContagemDetalhada;

abstract class StoreContagemDetalhadaBase with Store {
  @observable
  int tamanhoFuncaoDeDados = 0;

  @observable
  int tamanhoFuncaoTransacional = 0;

  @observable
  bool houveMudancaComplexidade = false;
  ArquivosHandler arquivosHandler = IndiceChain.getChainAie();
  ContagemDetalhadaEntitie contagemDetalhadaValida = ContagemDetalhadaEntitie(
      compartilhada: false,
      funcaoDados: [],
      funcaoTransacional: [],
      totalPf: 0,
      totalFuncaoDados: 0,
      totalFuncaoTransacional: 0);

  @observable
  ContagemDetalhadaEntitie contagemDetalhadaEntitie = ContagemDetalhadaEntitie(
      compartilhada: false,
      funcaoDados: [],
      funcaoTransacional: [],
      totalPf: 0,
      totalFuncaoDados: 0,
      totalFuncaoTransacional: 0);

  @observable
  int totalPfFuncaoDeDados = 0;

  @observable
  int totalPfFuncaTransacional = 0;

  @observable
  int totalPf = 0;

  @observable
  bool alteracoes = false;

  @observable
  bool carregando = false;

  @action
  adicionarQuantidade(IndiceDetalhada indice, String tipoFuncao) {
    switch (tipoFuncao) {
      case "ALI":
        arquivosHandler = IndiceChain.getChainAli();
        verificaValorTiposFuncoes(indice, contagemDetalhadaEntitie.funcaoDados);
        houveMudancaComplexidade = true;
        calcularPFFuncaoDados();
        alteracoes = true;
        break;
      case "AIE":
        arquivosHandler = IndiceChain.getChainAie();
        verificaValorTiposFuncoes(indice, contagemDetalhadaEntitie.funcaoDados);
        houveMudancaComplexidade = true;
        calcularPFFuncaoDados();
        alteracoes = true;
        break;
      case "CE":
        arquivosHandler = IndiceChain.getChainCe();
        verificaValorTiposFuncoes(
            indice, contagemDetalhadaEntitie.funcaoTransacional);
        houveMudancaComplexidade = true;
        calcularPFFuncaoTransacional();
        alteracoes = true;
        break;
      case "EE":
        arquivosHandler = IndiceChain.getChainEE();
        verificaValorTiposFuncoes(
            indice, contagemDetalhadaEntitie.funcaoTransacional);
        houveMudancaComplexidade = true;
        calcularPFFuncaoTransacional();
        alteracoes = true;
        break;
      case "SE":
        arquivosHandler = IndiceChain.getChainSe();
        verificaValorTiposFuncoes(
            indice, contagemDetalhadaEntitie.funcaoTransacional);
        houveMudancaComplexidade = true;
        calcularPFFuncaoTransacional();
        alteracoes = true;
        break;
      default:
    }
  }

  @action
  validar(context) {
    bool erro = true;
    if (contagemDetalhadaEntitie.totalPf == 0) {
      AlertaSnack.exbirSnackBar(context, "Adicione valores de TD's ,TRs e Ars");
      return false;
    }

    for (var element in contagemDetalhadaEntitie.funcaoDados) {
      if (element.pontoDeFuncao == 0) {
        erro = false;
      }
    }

    if (!erro) {
      AlertaSnack.exbirSnackBar(
          context, "Possui funções de dados sem contagem. Verifique!");
      return false;
    }

    for (var element in contagemDetalhadaEntitie.funcaoTransacional) {
      if (element.pontoDeFuncao == 0) {
        erro = false;
      }
    }

    if (!erro) {
      AlertaSnack.exbirSnackBar(
          context, "Possui funções de transacionais sem contagem. Verifique!");
      return false;
    }

    return erro;
  }

  @action
  verificaValorTiposFuncoes(
      IndiceDetalhada indiceDetalhadaModel, List<IndiceDetalhada> dados) {
    for (var element in dados) {
      if (element.nome == indiceDetalhadaModel.nome) {
        arquivosHandler.calcular(indiceDetalhadaModel);

        element.pontoDeFuncao = indiceDetalhadaModel.pontoDeFuncao;
        element.quantidadeTDs = indiceDetalhadaModel.quantidadeTDs;
        element.quantidadeTrsEArs = indiceDetalhadaModel.quantidadeTrsEArs;
        element.complexidade = indiceDetalhadaModel.complexidade;
      }
    }
  }

  @action
  calcularPFFuncaoTransacional() {
    totalPfFuncaTransacional = 0;
    for (var element in contagemDetalhadaEntitie.funcaoTransacional) {
      totalPfFuncaTransacional += element.pontoDeFuncao;
    }
    contagemDetalhadaEntitie.totalFuncaoTransacional = totalPfFuncaTransacional;
    totalPf = totalPfFuncaoDeDados + totalPfFuncaTransacional;
    contagemDetalhadaEntitie.totalPf = totalPf;
  }

  @action
  calcularPFFuncaoDados() {
    totalPfFuncaoDeDados = 0;
    for (var element in contagemDetalhadaEntitie.funcaoDados) {
      totalPfFuncaoDeDados += element.pontoDeFuncao;
    }
    contagemDetalhadaEntitie.totalFuncaoDados = totalPfFuncaoDeDados;
    totalPf = totalPfFuncaoDeDados + totalPfFuncaTransacional;
    contagemDetalhadaEntitie.totalPf = totalPf;
  }

  @action
  receberDados(ContagemEstimadaEntitie contagemEstimada,
      ContagemIndicativaEntitie contagemIndicativa) {
    List<IndiceDetalhadaModel> listaTransacional = [];
    List<IndiceDetalhadaModel> listaFuncaoDados = [];
    for (var element in contagemEstimada.ce) {
      listaTransacional.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "CE",
          quantidadeTRs: 1,
          quantidadeTrsEArs: 0,
          complexidade: 'Baixa',
          pontoFuncao: 3));
    }

    for (var element in contagemEstimada.ee) {
      listaTransacional.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "EE",
          quantidadeTRs: 1,
          quantidadeTrsEArs: 0,
          complexidade: 'Baixa',
          pontoFuncao: 3));
    }
    for (var element in contagemEstimada.se) {
      listaTransacional.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "SE",
          quantidadeTRs: 1,
          quantidadeTrsEArs: 0,
          complexidade: 'Baixa',
          pontoFuncao: 4));
    }

    contagemDetalhadaEntitie.funcaoTransacional = listaTransacional;
    tamanhoFuncaoTransacional = listaTransacional.length;

    for (var element in contagemIndicativa.aie) {
      listaFuncaoDados.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "AIE",
          quantidadeTRs: 1,
          quantidadeTrsEArs: 0,
          complexidade: 'Baixa',
          pontoFuncao: 5));
    }

    for (var element in contagemIndicativa.ali) {
      listaFuncaoDados.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "ALI",
          quantidadeTRs: 1,
          quantidadeTrsEArs: 0,
          complexidade: 'Baixa',
          pontoFuncao: 7));
    }

    contagemDetalhadaEntitie.funcaoDados = listaFuncaoDados;
    tamanhoFuncaoDeDados = listaFuncaoDados.length;

    calcularPFFuncaoDados();
    calcularPFFuncaoTransacional();
  }

  @action
  iniciarSessao(ContagemDetalhadaEntitie contagemRecuperadaFirebase) {
    contagemDetalhadaValida = contagemRecuperadaFirebase;
    contagemDetalhadaEntitie = contagemRecuperadaFirebase;
  }

  @action
  salvar(ContagemDetalhadaEntitie novaContagem) {
    contagemDetalhadaValida = novaContagem;
  }
}
