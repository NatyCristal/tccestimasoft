import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ConstrutorPdf {
  static cabecalho(final data, final assetImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.only(bottom: 5),
            height: 60,
            width: 60,
            child: Image(assetImage)),
        Text(
          "Contagem De Pontos de Função",
          style: const TextStyle(fontSize: 18),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Data de Publicação:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(data),
          ],
        ),
      ],
    );
  }

  static tituloSessao(String nomeSessao) {
    return Paragraph(
        text: nomeSessao,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: PdfColor.fromInt(corCorpoTexto.value),
        ),
        margin: const EdgeInsets.all(
          (0.5 * PdfPageFormat.cm),
        ));
  }

  static subtitulo(String subtitulo) {
    return Container(
      margin: const EdgeInsets.all(0.3 * PdfPageFormat.cm),
      child: Text(
        subtitulo,
        style: TextStyle(color: PdfColor.fromInt(corCorpoTexto.value)),
      ),
    );
  }

  static linha(String texto, String valor) {
    return Row(
      children: [
        Text(
          texto,
          maxLines: 4,
          overflow: TextOverflow.clip,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(valor),
      ],
    );
  }

  static tabela(
      List<String> titulosTabela, final dados, Map<int, FixedColumnWidth> map) {
    return Table.fromTextArray(
      columnWidths: map,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerAlignment: Alignment.center,
      headers: titulosTabela,
      data: dados,
    );
  }

  static totalTabela(String texto, String valor) {
    return Container(
      padding: const EdgeInsets.all(0.2 * PdfPageFormat.cm),
      decoration: BoxDecoration(
          color: PdfColor.fromInt(corDeLinhaAppBar.value),
          border: Border.all(
            color: PdfColor.fromInt(corTituloTexto.value),
          )),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(texto, style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(
              flex: 2,
            ),
            Expanded(
              child: Text(valor, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ]),
    );
  }

  static linhaComun(String texto) {
    return Container(
      margin: const EdgeInsets.all(0.3 * PdfPageFormat.cm),
      child: Text(
        texto,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  static tabelaSemTitulo(final data) {
    return Table.fromTextArray(
      data: data,
    );
  }
}
