import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/containers/border_container.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditSection extends StatefulWidget {
  final String title;
  final Widget child;
  final IconData? icon;
  final Widget? trailing;
  final bool isExpanded;

  const EditSection({
    super.key,
    required this.title,
    required this.child,
    this.icon,
    this.trailing,
    this.isExpanded = true,
  });

  @override
  State<EditSection> createState() => _EditSectionState();
}

class _EditSectionState extends State<EditSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingM,
        vertical: Sizes.paddingS,
      ),
      child: BorderContainer(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            tilePadding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            leading: widget.icon != null
                ? Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: context.appColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 18,
                      color: context.appColors.primary,
                    ),
                  )
                : null,
            title: Text(
              widget.title,
              style: TextHelper.h6Style(context).copyWith(
                fontWeight: FontWeight.w600,
                color: widget.icon != null ? context.appColors.primary : null,
              ),
            ),
            trailing:
                widget.trailing ??
                Icon(
                  _isExpanded
                      ? PhosphorIconsLight.caretUp
                      : PhosphorIconsLight.caretDown,
                  size: 18,
                  color: context.appColors.textSecondary,
                ),
            children: [
              const Divider(height: 1, thickness: 0.5),
              Padding(
                padding: const EdgeInsets.all(Sizes.paddingM),
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
