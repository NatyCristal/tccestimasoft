import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class Formatadores {
  static formatadorMonetario(String texto) {
    final textoFormatado = MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.', leftSymbol: "R\$");
    textoFormatado.text = texto;
    return textoFormatado.text;
  }
}
