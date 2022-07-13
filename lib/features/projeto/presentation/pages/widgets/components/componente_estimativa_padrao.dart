import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/membros/avatar_membros.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/material.dart';

class ComponenteEstimativasPadrao extends StatelessWidget {
  final ResultadoEntity resultadoEntity;
  final UsuarioEntity membro;
  final List<Widget> corpoEstimativas;
  const ComponenteEstimativasPadrao(
      {Key? key,
      required this.corpoEstimativas,
      required this.membro,
      required this.resultadoEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: TamanhoTela.width(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              resultadoEntity.anonimo
                  ? SizedBox(
                      height: 40,
                      width: 40,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        child: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 55,
                      width: 55,
                      child: AvatarMembro(membro: membro),
                    ),
              const SizedBox(
                width: 20,
              ),
              resultadoEntity.anonimo
                  ? const SizedBox(
                      width: 200,
                      child: Text("Anônimo",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontWeight: Fontes.weightTextoNormal)),
                    )
                  : SizedBox(
                      width: 150,
                      child: Text(
                        membro.nome,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: Fontes.weightTextoNormal),
                      )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ...corpoEstimativas,
          Divider(
            color: corDeAcao.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
