import 'package:cached_network_image/cached_network_image.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:flutter/material.dart';

class AvatarMembro extends StatelessWidget {
  final UsuarioEntitie membro;
  const AvatarMembro({Key? key, required this.membro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String nome =
        membro.nome.split(" ")[0][0] + membro.nome.split(" ")[1][0];

    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(5),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: corDeLinhaAppBar, borderRadius: BorderRadius.circular(30)),
      child: membro.urlFoto == ""
          ? Container(
              decoration: BoxDecoration(
                  color: corDeFundoBotaoSecundaria,
                  borderRadius: BorderRadiusDirectional.circular(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                        color: corTituloTexto,
                        fontWeight: Fontes.weightTextoTitulo),
                  )
                ],
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                  imageUrl: membro.urlFoto, fit: BoxFit.cover)),
    );
  }
}
