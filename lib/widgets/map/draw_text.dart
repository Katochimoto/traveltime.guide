import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class DrawText {
  static void draw({
    required Canvas canvas,
    required String text,
    required Offset offset,
    required double size,
    double? paragraphWidth,
    double? fontSize = 12,
  }) {
    const style = TextStyle(color: Colors.black);
    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        height: 1.5,
        fontSize: fontSize,
        fontFamily: style.fontFamily,
        fontStyle: style.fontStyle,
        fontWeight: style.fontWeight,
        textAlign: TextAlign.center,
      ),
    )
      ..pushStyle(style.getTextStyle())
      ..addText(text);

    final ui.Paragraph paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(
        width: paragraphWidth ?? size,
      ));

    canvas.drawParagraph(
      paragraph,
      offset +
          Offset((size - paragraph.width) / 2, (size - paragraph.height) / 2),
    );
  }
}
