import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final filter = ref.watch(filterProvider);
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyanAccent.withOpacity(0.13),
            Colors.blueAccent.withOpacity(0.10),
            Colors.white.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.13),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(0.13),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: FilterType.values.map((f) {
          final isSelected = filter == f;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(
                f.name.toUpperCase(),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isSelected ? Colors.cyanAccent : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  letterSpacing: 1.1,
                  shadows: isSelected
                      ? [
                          Shadow(
                            color: Colors.cyanAccent.withOpacity(0.18),
                            blurRadius: 8,
                          ),
                        ]
                      : [],
                ),
              ),
              selected: isSelected,
              onSelected: (_) => ref.read(filterProvider.notifier).state = f,
              backgroundColor: Colors.white.withOpacity(0.10),
              selectedColor: Colors.cyanAccent.withOpacity(0.18),
              elevation: isSelected ? 10 : 0,
              shadowColor: Colors.cyanAccent.withOpacity(0.18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: isSelected
                      ? Colors.cyanAccent
                      : Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
              showCheckmark: false,
              visualDensity: VisualDensity.compact,
            ),
          );
        }).toList(),
      ),
    );
  }
}
