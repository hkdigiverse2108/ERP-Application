import 'package:flutter/material.dart';

class YearModel {
  final String financialYear; // Format: "2024 - 2025"
  final DateTimeRange dateRange;

  YearModel({required this.financialYear, required this.dateRange});

  @override
  String toString() => financialYear;
}
