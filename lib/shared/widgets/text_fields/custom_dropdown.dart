import 'package:ai_setu/core/constants/colors.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? value;
  final Function(String) onChanged;
  final bool searchable;
  final String searchHint;
  final bool isFilter;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.onChanged,
    this.searchable = false,
    this.searchHint = "Search...",
    this.isFilter = false,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _filteredItems = widget.items;
      _searchController.clear();
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _removeDropdown();
    }
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeDropdown,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, size.height + 5),
              child: Material(
                elevation: 8,
                shadowColor: context.isDarkMode
                    ? Colors.black12
                    : Colors.black26,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  decoration: BoxDecoration(
                    color: context.appColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.appColors.border),
                  ),
                  child: StatefulBuilder(
                    builder: (context, setOverlayState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.searchable)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                style: TextHelper.bodyMediumStyle(context),
                                decoration: InputDecoration(
                                  hintText: widget.searchHint,
                                  hintStyle: TextHelper.bodySmallStyle(context)
                                      .copyWith(
                                        color: context.appColors.textSecondary,
                                      ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 18,
                                    color: context.appColors.textSecondary,
                                  ),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: context.appColors.border,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: context.appColors.border,  
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  setOverlayState(() {
                                    _filteredItems = widget.items
                                        .where(
                                          (item) => item.toLowerCase().contains(
                                            value.toLowerCase(),
                                          ),
                                        )
                                        .toList();
                                  });
                                },
                              ),
                            ),
                          Flexible(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              itemCount: _filteredItems.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final item = _filteredItems[index];
                                final isSelected = item == widget.value;

                                return InkWell(
                                  onTap: () {
                                    widget.onChanged(item);
                                    _removeDropdown();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    color: isSelected
                                        ? AppColors.primary.withOpacity(0.05)
                                        : null,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item,
                                            style:
                                                TextHelper.bodyMediumStyle(
                                                  context,
                                                ).copyWith(
                                                  color: isSelected
                                                      ? AppColors.primary
                                                      : context
                                                            .appColors
                                                            .textPrimary,
                                                  fontWeight: isSelected
                                                      ? FontWeight.w600
                                                      : FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                        if (isSelected)
                                          const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: AppColors.primary,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_filteredItems.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "No results found",
                                style: TextHelper.bodySmallStyle(context)
                                    .copyWith(
                                      color: context.appColors.textSecondary,
                                    ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _removeDropdown();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: SizedBox(
          height: widget.isFilter ? 40 : null,
          child: InputDecorator(
            decoration: InputDecoration(
              isDense: widget.isFilter,
              labelText: widget.isFilter ? null : widget.label,
              labelStyle: TextHelper.bodySmallStyle(context),
              fillColor: widget.isFilter ? context.appColors.surface : null,
              filled: widget.isFilter,
              contentPadding: widget.isFilter
                  ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                borderSide: BorderSide(color: context.appColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                borderSide: BorderSide(color: context.appColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.value ??
                        (widget.isFilter ? "All" : "Select ${widget.label}"),
                    style: TextHelper.bodyMediumStyle(context).copyWith(
                      color: widget.value == null
                          ? context.appColors.textSecondary
                          : null,
                      fontSize: widget.isFilter ? 13 : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: widget.isFilter ? 20 : 24,
                  color: context.appColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
