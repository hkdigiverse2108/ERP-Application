import 'package:flutter/material.dart';

class DetailPdfData {
  final String title;
  final String? subtitle;
  final String? status;
  final Color? statusColor;
  final List<PdfSectionData> sections;
  final String? footerText;
  final String? filename;

  DetailPdfData({
    required this.title,
    this.subtitle,
    this.status,
    this.statusColor,
    required this.sections,
    this.footerText,
    this.filename,
  });
}

class PdfSectionData {
  final String title;
  final List<PdfItemData>? items;
  final PdfTableData? table;

  PdfSectionData({required this.title, this.items, this.table});
}

class PdfItemData {
  final String label;
  final String value;

  PdfItemData({required this.label, required this.value});
}

class PdfTableData {
  final List<String> headers;
  final List<List<String>> rows;

  PdfTableData({required this.headers, required this.rows});
}
