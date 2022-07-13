import 'package:cached_network_image/cached_network_image.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:flutter/material.dart';

class AvatarMembro extends StatelessWidget {
  final double altura;
  final double largura;
  final UsuarioEntity membro;
  const AvatarMembro(
      {Key? key, required this.membro, this.altura = 50, this.largura = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nome = membro.nome.split(" ").first[0];
    String sobrenome = "";
    if (membro.nome.split(" ").length >= 2) {
      sobrenome = membro.nome.split(" ")[1][0];
    } else {
      sobrenome = membro.nome.split(" ").first[1];
    }

    nome = nome + sobrenome.toUpperCase();

    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(5),
      height: altura,
      width: largura,
      decoration: BoxDecoration(
          color: corDeLinhaAppBar, borderRadius: BorderRadius.circular(40)),
      child: membro.urlFoto == ""
          ? Container(
              decoration: BoxDecoration(
                  color: corDeFundoBotaoSecundaria,
                  borderRadius: BorderRadiusDirectional.circular(40)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    nome,
                    style: TextStyle(
                        fontSize: altura < 50 ? 10 : 14,
                        color: corTituloTexto,
                        fontWeight: Fontes.weightTextoTitulo),
                  )
                ],
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: CachedNetworkImage(
                  imageUrl: membro.urlFoto, fit: BoxFit.cover)),
    );
  }
}
