import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/data/model/company_model.dart';
import 'package:ai_setu/data/model/year_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialYearController extends GetxService {
  static FinancialYearController get to => Get.find();

  final _storage = StorageService.instance;

  final RxList<YearModel> availableYears = <YearModel>[].obs;
  final Rx<YearModel?> selectedYear = Rx<YearModel?>(null);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    generateYears();
    _loadSelectedYear();
  }

  void generateYears() {
    Log.d("FinancialYearController: generateYears() triggered");
    final companyJson = _storage.read<Map<String, dynamic>>(
      StorageKeys.companyInfo,
    );
    DateTime? startDate;
    int? parsedStartYear;

    if (companyJson != null) {
    Log.d("FinancialYearController: Found companyInfo in storage: ${companyJson.keys.toList()}");
      final company = CompanyModel.fromJson(companyJson);

      // 1. Detection from createdAt
      startDate = company.createdAt ?? DateTime.now();
      Log.d("FinancialYearController: Extracted startDate: $startDate");

      // 2. Detection from financialYear string (e.g. "2024 - 2025")
      if (company.financialYear.isNotEmpty) {
        final yearMatch = RegExp(r'(\d{4})').firstMatch(company.financialYear);
        if (yearMatch != null) {
          parsedStartYear = int.parse(yearMatch.group(1)!);
    Log.d("FinancialYearController: Parsed start year from metadata string: $parsedStartYear");
        }
      }
    } else {
    Log.d("FinancialYearController: companyInfo IS NULL in storage. Please log out and log in again.");
    }

    // Default to today if no dates found
    startDate ??= DateTime.now();

    final now = DateTime.now();

    // Financial year logic:
    // If created in Jan-Mar (month < 4), the financial year started the year before.
    // Otherwise, it started this year.
    int startFYFromDate = startDate.month < 4
        ? startDate.year - 1
        : startDate.year;

    // Use the EARLIEST of the date-based year or the metadata-based year
    int startFY = startFYFromDate;
    if (parsedStartYear != null && parsedStartYear < startFY) {
      startFY = parsedStartYear;
    Log.d("FinancialYearController: Overriding startFY with earlier metadata year: $startFY");
    }

    int currentFY = now.month < 4 ? now.year - 1 : now.year;

    // Safety: Ensure we show at least the current year
    if (startFY > currentFY) startFY = currentFY;

    List<YearModel> generated = [];

    // Generate from the company's start year up to the current active financial year
    for (int y = startFY; y <= currentFY; y++) {
      generated.add(
        YearModel(
          financialYear: "$y - ${y + 1}",
          dateRange: DateTimeRange(
            start: DateTime(y, 4, 1),
            end: DateTime(
              y + 1,
              4,
              1,
            ).subtract(const Duration(microseconds: 1)),
          ),
        ),
      );
    }

    availableYears.assignAll(generated.reversed.toList()); // Latest year first
    Log.d("FinancialYearController: Generated ${availableYears.length} financial years.");
  }

  void _loadSelectedYear() {
    final stored = _storage.read<String>(StorageKeys.financialYear);
    if (stored != null) {
      // Find the year in the list that matches the stored string (normalized)
      final normalizedStored = stored.replaceAll(' ', '');
      final found = availableYears.firstWhereOrNull(
        (e) => e.financialYear.replaceAll(' ', '') == normalizedStored,
      );
      if (found != null) {
        selectedYear.value = found;
        return;
      }
    }

    // Default to the current financial year (first in our reversed list)
    if (availableYears.isNotEmpty) {
      selectedYear.value = availableYears.first;
    }
  }

  void selectYear(YearModel year) {
    selectedYear.value = year;
    _storage.write(StorageKeys.financialYear, year.financialYear);
  }

  /// Returns the date range for the currently selected financial year.
  /// If no year is selected, returns the current month's range as fallback.
  DateTimeRange get selectedRange {
    return selectedYear.value?.dateRange ??
        DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 30)),
          end: DateTime.now(),
        );
  }
}
