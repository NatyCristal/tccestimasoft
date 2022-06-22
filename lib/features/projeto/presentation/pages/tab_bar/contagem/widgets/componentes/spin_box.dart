import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/material.dart';

class SpinBox extends StatelessWidget {
  int valorAlterado;
  SpinBox({
    Key? key,
    required this.valorAlterado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController valueController = TextEditingController()..text = "0";

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            height: 40,
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 15,
                    onPressed: () {
                      valueController.text =
                          int.parse(valueController.text) - 1 >= 0
                              ? (int.parse(valueController.text) - 1).toString()
                              : valueController.text;

                      valorAlterado = int.parse(valueController.text);
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: corDeAcao,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: TextField(
                    onChanged: (value) {
                      value.toString();
                      valorAlterado = int.parse(value.toString());
                    },
                    textAlign: TextAlign.center,
                    onTap: () {
                      valueController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: valueController.value.text.length);
                    },
                    controller: valueController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 2),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 15,
                    onPressed: () {
                      valueController.text =
                          (int.parse(valueController.text) + 1).toString();
                      //   valor = (int.parse(valueController.text) + 1).toString();
                      valorAlterado = int.parse(valueController.text);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: corDeAcao,
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
