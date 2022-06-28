import 'package:estimasoft/core/shared/utils/formatadores.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';

class FormarTextoCompartilhar {
  static funcaoTextoEsforco(List<EsforcoEntity> esforco) {
    String texto = "";

    for (var element in esforco) {
      texto +=
          "Tipo Contagem: ${element.contagemPontoDeFuncao.split(" - ").first}\nLinguagem: ${element.linguagem}\nProdutividade Equipe: ${element.produtividadeEquipe} \nEsforço Total: ${element.esforcoTotal} HH\n\n";
    }
    texto = "**Estimativa de Esforço**\n\n" + texto;
    return texto;
  }

  static funcaoTextoPrazo(List<PrazoEntity> prazo) {
    String texto = "";

    for (var element in prazo) {
      texto +=
          "Tipo Contagem: ${element.contagemPontoDeFuncao.split(" - ").first}\nTipo Sistema: ${element.tipoSistema}\nPrazo Mínimo:${element.prazoMinimo}\nPrazo total: ${element.prazoTotal}\n\n";
    }
    texto = "**Estimativa de Prazo**\n\n" + texto;

    return texto;
  }

  static funcaoTextoEquipes(List<EquipeEntity> equipe) {
    String texto = "";

    for (var element in equipe) {
      texto +=
          "\nTipo Contagem: ${element.esforco.split(" - ").last}\nEsforco: ${element.esforco}\nPrazo: ${element.prazo} \nProdução diária: ${element.producaoDiaria}\nEquipe Estimada: ${element.equipeEstimada}\n";
    }
    texto = "**Estimativa de Equipes**\n\n" + texto;
    return texto;
  }

  static funcaoTextoCustos(List<CustoEntity> custo) {
    String texto = "";

    for (var element in custo) {
      texto +=
          "Tipo Contagem: ${element.tipoContagem}\nDisponibilidade Equipe:${element.disponibilidadeEquipe} HH\nCusto Total Mensal: ${Formatadores.formatadorMonetario(element.custoTotalMensal)} \nCusto Hora: ${Formatadores.formatadorMonetario(element.custoHora.toString())}\nCusto Pf ${element.custoPF}\nProcentagem: ${element.porcentagemLucro}%\n\nCusto total projeto: ${Formatadores.formatadorMonetario(element.custoTotalProjeto.toString())}\nValor Total Projeto: ${Formatadores.formatadorMonetario(element.valorTotalProjeto.toString())}\n";
    }
    texto = "**Estimativas de custo**\n\n" + texto;
    return texto;
  }

  static funcaoTextoIndicativa(ContagemIndicativaEntitie indicativa) {
    String texto = "";
    texto +=
        "Funções em ALI:${indicativa.ali}\nALI: ${indicativa.ali.length * 35} PF \nFunções em AIE: ${indicativa.aie.toString()}\nAIE: ${indicativa.aie.length * 15} PF\nTotal: ${indicativa.totalPf} PF\n";

    texto = "**Contagem Indicativa**\n\n" + texto;
    return texto.replaceAll("[", "").replaceAll("]", "");
  }

  static funcaoEstimada(
      ContagemEstimadaEntitie estimada, ContagemIndicativaEntitie indicativa) {
    String texto = "";
    String textoStringIndicativa = "";
    textoStringIndicativa +=
        "Funções em ALI: ${indicativa.ali.toString()}\nPF ALI: ${indicativa.ali.length * 7}\nFunções em AIE: ${indicativa.aie.toString()}\nPF AIE: ${indicativa.aie.length * 7}\n";
    texto =
        "Funções em CE: ${estimada.ce.toString()}\nCE: ${estimada.ce.length * 4} PF\nFunções em EE: ${estimada.ee.toString()}\nEE: ${estimada.ee.length * 4} PF\nFunções em SE: ${estimada.se.toString()}\nSE: ${estimada.se.length * 5} PF\n";
    String totalPF = "Total: " +
        (indicativa.totalPf + estimada.totalPF).toString() +
        " PF\n\n";

    texto =
        "\n**Contagem Estimada**\n\n" + textoStringIndicativa + texto + totalPF;
    return texto.replaceAll("[", "").replaceAll("]", "");
  }

  static funcaoDetaljada(ContagemDetalhadaEntitie detalhadaEntitie) {
    String listaDadosDefuncao = "";
    for (var element in detalhadaEntitie.funcaoDados) {
      listaDadosDefuncao =
          "Nome da Função: ${element.nome}\nTipo Função: ${element.tipo}\nComplexidade: ${element.complexidade}\nPF: ${element.pontoDeFuncao}\nQuantidade TDs: ${element.quantidadeTDs}\nQuantidade TRs: ${element.quantidadeTrsEArs}\n\n ";
    }

    String listaTransacional = "";
    for (var element in detalhadaEntitie.funcaoTransacional) {
      listaDadosDefuncao =
          "Nome da Função: ${element.nome}\nTipo Função: ${element.tipo}\nComplexidade: ${element.complexidade}\nPF: ${element.pontoDeFuncao}\nQuantidade TDs: ${element.quantidadeTDs}\nQuantidade ARs: ${element.quantidadeTrsEArs} ";
    }
    String texto = "";
    String totais =
        "\n\nTotal Função de dados: ${detalhadaEntitie.totalFuncaoDados}\nTotal Função Transacional: ${detalhadaEntitie.totalFuncaoTransacional}\n\nTotal: ${detalhadaEntitie.totalPf} PF";
    texto = "\n**Contagem Detalhada**\n\n" +
        listaDadosDefuncao +
        listaTransacional +
        totais;

    return texto;
  }
}
