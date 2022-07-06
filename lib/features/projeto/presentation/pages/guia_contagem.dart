import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GuiaContagemSobre extends StatelessWidget {
  const GuiaContagemSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Guia de Contagem"),
      ),
      body: SfPdfViewer.asset(
        'assets/arquivos/JhoneySLopes-JoseLBraga-2011.pdf',
      ),
    );
  }
}
