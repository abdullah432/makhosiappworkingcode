import 'package:flutter/material.dart';

class AppLabels {
  static Widget getLabel({
    @required String labelText,
    @required double size,
    @required Color labelColor,
    @required bool isBold,
    @required bool isUnderlined,
    @required TextAlign alignment,
  }) {
    return Text(
      labelText,
      textAlign: alignment,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: size,
        color: labelColor,
        decoration:
            isUnderlined ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
