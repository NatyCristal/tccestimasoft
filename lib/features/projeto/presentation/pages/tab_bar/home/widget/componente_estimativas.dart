import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:estimasoft/features/resultado/domain/entity/resultado_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ComponenteEstimativas extends StatelessWidget {
  final ProjetoController controller = Modular.get<ProjetoController>();
  final ResultadoEntity resultadoEntity;
  ComponenteEstimativas({Key? key, required this.resultadoEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          resultadoEntity.anonimo
              ? const Text(
                  "Anônimo",
                  style: TextStyle(
                    color: corCorpoTexto,
                  ),
                )
              : SizedBox(
                  width: 130,
                  child: Text(
                      verificaNomeUsuario(resultadoEntity.uidMembro,
                          controller.membrosProjetoAtual),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: corCorpoTexto,
                      ))),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 70,
            child: Text(resultadoEntity.nome,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: corCorpoTexto)),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 80,
            child: Text("${resultadoEntity.valor} ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: corCorpoTexto,
                )),
          ),
        ],
      ),
    );
  }
}

verificaNomeUsuario(String uidUsuario, List<UsuarioEntitie> usuarios) {
  String nomeMembro = "";
  for (var element in usuarios) {
    if (element.uid == uidUsuario) {
      nomeMembro = element.nome;
    }
  }

  return nomeMembro;
}
