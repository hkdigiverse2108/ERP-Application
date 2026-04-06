import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/shared/widgets/text_fields/search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FilterOption {
  final String label;
  final List<String> options;

  const FilterOption({required this.label, required this.options});
}

class FilterSection extends StatefulWidget {
  final String title;
  final List<FilterOption> filters;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<Map<String, String?>> onFiltersChanged;
  final TextEditingController? searchController;

  const FilterSection({
    super.key,
    required this.title,
    required this.filters,
    required this.onSearchChanged,
    required this.onFiltersChanged,
    this.searchController,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection>
    with SingleTickerProviderStateMixin {
  bool _filtersOpen = false;
  late final AnimationController _animController;
  late final Animation<double> _animation;
  final Map<String, String?> _selected = {};

  int get _activeCount =>
      _selected.values.where((v) => v != null && v != 'All').length;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
    for (final f in widget.filters) {
      _selected[f.label] = null;
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleFilters() {
    setState(() => _filtersOpen = !_filtersOpen);
    _filtersOpen ? _animController.forward() : _animController.reverse();
  }

  void _clearAll() {
    setState(() {
      for (final key in _selected.keys) {
        _selected[key] = null;
      }
    });
    widget.onFiltersChanged({});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Title row ──
        Row(
          children: [
            Text(
              widget.title,
              style: TextHelper.h4Style(
                context,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            // Active filter badge + button
            GestureDetector(
              onTap: _toggleFilters,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _filtersOpen || _activeCount > 0
                      ? context.appColors.sectionSell
                      : Colors.transparent,
                  border: Border.all(
                    color: _filtersOpen || _activeCount > 0
                        ? Theme.of(context).colorScheme.primary
                        : context.appColors.border,
                  ),
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
                ),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIconsLight.funnelSimple,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const Gap(4),
                    Text('Filter', style: TextHelper.bodySmallStyle(context)),
                    if (_activeCount > 0) ...[
                      const Gap(6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$_activeCount',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),

        const Gap(8),

        // ── Search always visible ──
        AppSearchBar(
          hint: 'Search ${widget.title.toLowerCase()}...',
          controller: widget.searchController,
          onChanged: widget.onSearchChanged,
        ),

        // ── Filter panel ──
        SizeTransition(
          sizeFactor: _animation,
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(Sizes.paddingS),
              decoration: BoxDecoration(
                color: context.appColors.surface,
                border: Border.all(color: context.appColors.border),
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdowns
                  ...widget.filters.map(
                    (filter) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filter.label,
                            style: TextHelper.captionStyle(context),
                          ),
                          const Gap(4),
                          _FilterDropdown(
                            options: filter.options,
                            selected: _selected[filter.label],
                            onChanged: (val) {
                              setState(() => _selected[filter.label] = val);
                              widget.onFiltersChanged(Map.from(_selected));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Clear all
                  if (_activeCount > 0)
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _clearAll,
                        child: Text(
                          'Clear all',
                          style: TextHelper.bodySmallStyle(context).copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        ),
                      ),
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

class _FilterDropdown extends StatelessWidget {
  final List<String> options;
  final String? selected;
  final ValueChanged<String?> onChanged;

  const _FilterDropdown({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: DropdownButtonFormField<String>(
        value: selected,
        isDense: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
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
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
          fillColor: context.appColors.surface,
          filled: true,
        ),
        hint: Text('All', style: TextHelper.bodySmallStyle(context)),
        items: options
            .map(
              (o) => DropdownMenuItem(
                value: o,
                child: Text(o, style: TextHelper.bodySmallStyle(context)),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
