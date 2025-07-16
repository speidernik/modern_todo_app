import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/todo/providers/todo_provider.dart';
import 'package:modern_todo_app/features/todo/models/todo.dart';
import 'package:intl/intl.dart';

class AddTodoDialog extends ConsumerStatefulWidget {
  final Todo? todo;

  const AddTodoDialog({super.key, this.todo});

  @override
  ConsumerState<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends ConsumerState<AddTodoDialog>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _dueDate;
  late TimeOfDay _dueTime;
  late Priority _priority;
  late bool _isCompleted;
  bool _isLoading = false;
  bool _hasDueDate = false;
  bool _hasDueTime = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.todo?.description ?? '');
    _dueDate = widget.todo?.dueDate ?? DateTime.now();
    _dueTime = TimeOfDay.fromDateTime(widget.todo?.dueDate ?? DateTime.now());
    _priority = widget.todo?.priority ?? Priority.medium;
    _isCompleted = widget.todo?.isCompleted ?? false;
    _hasDueDate = widget.todo?.dueDate != null;
    _hasDueTime = widget.todo?.dueDate != null;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
    }
  }

  IconData _getPriorityIcon(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Icons.flag_outlined;
      case Priority.medium:
        return Icons.flag;
      case Priority.high:
        return Icons.flag_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 600;
    final isEditing = widget.todo != null;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 500 : double.infinity,
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(24),
                color: theme.colorScheme.surface,
                elevation: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                          Icon(
                            isEditing ? Icons.edit_note : Icons.add_task,
                            color: theme.colorScheme.onPrimaryContainer,
                            size: 28,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              isEditing
                                  ? TranslationService.tr(context, 'editTask')
                                  : TranslationService.tr(context, 'addTask'),
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: theme
                                  .colorScheme.onPrimaryContainer
                                  .withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Form Content
                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 24,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Title Field
                              _buildTitleField(theme),
                              const SizedBox(height: 20),

                              // Description Field
                              _buildDescriptionField(theme),
                              const SizedBox(height: 20),

                              // Priority Selection
                              _buildPrioritySelection(theme),
                              const SizedBox(height: 20),

                              // Due Date & Time Section
                              _buildDateTimeSection(theme),
                              const SizedBox(height: 20),

                              // Completed Checkbox (only for editing)
                              if (isEditing) ...[
                                _buildCompletedCheckbox(theme),
                                const SizedBox(height: 20),
                              ],

                              // Action Buttons
                              _buildActionButtons(theme, isEditing),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField(ThemeData theme) {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: TranslationService.tr(context, 'taskTitle'),
        hintText: TranslationService.tr(context, 'enterTaskTitle'),
        prefixIcon: const Icon(Icons.title),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      style: theme.textTheme.titleMedium,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return TranslationService.tr(context, 'titleRequired');
        }
        return null;
      },
      autofocus: true,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildDescriptionField(ThemeData theme) {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: TranslationService.tr(context, 'description'),
        hintText: TranslationService.tr(context, 'descriptionOptional'),
        prefixIcon: const Icon(Icons.description),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      ),
      maxLines: 3,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildPrioritySelection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TranslationService.tr(context, 'priority'),
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: Priority.values.map((priority) {
            final isSelected = _priority == priority;
            final color = _getPriorityColor(priority);

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () => setState(() => _priority = priority),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? color.withOpacity(0.2)
                          : theme.colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? color : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          _getPriorityIcon(priority),
                          color: isSelected
                              ? color
                              : theme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          TranslationService.tr(context, priority.name),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? color
                                : theme.colorScheme.onSurfaceVariant,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TranslationService.tr(context, 'dueDate'),
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),

        // Date Selection
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _dueDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: theme.colorScheme,
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              setState(() {
                _dueDate = date;
                _hasDueDate = true;
              });
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hasDueDate
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: _hasDueDate
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _hasDueDate
                        ? DateFormat('EEEE, MMMM d, y').format(_dueDate)
                        : TranslationService.tr(context, 'selectDueDate'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _hasDueDate
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (_hasDueDate)
                  IconButton(
                    onPressed: () => setState(() => _hasDueDate = false),
                    icon: const Icon(Icons.clear),
                    iconSize: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Time Selection
        InkWell(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: _dueTime,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: theme.colorScheme,
                  ),
                  child: child!,
                );
              },
            );
            if (time != null) {
              setState(() {
                _dueTime = time;
                _hasDueTime = true;
              });
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hasDueTime
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline.withOpacity(0.5),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: _hasDueTime
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _hasDueTime
                        ? _dueTime.format(context)
                        : TranslationService.tr(context, 'selectTimeOptional'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: _hasDueTime
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (_hasDueTime)
                  IconButton(
                    onPressed: () => setState(() => _hasDueTime = false),
                    icon: const Icon(Icons.clear),
                    iconSize: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedCheckbox(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _isCompleted,
            onChanged: (value) {
              if (value != null) {
                setState(() => _isCompleted = value);
              }
            },
            activeColor: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              TranslationService.tr(context, 'completed'),
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme, bool isEditing) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              TranslationService.tr(context, 'cancel'),
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: FilledButton(
            onPressed: _isLoading ? null : _saveTodo,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    isEditing
                        ? TranslationService.tr(context, 'save')
                        : TranslationService.tr(context, 'add'),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveTodo() async {
    if (_isLoading) return;

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dueDateTime = _hasDueDate || _hasDueTime
          ? DateTime(
              _dueDate.year,
              _dueDate.month,
              _dueDate.day,
              _hasDueTime ? _dueTime.hour : 23,
              _hasDueTime ? _dueTime.minute : 59,
            )
          : DateTime.now()
              .add(const Duration(days: 7)); // Default to 1 week from now

      final todo = Todo(
        id: widget.todo?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        dueDate: dueDateTime,
        priority: _priority,
        isCompleted: _isCompleted,
      );

      if (widget.todo != null) {
        ref.read(todoProvider.notifier).updateTodo(todo);
      } else {
        ref.read(todoProvider.notifier).addTodo(todo);
      }

      if (mounted) {
        final isEditing = widget.todo != null;
        final theme = Theme.of(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? TranslationService.tr(context, 'taskUpdated')
                  : TranslationService.tr(context, 'taskAdded'),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              TranslationService.tr(context, 'errorSaving'),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
