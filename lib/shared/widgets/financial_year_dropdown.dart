import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FinancialYearDropdown extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const FinancialYearDropdown({super.key, this.initialValue, this.onChanged});

  @override
  State<FinancialYearDropdown> createState() => _FinancialYearDropdownState();
}

class _FinancialYearDropdownState extends State<FinancialYearDropdown> {
  late String _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialValue ?? "2025-2026";
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (String value) {
        setState(() {
          _selectedYear = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          enabled: false,
          child: Center(
            child: Text(
              "Financial Year",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const PopupMenuDivider(),
        _buildPopupItem("2024 - 2025"),
        _buildPopupItem("2025 - 2026"),
      ],
      child: Padding(
        padding: const EdgeInsets.all(Sizes.paddingS),
        child: BorderContainer(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.paddingM,
            vertical: Sizes.paddingS,
          ),
          child: Text(
            _selectedYear,
            style: const TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: Sizes.textSizeM,
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String label) {
    return PopupMenuItem<String>(
      value: label.replaceAll(' ', ''),
      child: Row(
        children: [
          const Icon(PhosphorIconsLight.calendar, size: 18),
          const SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }
}
