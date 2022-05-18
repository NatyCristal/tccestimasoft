import 'package:cached_network_image/cached_network_image.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../../core/auth/usuario_autenticado.dart';

class AvatarUsuario extends StatelessWidget {
  const AvatarUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioLogado = Modular.get<UsuarioAutenticado>();
    final String nome = usuarioLogado.store.nome.split(" ")[0][0] +
        usuarioLogado.store.nome.split(" ")[1][0];

    return CircleAvatar(
      radius: 50,
      backgroundColor: corDeFundoBotaoPrimaria.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 95,
                height: 95,
                child: CircleAvatar(
                  backgroundColor: usuarioLogado.store.urlFoto == ""
                      ? corDeFundoBotaoSecundaria
                      : Colors.transparent,
                  child: usuarioLogado.store.urlFoto == ""
                      ? Text(
                          nome,
                          style: const TextStyle(
                              color: corTituloTexto,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: usuarioLogado.store.urlFoto,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
