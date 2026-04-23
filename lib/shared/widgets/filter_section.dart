import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/constants/strings.dart';
import 'package:ai_setu/core/services/showcase_service.dart';
import 'package:ai_setu/shared/widgets/buttons/smoll_section_button.dart';
import 'package:ai_setu/shared/widgets/text_fields/search_field.dart';
import 'package:ai_setu/shared/widgets/text_fields/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ai_setu/shared/widgets/app_showcase_tooltip.dart';
import 'package:showcaseview/showcaseview.dart';

class FilterOption {
  final String label;
  final String? filterKey;
  final Map<String, String> options;

  const FilterOption({
    required this.label,
    required this.options,
    this.filterKey,
  });
}

class FilterSection extends StatefulWidget {
  final String title;
  final List<FilterOption> filters;
  final VoidCallback? onAdd;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<Map<String, String?>> onFiltersChanged;
  final TextEditingController? searchController;

  const FilterSection({
    super.key,
    required this.title,
    this.onAdd,
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

  int get _activeCount => _selected.values.where((v) => v != null).length;

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
      _selected[f.filterKey ?? f.label] = null;
    }
  }

  @override
  void didUpdateWidget(covariant FilterSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync _selected map with new filters
    for (final f in widget.filters) {
      final key = f.filterKey ?? f.label;
      if (!_selected.containsKey(key)) {
        _selected[key] = null;
      } else {
        // If current selected value is not in new options, reset to null
        final currentVal = _selected[key];
        if (currentVal != null && !f.options.containsValue(currentVal)) {
          _selected[key] = null;
        }
      }
    }
    // Remove old filters that are no longer present
    final currentKeys = widget.filters
        .map((f) => f.filterKey ?? f.label)
        .toSet();
    _selected.removeWhere((key, _) => !currentKeys.contains(key));
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
            // on Add
            if (widget.onAdd != null)
              SectionButton(
                onTap: widget.onAdd,
                label: 'Add',
                icon: PhosphorIconsLight.plus,
              ),
            const Gap(5),
            // Active filter badge + button
            Showcase.withWidget(
              key: ShowcaseService.to.productFilterKey,
              container: AppShowcaseTooltip(
                title: Strings.showcaseFilterTitle,
                description: Strings.showcaseFilterDesc,
                onNext: () => ShowcaseView.get().next(),
                onSkip: () => ShowcaseView.get().dismiss(),
              ),
              targetShapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
              ),
              targetPadding: const EdgeInsets.all(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusM),
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
            ),
          ],
        ),

        const Gap(8),

        // ── Search always visible ──
        Showcase.withWidget(
          key: ShowcaseService.to.productSearchKey,
          container: AppShowcaseTooltip(
            title: Strings.showcaseProductSearchTitle,
            description: Strings.showcaseProductSearchDesc,
            onNext: () => ShowcaseView.get().next(),
            onSkip: () => ShowcaseView.get().dismiss(),
          ),
          targetShapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
          ),
          targetPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: AppSearchBar(
            hint: 'Search ${widget.title.toLowerCase()}...',
            controller: widget.searchController,
            onChanged: widget.onSearchChanged,
          ),
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
                            label: filter.label,
                            options: filter.options,
                            selected:
                                _selected[filter.filterKey ?? filter.label],
                            onChanged: (val) {
                              setState(
                                () =>
                                    _selected[filter.filterKey ??
                                            filter.label] =
                                        val,
                              );
                              final activeFilters = Map<String, String?>.from(
                                _selected,
                              )..removeWhere((k, v) => v == null);
                              widget.onFiltersChanged(activeFilters);
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
  final String label;
  final Map<String, String> options;
  final String? selected;
  final ValueChanged<String?> onChanged;

  const _FilterDropdown({
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Reverse map to get label from value
    final selectedLabel = options.entries
        .firstWhere(
          (e) => e.value == selected,
          orElse: () => const MapEntry("", ""),
        )
        .key;

    return CustomDropdown(
      label: label,
      items: options.keys.toList(),
      value: selectedLabel.isEmpty ? null : selectedLabel,
      onChanged: (label) {
        onChanged(options[label]);
      },
      searchable: options.length > 5,
      isFilter: true,
    );
  }
}
