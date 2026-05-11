import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/data/model/payment_terms/payment_terms_model.dart';
import 'package:ai_setu/data/repositories/settings/payment_terms_repository.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';

class PayLaterBottomSheet extends StatefulWidget {
  final double totalAmount;
  final Function(String paymentTermsId, DateTime dueDate, bool sendReminder)
  onConfirm;

  const PayLaterBottomSheet({
    super.key,
    required this.totalAmount,
    required this.onConfirm,
  });

  @override
  State<PayLaterBottomSheet> createState() => _PayLaterBottomSheetState();
}

class _PayLaterBottomSheetState extends State<PayLaterBottomSheet> {
  final _paymentTermsRepo = PaymentTermsRepository();
  final List<PaymentTermsModel> _terms = [];
  PaymentTermsModel? _selectedTerm;
  DateTime _selectedDate = DateTime.now();
  bool _sendReminder = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTerms();
  }

  Future<void> _fetchTerms() async {
    try {
      final results = await _paymentTermsRepo.getPaymentTermDropdown();
      setState(() {
        _terms.assignAll(results);
        _selectedTerm =
            _terms.firstWhereOrNull((t) => t.isDefault) ??
            (_terms.isNotEmpty ? _terms.first : null);
        if (_selectedTerm != null) {
          _selectedDate = DateTime.now().add(
            Duration(days: _selectedTerm!.day),
          );
        }
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching terms: $e");
      setState(() => _isLoading = false);
    }
  }

  void _onTermChanged(PaymentTermsModel? term) {
    if (term == null) return;
    setState(() {
      _selectedTerm = term;
      _selectedDate = DateTime.now().add(Duration(days: term.day));
    });
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: context.appColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 20,
          right: 20,
          top: 12,
        ),
        decoration: BoxDecoration(
          color: context.appColors.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Sizes.borderRadiusXL),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: context.appColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pay Later", style: TextHelper.h3),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    PhosphorIconsLight.x,
                    color: context.appColors.textSecondary,
                    size: 24,
                  ),
                ),
              ],
            ),
            const Gap(8),
            const Divider(),
            const Gap(20),
            // Invoice Amount Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
                border: Border.all(
                  color: context.appColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsFill.receipt,
                    color: context.appColors.primary,
                    size: 18,
                  ),
                  const Gap(8),
                  Text(
                    "Invoice Amount: ₹${widget.totalAmount.toStringAsFixed(2)}",
                    style: TextHelper.bodyMedium.copyWith(
                      color: context.appColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              )
            else ...[
              // Payment Terms Dropdown
              _buildField(
                label: "Payment Terms",
                icon: PhosphorIconsLight.listChecks,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<PaymentTermsModel>(
                    isExpanded: true,
                    value: _selectedTerm,
                    hint: Text("Select Terms", style: TextHelper.bodySmall),
                    icon: Icon(
                      PhosphorIconsLight.caretDown,
                      size: 18,
                      color: context.appColors.textSecondary,
                    ),
                    items: _terms.map((term) {
                      return DropdownMenuItem(
                        value: term,
                        child: Text(term.name, style: TextHelper.bodyMedium),
                      );
                    }).toList(),
                    onChanged: _onTermChanged,
                  ),
                ),
              ),
              const Gap(16),
              // Due Date Picker
              _buildField(
                label: "Due Date",
                icon: PhosphorIconsLight.calendar,
                child: InkWell(
                  onTap: _selectDate,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Text(
                          DateFormat('dd MMM, yyyy').format(_selectedDate),
                          style: TextHelper.bodyMedium,
                        ),
                        const Spacer(),
                        Icon(
                          PhosphorIconsLight.calendarBlank,
                          size: 18,
                          color: context.appColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(24),
              // Send Reminder Radio
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Send Reminder",
                  style: TextHelper.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textSecondary,
                  ),
                ),
              ),
              const Gap(12),
              Row(
                children: [
                  _buildRadio("Yes", true),
                  const Gap(40),
                  _buildRadio("No", false),
                ],
              ),
              const Gap(32),
              // Proceed Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedTerm == null) {
                      AppSnackbar.error("Please select payment terms");
                      return;
                    }
                    widget.onConfirm(
                      _selectedTerm!.id,
                      _selectedDate,
                      _sendReminder,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(PhosphorIconsFill.printer, size: 20),
                      const Gap(12),
                      Text("PROCEED TO PRINT", style: TextHelper.button),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: context.appColors.textSecondary),
            const Gap(6),
            Text(
              label,
              style: TextHelper.bodySmall.copyWith(
                color: context.appColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Gap(8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.appColors.background,
            border: Border.all(color: context.appColors.border),
            borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildRadio(String label, bool value) {
    final isSelected = _sendReminder == value;
    return InkWell(
      onTap: () => setState(() => _sendReminder = value),
      borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? context.appColors.primary
                    : context.appColors.border,
                width: 2,
              ),
            ),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? context.appColors.primary
                    : Colors.transparent,
              ),
            ),
          ),
          const Gap(12),
          Text(
            label,
            style: TextHelper.bodyMedium.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? context.appColors.textPrimary
                  : context.appColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
