import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_custo_model_firebase.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_equipe_model_firebase.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_esforco_model_firebases.dart';
import 'package:estimasoft/features/estimativas/data/models/estimativa_prazo_model_firebase.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/resultado/data/datasource/resultado_compartilhar_datasource.dart';

class ResultadoFirebaseDatasource extends CompartilharResultadoDatasource {
  final firestore = FirebaseFirestore.instance;

  @override
  Future enviarEstimativasCustos(bool anonimamente, CustoEntity custos,
      String uidProjeto, String uidUsuario) async {
    CustoModel custoModel = CustoModel(
      compartilhada: true,
      tipoContagem: custos.tipoContagem,
      equipe: custos.equipe,
      custosVariaisFixos: custos.custosVariaisFixos,
      disponibilidadeEquipe: custos.disponibilidadeEquipe,
      custoTotalMensal: custos.custoTotalMensal,
      custoHora: custos.custoHora,
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
      custoModel.tipoContagem: custoModel.toMap(),
    });

    return custoModel;
  }

  @override
  Future enviarEstimativasEquipe(bool anonimamente, EquipeEntity equipes,
      String uidProjeto, String uidUsuario) async {
    EstimativaEquipeModel equipeModels = (EstimativaEquipeModel(
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
            .collection("Equipe")
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
        .collection("Esforco")
        .doc(uidUsuario)
        .update({
      equipeModels.esforco.split(" - ").last: equipeModels.toMap(),
    });

    return equipeModels;
  }

  @override
  Future<EsforcoEntity> enviarEstimativasEsforco(bool anonimamente,
      EsforcoEntity esforcos, String uidProjeto, String uidUsuario) async {
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

    return esforcosModels;
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

    return prazoModel;
  }
}
