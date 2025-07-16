import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/features/home/models/todo.dart';
import 'package:modern_todo_app/features/home/models/todo_category.dart';
import 'package:modern_todo_app/features/home/providers/todo_provider.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';

class EditTodoDialog extends ConsumerStatefulWidget {
  final Todo todo;
  const EditTodoDialog({super.key, required this.todo});

  @override
  ConsumerState<EditTodoDialog> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends ConsumerState<EditTodoDialog>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late DateTime _selectedDate;
  late TodoCategory? _selectedCategory;
  late bool _isCompleted;
  bool _isLoading = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
    _selectedDate = widget.todo.dueDate ?? DateTime.now();
    _selectedCategory = widget.todo.category;
    _isCompleted = widget.todo.isCompleted;
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeInOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(_fadeAnim);
    _animController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _saveTodo() async {
    if (_isLoading) return; // Prevent double-tap
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(TranslationService.tr(context, 'enterTitle'))),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      final updated = widget.todo.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        dueDate: _selectedDate,
        category: _selectedCategory,
        isCompleted: _isCompleted,
      );
      await ref.read(todosProvider.notifier).updateTodo(updated);
      if (mounted) {
        Navigator.pop(context); // Always close on success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(TranslationService.tr(context, 'taskUpdated'))),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(TranslationService.tr(context, 'errorSaving'))),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420, maxHeight: 600),
              child: Material(
                borderRadius: BorderRadius.circular(24),
                color: theme.colorScheme.surface,
                elevation: 8,
                child: LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    height: constraints.maxHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.edit_note,
                                  color: theme.colorScheme.onPrimaryContainer),
                              const SizedBox(width: 12),
                              Text(
                                TranslationService.tr(context, 'editTask'),
                                style: theme.textTheme.titleLarge?.copyWith(
                                    color:
                                        theme.colorScheme.onPrimaryContainer),
                              ),
                            ],
                          ),
                        ),
                        // Scrollable form fields
                        Flexible(
                          child: Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextField(
                                      controller: _titleController,
                                      decoration: InputDecoration(
                                        labelText: TranslationService.tr(
                                            context, 'taskTitle'),
                                        border: const OutlineInputBorder(),
                                        prefixIcon: const Icon(Icons.title),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 12),
                                      ),
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: _descriptionController,
                                      decoration: InputDecoration(
                                        labelText: TranslationService.tr(
                                            context, 'description'),
                                        border: const OutlineInputBorder(),
                                        prefixIcon:
                                            const Icon(Icons.description),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 12),
                                      ),
                                      maxLines: 2,
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: theme.colorScheme.primary,
                                            size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit_calendar),
                                          onPressed: _selectDate,
                                          tooltip: TranslationService.tr(
                                              context, 'due_date'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: 0,
                                      children: [
                                        FilterChip(
                                          label: Text(TranslationService.tr(
                                              context, 'uncategorized')),
                                          selected: _selectedCategory == null,
                                          onSelected: (selected) => setState(
                                              () => _selectedCategory = null),
                                        ),
                                        ...TodoCategory.values
                                            .map((cat) => FilterChip(
                                                  label: Text(
                                                      TranslationService.tr(
                                                          context, cat.name)),
                                                  selected:
                                                      _selectedCategory == cat,
                                                  onSelected: (selected) =>
                                                      setState(() =>
                                                          _selectedCategory =
                                                              cat),
                                                )),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          _isCompleted
                                              ? Icons.check_circle
                                              : Icons.radio_button_unchecked,
                                          color: _isCompleted
                                              ? theme.colorScheme.primary
                                              : theme.iconTheme.color,
                                          size: 22,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          TranslationService.tr(
                                              context, 'completed'),
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        const Spacer(),
                                        Switch(
                                          value: _isCompleted,
                                          onChanged: (val) => setState(
                                              () => _isCompleted = val),
                                          activeColor:
                                              theme.colorScheme.primary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Action buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: _isLoading
                                    ? null
                                    : () => Navigator.pop(context),
                                child: Text(
                                    TranslationService.tr(context, 'cancel')),
                              ),
                              const SizedBox(width: 16),
                              FilledButton(
                                onPressed: _isLoading ? null : _saveTodo,
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2))
                                    : Text(
                                        TranslationService.tr(context, 'save')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
