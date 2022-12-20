import 'dart:ui';
import 'package:flutter_charts/flutter_charts.dart';

class BarChartModel {
  String year;
  int financial;
  final Color color;

  BarChartModel({
    required this.year,
    required this.financial,
    required this.color,
  });
}