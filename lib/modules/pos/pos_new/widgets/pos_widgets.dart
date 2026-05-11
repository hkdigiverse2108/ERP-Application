import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PosToggle extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;

  const PosToggle({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: context.appColors.border),
      ),
      child: Row(
        children: [
          _buildToggleItem(0, "Walk In", context),
          _buildToggleItem(1, "Delivery", context),
        ],
      ),
    );
  }

  Widget _buildToggleItem(int index, String label, BuildContext context) {
    bool isActive = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelected(index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xff536DFE) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            label,
            style: TextHelper.bodySmall.copyWith(
              color: isActive ? Colors.white : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color bgColor;
  final Color textColor;

  const SummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.bgColor,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextHelper.h6Style(
              context,
            ).copyWith(fontWeight: FontWeight.bold, color: textColor),
          ),
          const Gap(4),
          Text(
            label,
            style: TextHelper.bodySmall.copyWith(
              fontSize: 10,
              color: textColor.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PosGridButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final String? hotkey;

  const PosGridButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.hotkey,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff536DFE),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const Gap(8),
          Flexible(
            child: Text(
              "$label ${hotkey != null ? '($hotkey)' : ''}",
              style: TextHelper.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
