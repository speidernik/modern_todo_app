import 'package:flutter/material.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/chat/presentation/screens/chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TranslationService.tr(context, 'globalChat'))),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          ),
          child: Text(TranslationService.tr(context, 'globalChat')),
        ),
      ),
    );
  }
}
