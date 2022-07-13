import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/membros/avatar_membros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardMembrosHome extends StatelessWidget {
  final UsuarioEntity usuarioEntitie;
  final bool ehAdmin;
  const CardMembrosHome(
      {Key? key, required this.usuarioEntitie, required this.ehAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ehAdmin
                      ? (SvgPicture.asset(
                          "assets/coroa.svg",
                          height: 12,
                          color: Colors.amber,
                        ))
                      : const SizedBox(),
                  AvatarMembro(
                    membro: usuarioEntitie,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nome",
                    style: TextStyle(fontSize: 11, color: corCorpoTexto),
                  ),
                  SizedBox(
                    width: TamanhoTela.width(context, 0.7),
                    height: 30,
                    child: Text(
                      usuarioEntitie.nome,
                      maxLines: 2,
                      softWrap: true,
                      style:
                          const TextStyle(fontWeight: Fontes.weightTextoNormal),
                    ),
                  ),
                  ehAdmin
                      ? const Text(
                          "Administrador do projeto",
                          style: TextStyle(color: corCorpoTexto, fontSize: 11),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
          Divider(
            color: corTituloTexto.withOpacity(0.1),
          )
        ],
      ),
    );
  }
}
