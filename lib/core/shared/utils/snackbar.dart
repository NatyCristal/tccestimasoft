import 'package:flutter/material.dart';

class AlertaSnack {
  static exbirSnackBar(BuildContext context, String resultado) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(resultado),
      ),
    );
  }
}
