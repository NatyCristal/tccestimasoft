import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_detalhada_firebase_model.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_estimada_firebase_model.dart';
import 'package:estimasoft/features/contagem/data/model/contagem_indicativa_firebase_model.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_custo_model_firebase.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_equipe_model_firebase.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_esforco_model_firebases.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_prazo_model_firebase.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';

import 'interfaces/resultado_compartilhar_datasource.dart';

class ResultadoFirebaseDatasource extends CompartilharResultadoDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future enviarEstimativasCustos(bool anonimamente, CustoEntity custos,
      String uidProjeto, String uidUsuario) async {
    CustoModel custoModel = CustoModel(
      valorPorcentagem: custos.valorPorcentagem,
      despesasTotaisDurantePrazoProjeto:
          custos.despesasTotaisDurantePrazoProjeto,
      custoBasico: custos.custoBasico,
      compartilhada: true,
      tipoContagem: custos.tipoContagem,
      equipe: custos.equipe,
      custosVariaisFixos: custos.custosVariaisFixos,
      //disponibilidadeEquipe: custos.disponibilidadeEquipe,
      custoTotalMensal: custos.custoTotalMensal,
      //custoHora: custos.custoHora,
      porcentagemLucro: custos.porcentagemLucro,
      custoTotalProjeto: custos.custoTotalProjeto,
      valorTotalProjeto: custos.valorTotalProjeto,
      custoPF: custos.custoPF,
    );

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Custos")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Custos")
            .doc(uidUsuario)
            .update({
          custoModel.tipoContagem: {
            "Anonimamente": anonimamente,
            "Valor": custoModel.valorTotalProjeto.toString()
          }
        });
      } else {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Custos")
            .doc(uidUsuario)
            .set({
          custoModel.tipoContagem: {
            "Anonimamente": anonimamente,
            "Valor": custoModel.valorTotalProjeto.toString()
          }
        });
      }
    });
    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Custo")
        .doc(uidUsuario)
        .update({
      custoModel.tipoContagem.split(" - ").first: custoModel.toMap(),
    });

    return ResultadoEntity(anonimamente, custoModel.tipoContagem,
        custoModel.valorTotalProjeto.toString(), uidUsuario);
  }

  @override
  Future enviarEstimativasEquipe(bool anonimamente, EquipeEntity equipes,
      String uidProjeto, String uidUsuario) async {
    EstimativaEquipeModel equipeModels = (EstimativaEquipeModel(
      contagemPontoDefuncao: equipes.contagemPontoDeFuncao,
      compartilhada: true,
      equipeEstimada: equipes.equipeEstimada,
      esforco: equipes.esforco,
      prazo: equipes.prazo,
      producaoDiaria: equipes.producaoDiaria,
    ));

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Equipes")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Equipes")
            .doc(uidUsuario)
            .update({
          equipeModels.esforco.split(" - ").last: {
            "Anonimamente": anonimamente,
            "Valor": equipeModels.equipeEstimada
          }
        });
      } else {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Equipes")
            .doc(uidUsuario)
            .set({
          equipeModels.esforco.split(" - ").last: {
            "Anonimamente": anonimamente,
            "Valor": equipeModels.equipeEstimada
          }
        });
      }
    });
    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Equipe")
        .doc(uidUsuario)
        .update({
      equipeModels.esforco.split(" - ").last: equipeModels.toMap(),
    });

    return ResultadoEntity(anonimamente, equipeModels.esforco.split(" - ").last,
        equipeModels.equipeEstimada, uidUsuario);
  }

  @override
  Future enviarEstimativasEsforco(bool anonimamente, EsforcoEntity esforcos,
      String uidProjeto, String uidUsuario) async {
    EstimativaEsforcoModel esforcosModels = (EstimativaEsforcoModel(
        compartilhada: true,
        contagemPontoDeFuncao: esforcos.contagemPontoDeFuncao,
        linguagem: esforcos.linguagem,
        produtividadeEquipe: esforcos.produtividadeEquipe,
        esforcoTotal: esforcos.esforcoTotal));

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Esforcos")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Esforcos")
            .doc(uidUsuario)
            .update({
          esforcosModels.contagemPontoDeFuncao.split(" - ").first: {
            "Anonimamente": anonimamente,
            "Valor": esforcosModels.esforcoTotal
          }
        });
      } else {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Esforcos")
            .doc(uidUsuario)
            .set({
          esforcosModels.contagemPontoDeFuncao.split(" - ").first: {
            "Anonimamente": anonimamente,
            "Valor": esforcosModels.esforcoTotal
          }
        });
      }
    });
    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Esforco")
        .doc(uidUsuario)
        .update({
      esforcosModels.contagemPontoDeFuncao.split(" - ").first:
          esforcosModels.toMap(),
    });

    return ResultadoEntity(
        anonimamente,
        esforcosModels.contagemPontoDeFuncao.split(" - ").first,
        esforcosModels.esforcoTotal,
        uidUsuario);
  }

  @override
  Future enviarEstimativasPrazo(bool anonimamente, PrazoEntity prazos,
      String uidProjeto, String uidUsuario) async {
    EstimativaPrazoModel prazoModel = (EstimativaPrazoModel(
      compartilhada: true,
      contagemPontoDeFuncao: prazos.contagemPontoDeFuncao,
      prazoMinimo: prazos.prazoMinimo,
      prazoTotal: prazos.prazoTotal,
      tipoSistema: prazos.tipoSistema,
    ));

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Prazos")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Prazos")
            .doc(uidUsuario)
            .update({
          prazoModel.contagemPontoDeFuncao.split(" - ").first: {
            "Anonimamente": anonimamente,
            "Valor": prazoModel.prazoTotal
          }
        });
      } else {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Prazos")
            .doc(uidUsuario)
            .set({
          prazoModel.contagemPontoDeFuncao.split(" - ").first: {
            "Anonimamente": anonimamente,
            "Valor": prazoModel.prazoTotal
          }
        });
      }
    });
    await firestore
        .collection("Estimativa")
        .doc(uidProjeto)
        .collection("Prazo")
        .doc(uidUsuario)
        .update({
      prazoModel.contagemPontoDeFuncao.split(" - ").first: prazoModel.toMap(),
    });

    return ResultadoEntity(
        anonimamente,
        prazoModel.contagemPontoDeFuncao.split(" - ").first,
        prazoModel.prazoTotal.toString(),
        uidUsuario);
  }

  @override
  Future enviarContagemDetalhada(
      bool anonimamente,
      ContagemDetalhadaEntitie contagem,
      String uidProjeto,
      String uidUsuario) async {
    ContagemDetalhadaModel contagemDetalhada = (ContagemDetalhadaModel(
      compartilhada: true,
      funcaoDados: contagem.funcaoDados,
      funcaoTransacional: contagem.funcaoTransacional,
      totalFuncaoDados: contagem.totalFuncaoDados,
      totalFuncaoTransacional: contagem.totalFuncaoTransacional,
      totalPf: contagem.totalPf,
    ));

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Detalhada")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Detalhada")
            .doc(uidUsuario)
            .update({
          "Detalhada": {
            "Anonimamente": anonimamente,
            "Valor": contagemDetalhada.totalPf
          }
        });
      } else {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Detalhada")
            .doc(uidUsuario)
            .set({
          "Detalhada": {
            "Anonimamente": anonimamente,
            "Valor": contagemDetalhada.totalPf
          }
        });
      }
    });
    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Detalhada")
        .doc(uidUsuario)
        .update(
          contagemDetalhada.toMap(),
        );
    return ResultadoEntity(anonimamente, "Detalhada",
        contagemDetalhada.totalPf.toString(), uidUsuario);
  }

  @override
  Future enviarContagemEstimada(
      bool anonimamente,
      ContagemEstimadaEntitie contagem,
      String uidProjeto,
      String uidUsuario) async {
    ContagemEstimadaFirebaseModel contagemEstimada =
        (ContagemEstimadaFirebaseModel(
      aie: contagem.aie,
      ali: contagem.ali,
      compartilhada: true,
      ce: contagem.ce,
      ee: contagem.ee,
      se: contagem.se,
      totalPF: contagem.totalPF,
    ));

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Estimada")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Estimada")
            .doc(uidUsuario)
            .update({
          "Estimada": {
            "Anonimamente": anonimamente,
            "Valor": contagemEstimada.totalPF
          }
        });
      } else {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Estimada")
            .doc(uidUsuario)
            .set({
          "Estimada": {
            "Anonimamente": anonimamente,
            "Valor": contagemEstimada.totalPF
          }
        });
      }
    });

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Estimada")
        .doc(uidUsuario)
        .update(
          contagemEstimada.toMap(),
        );

    return ResultadoEntity(anonimamente, "Estimada",
        contagemEstimada.totalPF.toString(), uidUsuario);
  }

  @override
  Future enviarContagemIndicativa(
      bool anonimamente,
      ContagemIndicativaEntitie contagem,
      String uidProjeto,
      String uidUsuario) async {
    ContagemIndicativaModelFirebase contagemEstimada =
        (ContagemIndicativaModelFirebase(
      compartilhada: true,
      aie: contagem.aie,
      ali: contagem.ali,
      totalPf: contagem.totalPf,
    ));

    await firestore
        .collection("Resultados")
        .doc(uidProjeto)
        .collection("Indicativa")
        .doc(uidUsuario)
        .get()
        .then((value) async {
      if (value.exists) {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Indicativa")
            .doc(uidUsuario)
            .update({
          "Indicativa": {
            "Anonimamente": anonimamente,
            "Valor": contagemEstimada.totalPf
          }
        });
      } else {
        await firestore
            .collection("Resultados")
            .doc(uidProjeto)
            .collection("Indicativa")
            .doc(uidUsuario)
            .set({
          "Indicativa": {
            "Anonimamente": anonimamente,
            "Valor": contagemEstimada.totalPf
          }
        });
      }
    });

    await firestore
        .collection("Contagem")
        .doc(uidProjeto)
        .collection("Indicativa")
        .doc(uidUsuario)
        .update(
          contagemEstimada.toMap(),
        );

    return ResultadoEntity(anonimamente, "Indicativa",
        contagemEstimada.totalPf.toString(), uidUsuario);
  }
}
