import 'package:flutter/material.dart';
import 'dart:math';

class DrawingPainter extends CustomPainter {
  final List<Offset> points;
  final List<Color> rainbowColors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple];

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final random = Random();
    int colorIndex = 0;

    for (int i = 0; i < points.length - 1; i++) {
      paint.color = rainbowColors[colorIndex % rainbowColors.length];
      colorIndex++;

      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
