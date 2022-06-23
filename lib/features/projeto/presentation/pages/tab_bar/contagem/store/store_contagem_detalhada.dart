import 'package:estimasoft/features/contagem/data/model/indice_detalhada_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:mobx/mobx.dart';

part 'store_contagem_detalhada.g.dart';

class StoreContagemDetalhada = StoreContagemDetalhadaBase
    with _$StoreContagemDetalhada;

abstract class StoreContagemDetalhadaBase with Store {
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
  adicionarQuantidade(IndiceDetalhadaModel indice, String tipoFuncao) {
    switch (tipoFuncao) {
      case "Função de dados":
        break;
      default:
    }
  }

  @action
  alteracaoFuncaoDados(IndiceDetalhadaModel indiceDetalhadaModel) {
    for (var element in contagemDetalhadaEntitie.funcaoDados) {
      if (element.nome == indiceDetalhadaModel.nome) {
        element.quantidadeTRs = indiceDetalhadaModel.quantidadeTRs;
        element.quantidadeTrsEArs = indiceDetalhadaModel.quantidadeTrsEArs;
      }
    }
  }

  @action
  calcularPFFuncaoDados() {
    for (var element in contagemDetalhadaEntitie.funcaoDados) {
      if (element.quantidadeTRs <= 19 && element.quantidadeTrsEArs == 1) {
        totalPfFuncaoDeDados += 7;
      } else if (element.quantidadeTRs >= 50 &&
          element.quantidadeTrsEArs <= 5) {}
    }
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
          quantidadeTRs: 0,
          quantidadeTdsEArs: 0,
          complexidade: '',
          pontoFuncao: 0));
    }

    for (var element in contagemEstimada.ee) {
      listaTransacional.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "EE",
          quantidadeTRs: 0,
          quantidadeTdsEArs: 0,
          complexidade: '',
          pontoFuncao: 0));
    }
    for (var element in contagemEstimada.se) {
      listaTransacional.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "SE",
          quantidadeTRs: 0,
          quantidadeTdsEArs: 0,
          complexidade: '',
          pontoFuncao: 0));
    }

    contagemDetalhadaEntitie.funcaoTransacional = listaTransacional;

    for (var element in contagemIndicativa.aie) {
      listaFuncaoDados.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "AIE",
          quantidadeTRs: 0,
          quantidadeTdsEArs: 0,
          complexidade: '',
          pontoFuncao: 0));
    }

    for (var element in contagemIndicativa.ali) {
      listaFuncaoDados.add(IndiceDetalhadaModel(
          nome: element,
          tipo: "ALI",
          quantidadeTRs: 0,
          quantidadeTdsEArs: 0,
          complexidade: '',
          pontoFuncao: 0));
    }

    contagemDetalhadaEntitie.funcaoDados = listaFuncaoDados;
  }
}
