import 'dart:math';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class DrawCluster {
  static Point radianPoint(Point center, double r, double radian) {
    return Point(center.x + r * cos(radian), center.y + r * sin(radian));
  }

  static void drawArcWithCenter(
    Canvas canvas,
    Paint paint, {
    required Offset center,
    required double radius,
    startRadian = 0.0,
    sweepRadian = pi,
  }) {
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startRadian,
      sweepRadian,
      false,
      paint,
    );
  }

  static void drawArcTwoPoint(
    Canvas canvas,
    Paint paint, {
    required Offset center,
    required double radius,
    startRadian = 0.0,
    sweepRadian = pi,
    hasStartArc = false,
    hasEndArc = false,
  }) {
    var smallR = paint.strokeWidth / 2;
    paint.strokeWidth = smallR;
    if (hasStartArc) {
      var startCenter =
          radianPoint(Point(center.dx, center.dy), radius, startRadian);
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(
          Offset(startCenter.x.toDouble(), startCenter.y.toDouble()),
          smallR,
          paint);
    }
    if (hasEndArc) {
      var endCenter = radianPoint(
          Point(center.dx, center.dy), radius, startRadian + sweepRadian);
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(endCenter.x.toDouble(), endCenter.y.toDouble()),
          smallR, paint);
    }
  }

  static void draw(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required List<double> sources,
    required List<Color> colors,
    double startAngle = 0.0,
    double paintWidth = 10.0,
    bool hasEnd = false,
    hasCurrent = false,
    int curIndex = 0,
    curPaintWidth = 12.0,
  }) {
    assert(sources.isNotEmpty);
    assert(colors.isNotEmpty);
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..strokeWidth = paintWidth
      ..isAntiAlias = true;
    double total = 0;
    for (double d in sources) {
      total += d;
    }
    assert(total > 0.0);
    List<double> radians = List.empty(growable: true);
    for (double d in sources) {
      double radian = d * 2 * pi / total;
      radians.add(radian);
    }
    var startA = startAngle;
    paint.style = PaintingStyle.stroke;
    var curStartAngle = 0.0;
    for (int i = 0; i < radians.length; i++) {
      var rd = radians[i];
      if (hasCurrent && curIndex == i) {
        curStartAngle = startA;
        startA += rd;
        continue;
      }
      paint.color = colors[i % colors.length];
      paint.strokeWidth = paintWidth;
      drawArcWithCenter(canvas, paint,
          center: center, radius: radius, startRadian: startA, sweepRadian: rd);
      startA += rd;
    }
    if (hasEnd) {
      startA = startAngle;
      paint.strokeWidth = paintWidth;
      for (int i = 0; i < radians.length; i++) {
        var rd = radians[i];
        if (hasCurrent && curIndex == i) {
          startA += rd;
          continue;
        }
        paint.color = colors[i % colors.length];
        paint.strokeWidth = paintWidth;
        drawArcTwoPoint(canvas, paint,
            center: center,
            radius: radius,
            startRadian: startA,
            sweepRadian: rd,
            hasEndArc: true);
        startA += rd;
      }
    }

    if (hasCurrent) {
      paint.color = colors[curIndex % colors.length];
      paint.strokeWidth = curPaintWidth;
      paint.style = PaintingStyle.stroke;
      drawArcWithCenter(canvas, paint,
          center: center,
          radius: radius,
          startRadian: curStartAngle,
          sweepRadian: radians[curIndex]);
    }
    if (hasCurrent && hasEnd) {
      var rd = radians[curIndex % radians.length];
      paint.color = colors[curIndex % colors.length];
      paint.strokeWidth = curPaintWidth;
      paint.style = PaintingStyle.fill;
      drawArcTwoPoint(canvas, paint,
          center: center,
          radius: radius,
          startRadian: curStartAngle,
          sweepRadian: rd,
          hasEndArc: true,
          hasStartArc: true);
    }
  }
}
