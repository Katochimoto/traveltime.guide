import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class DrawText {
  static void draw({
    required Canvas canvas,
    required String text,
    required Offset offset,
    required double width,
    required double height,
    double? paragraphWidth,
    double? fontSize = 12,
    String? fontFamily,
    Color? color,
  }) {
    final style = TextStyle(color: color ?? Colors.black);
    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        // height: 1.2,
        fontSize: fontSize,
        fontFamily: fontFamily ?? style.fontFamily,
        fontStyle: style.fontStyle,
        fontWeight: style.fontWeight,
        textAlign: TextAlign.center,
      ),
    )
      ..pushStyle(style.getTextStyle())
      ..addText(text);

    final ui.Paragraph paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(
        width: paragraphWidth ?? width,
      ));

    canvas.drawParagraph(
      paragraph,
      offset +
          Offset(
              (width - paragraph.width) / 2, (height - paragraph.height) / 2),
    );
  }
}
