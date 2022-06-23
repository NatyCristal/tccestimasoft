import 'package:estimasoft/features/contagem/domain/entitie/contagem_detalhada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_estimada_entitie.dart';
import 'package:estimasoft/features/contagem/domain/entitie/contagem_indicativa_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/custo_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/equipe_entity.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/esforco_entitie.dart';
import 'package:estimasoft/features/estimativas/domain/entitie/prazo_entitie.dart';

abstract class CompartilharResultadoDatasource {
  Future enviarContagemDetalhada(bool anonimamente,
      ContagemDetalhadaEntitie contagem, String uidProjeto, String uidUsuario);

  Future enviarContagemEstimada(bool anonimamente,
      ContagemEstimadaEntitie contagem, String uidProjeto, String uidUsuario);

  Future enviarContagemIndicativa(bool anonimamente,
      ContagemIndicativaEntitie contagem, String uidProjeto, String uidUsuario);

  Future enviarEstimativasEsforco(bool anonimamente, EsforcoEntity esforcos,
      String uidProjeto, String uidUsuario);

  Future enviarEstimativasPrazo(bool anonimamente, PrazoEntity prazos,
      String uidProjeto, String uidUsuario);

  Future enviarEstimativasEquipe(bool anonimamente, EquipeEntity equipes,
      String uidProjeto, String uidUsuario);

  Future enviarEstimativasCustos(bool anonimamente, CustoEntity custos,
      String uidProjeto, String uidUsuario);
}
