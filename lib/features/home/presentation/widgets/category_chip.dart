import 'package:flutter/material.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/home/models/todo_category.dart';

class CategoryChip extends StatelessWidget {
  final TodoCategory? category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = category?.color ?? Theme.of(context).colorScheme.primary;

    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (category != null) ...[
            Icon(
              category!.icon,
              size: 16,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            category != null
                ? TranslationService.tr(context, category!.name)
                : TranslationService.tr(context, 'all'),
            style: TextStyle(color: isSelected ? Colors.white : null),
          ),
        ],
      ),
      backgroundColor: isSelected ? color : color.withValues(alpha: 0.1),
      onPressed: onTap,
    );
  }
}
