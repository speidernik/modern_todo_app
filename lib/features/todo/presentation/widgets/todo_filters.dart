import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';

final filterProvider = StateProvider<FilterType>((ref) => FilterType.all);
final sortProvider = StateProvider<SortType>((ref) => SortType.dueDate);

enum FilterType {
  all,
  active,
  completed,
  highPriority,
}

enum SortType {
  dueDate,
  priority,
  title,
}

class TodoFilters extends ConsumerWidget {
  const TodoFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(filterProvider);
    final currentSort = ref.watch(sortProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TranslationService.tr(context, 'filter'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: FilterType.values.map((filter) {
              return FilterChip(
                label: Text(TranslationService.tr(context, filter.name)),
                selected: currentFilter == filter,
                onSelected: (selected) {
                  if (selected) {
                    ref.read(filterProvider.notifier).state = filter;
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            TranslationService.tr(context, 'sortBy'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: SortType.values.map((sort) {
              return FilterChip(
                label: Text(TranslationService.tr(context, sort.name)),
                selected: currentSort == sort,
                onSelected: (selected) {
                  if (selected) {
                    ref.read(sortProvider.notifier).state = sort;
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
