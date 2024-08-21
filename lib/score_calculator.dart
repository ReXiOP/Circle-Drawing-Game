import 'dart:math';
import 'package:flutter/material.dart';

double calculateScore(List<Offset> points, Offset center, double radius) {
  if (points.isEmpty) return 0.0;

  double totalDistanceError = 0.0;
  int validPoints = 0;

  for (Offset point in points) {
    double distance = (point - center).distance;
    double error = (distance - radius).abs();
    totalDistanceError += error;
    validPoints++;
  }

  if (validPoints == 0) return 0.0;

  double averageError = totalDistanceError / validPoints;

  // A perfect circle will have an average error of 0, so we calculate a score out of 100.
  double score = max(0, 100 - averageError);
  print("Average Error: $averageError, Calculated Score: $score"); // Debugging output
  return score;
}
