import 'package:flutter/widgets.dart';

class TamanhoTela {
  static double width(context, porcentagem) =>
      MediaQuery.of(context).size.width * porcentagem;
  static double height(context, porcentagem) =>
      MediaQuery.of(context).size.height * porcentagem;
}
