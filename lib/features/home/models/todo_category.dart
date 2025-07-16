import 'package:flutter/material.dart';

enum TodoCategory {
  personal(icon: Icons.person, label: 'Personal', color: Colors.blue),
  work(icon: Icons.work, label: 'Work', color: Colors.orange),
  shopping(icon: Icons.shopping_cart, label: 'Shopping', color: Colors.green),
  health(icon: Icons.favorite, label: 'Health', color: Colors.red),
  education(icon: Icons.school, label: 'Education', color: Colors.purple),
  finance(icon: Icons.attach_money, label: 'Finance', color: Colors.teal);

  final IconData icon;
  final String label;
  final Color color;

  const TodoCategory({
    required this.icon,
    required this.label,
    required this.color,
  });
}
