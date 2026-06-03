import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final T? value;
  final Function(T) onChanged;
  final bool searchable;
  final String searchHint;
  final bool isFilter;
  final bool readOnly;
  final bool isRequired;
  final String Function(T)? itemLabelBuilder;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.onChanged,
    this.searchable = false,
    this.searchHint = "Search...",
    this.isFilter = false,
    this.readOnly = false,
    this.isRequired = false,
    this.itemLabelBuilder,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  String _getItemLabel(T item) {
    if (widget.itemLabelBuilder != null) {
      return widget.itemLabelBuilder!(item);
    }
    // Standard approach for AI Setu dropdown models
    try {
      return (item as dynamic).name ?? item.toString();
    } catch (_) {
      try {
        return (item as dynamic).fullName ?? item.toString();
      } catch (_) {
        return item.toString();
      }
    }
  }

  void _toggleDropdown() {
    if (widget.readOnly) return;
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
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final availableHeightBelow =
        MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom -
        offset.dy -
        size.height;
    final availableHeightAbove = offset.dy;

    // Choose direction and max height
    final bool showAbove =
        availableHeightBelow < 300 &&
        availableHeightAbove > availableHeightBelow;
    final double maxHeight = showAbove
        ? (availableHeightAbove > 300 ? 300 : availableHeightAbove - 10)
        : (availableHeightBelow > 300 ? 300 : availableHeightBelow - 10);

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
              showWhenUnlinked: false,
              followerAnchor: showAbove
                  ? Alignment.bottomLeft
                  : Alignment.topLeft,
              targetAnchor: showAbove
                  ? Alignment.topLeft
                  : Alignment.bottomLeft,
              offset: Offset(0, showAbove ? -5 : 5),
              child: Material(
                elevation: 8,
                shadowColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black12
                    : Colors.black26,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  constraints: BoxConstraints(maxHeight: maxHeight),
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
                                          (item) => _getItemLabel(item)
                                              .toLowerCase()
                                              .contains(value.toLowerCase()),
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
                                final label = _getItemLabel(item);

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
                                        ? context.appColors.primary.withValues(
                                            alpha: 0.05,
                                          )
                                        : null,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            label,
                                            style:
                                                TextHelper.bodyMediumStyle(
                                                  context,
                                                ).copyWith(
                                                  color: isSelected
                                                      ? context
                                                            .appColors
                                                            .primary
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
                                          Icon(
                                            Icons.check,
                                            size: 16,
                                            color: context.appColors.primary,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isFilter) ...[
          Row(
            children: [
              Text(
                widget.label,
                style: TextHelper.bodySmallStyle(
                  context,
                ).copyWith(color: context.appColors.textSecondary),
              ),
              if (widget.isRequired)
                const Text(
                  " *",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: widget.readOnly
                    ? Colors.grey.shade100
                    : context.appColors.surface,
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                border: Border.all(
                  color: widget.readOnly
                      ? Colors.grey.shade200
                      : context.appColors.border,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.value != null
                          ? _getItemLabel(widget.value as T)
                          : (widget.isFilter
                                ? "All"
                                : "Select ${widget.label}"),
                      style: TextHelper.bodyMediumStyle(context).copyWith(
                        color: widget.readOnly
                            ? Colors.grey.shade600
                            : widget.value == null
                            ? context.appColors.textSecondary
                            : context.appColors.textPrimary,
                        fontSize: widget.isFilter ? 13 : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (!widget.readOnly)
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
      ],
    );
  }
}
