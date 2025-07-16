import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/l10n/translation_service.dart';
import 'package:modern_todo_app/features/chat/providers/chat_provider.dart';
import 'package:modern_todo_app/features/chat/services/encryption_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modern_todo_app/features/chat/models/message.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
import 'dart:ui';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  int? _reactionTargetIndex;
  int? _editDeleteIndex;
  final Map<String, String> _usernameCache = {};
  final bool _otherUserTyping = false;
  bool _shouldScrollToBottom = true;
  bool _isFirstLoad = true;
  bool _isKeyboardVisible = false;
  bool _isNearBottom = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Auto-scroll to bottom when screen is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final threshold = maxScroll - 300; // 300px threshold for better UX

      final wasNearBottom = _isNearBottom;
      _isNearBottom = currentScroll >= threshold;

      // Only update shouldScrollToBottom if we're actually near bottom
      if (_isNearBottom) {
        setState(() {
          _shouldScrollToBottom = true;
        });
      } else if (wasNearBottom && !_isNearBottom) {
        setState(() {
          _shouldScrollToBottom = false;
        });
      }
    }
  }

  void _checkKeyboardVisibility() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final wasKeyboardVisible = _isKeyboardVisible;
    _isKeyboardVisible = bottomInset > 0;

    // If keyboard just appeared, scroll to bottom to show latest message
    if (!wasKeyboardVisible && _isKeyboardVisible) {
      Future.delayed(const Duration(milliseconds: 200), _scrollToBottom);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      // Add a small delay to ensure the layout is complete
      Future.delayed(const Duration(milliseconds: 50), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _showReactions(int index) {
    setState(() {
      _reactionTargetIndex = index;
      _editDeleteIndex = null;
    });
  }

  void _hideReactions() {
    setState(() {
      _reactionTargetIndex = null;
    });
  }

  void _showEditDelete(int index) {
    setState(() {
      _editDeleteIndex = index;
      _reactionTargetIndex = null;
    });
  }

  void _hideEditDelete() {
    setState(() {
      _editDeleteIndex = null;
    });
  }

  Widget _buildStatusIcon(String status) {
    // For demo: status can be 'sent', 'delivered', 'read'
    switch (status) {
      case 'read':
        return const Icon(Icons.done_all, size: 16, color: Colors.blueAccent);
      case 'delivered':
        return const Icon(Icons.done_all, size: 16, color: Colors.grey);
      case 'sent':
      default:
        return const Icon(Icons.check, size: 16, color: Colors.grey);
    }
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts.last[0]).toUpperCase();
  }

  String _formatDate(DateTime utcTime) {
    final localTime = utcTime.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate =
        DateTime(localTime.year, localTime.month, localTime.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (messageDate == today) {
      return TranslationService.tr(context, 'today');
    } else if (messageDate == yesterday) {
      return TranslationService.tr(context, 'yesterday');
    } else {
      return DateFormat(
              'EEEE, MMMM d', Localizations.localeOf(context).languageCode)
          .format(localTime);
    }
  }

  String _formatTime(DateTime utcTime) {
    final localTime = utcTime.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate =
        DateTime(localTime.year, localTime.month, localTime.day);

    // If message is from today, show only time
    if (messageDate == today) {
      return DateFormat('HH:mm').format(localTime);
    }
    // If message is from yesterday, show "Yesterday" and time
    else if (messageDate == today.subtract(const Duration(days: 1))) {
      return '${TranslationService.tr(context, 'yesterday')} ${DateFormat('HH:mm').format(localTime)}';
    }
    // If message is from this week, show day name and time
    else if (localTime.isAfter(now.subtract(const Duration(days: 7)))) {
      return '${DateFormat('EEEE', Localizations.localeOf(context).languageCode).format(localTime)} ${DateFormat('HH:mm').format(localTime)}';
    }
    // If message is older, show date and time
    else {
      return '${DateFormat('dd/MM/yyyy', Localizations.localeOf(context).languageCode).format(localTime)} ${DateFormat('HH:mm').format(localTime)}';
    }
  }

  bool _shouldShowDateHeader(
      DateTime currentMessageTime, DateTime? previousMessageTime) {
    if (previousMessageTime == null) return true;

    final currentDate = DateTime(currentMessageTime.year,
        currentMessageTime.month, currentMessageTime.day);
    final previousDate = DateTime(previousMessageTime.year,
        previousMessageTime.month, previousMessageTime.day);

    return currentDate != previousDate;
  }

  Future<String> _getUsername(String userId) async {
    if (_usernameCache.containsKey(userId)) {
      return _usernameCache[userId]!;
    }
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final encrypted = doc.data()?['username'] ?? '';
      String username = 'Anonymous';
      if (encrypted.isNotEmpty) {
        username = EncryptionService.decryptText(encrypted);
      }
      _usernameCache[userId] = username;
      return username;
    } catch (e) {
      return 'Anonymous';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Scaffold(
        body:
            Center(child: Text(TranslationService.tr(context, 'notLoggedIn'))),
      );
    }
    final currentUserId = currentUser.uid;
    _checkKeyboardVisibility();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Animated, vibrant gradient background with glassmorphism overlay
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F2027),
                    const Color(0xFF2C5364),
                    const Color(0xFF1A2980),
                    const Color(0xFF43CEA2),
                    const Color(0xFF185A9D),
                  ],
                  stops: [0.0, 0.3, 0.6, 0.8, 1.0],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                child: Container(
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
          ),
          // Animated floating particles (already present)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedParticles(),
            ),
          ),
          // Modern AppBar with glass effect
          SafeArea(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.bubble_chart_rounded,
                          color: Colors.cyanAccent, size: 36),
                      const SizedBox(width: 12),
                      Text(
                        TranslationService.tr(context, 'chat'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          fontFamily: 'Montserrat',
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.wifi_tethering,
                                color: Colors.cyanAccent, size: 20),
                            const SizedBox(width: 6),
                            Text('Online',
                                style: TextStyle(
                                    color: Colors.cyanAccent,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer(
                    builder: (context, ref, _) {
                      final messagesAsync = ref.watch(chatMessagesProvider);
                      return messagesAsync.when(
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          error: (e, st) => Center(
                                child: Text(
                                  '${TranslationService.tr(context, 'error')}: $e',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ),
                          data: (messages) {
                            // If no messages, show empty state
                            if (messages == null || messages.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      size: 64,
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.3),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      TranslationService.tr(
                                          context, 'noMessagesYet'),
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (messages.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      size: 64,
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.3),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      TranslationService.tr(
                                          context, 'noMessagesYet'),
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            // Sort messages by timestamp (oldest first for proper display)
                            final sortedMessages = List<Message>.from(messages)
                              ..sort(
                                  (a, b) => a.timestamp.compareTo(b.timestamp));

                            // Auto-scroll logic - ensure we scroll to bottom for new messages
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (_shouldScrollToBottom || _isFirstLoad) {
                                _scrollToBottom();
                                _isFirstLoad = false;
                              }
                            });

                            List<Widget> messageWidgets = [];
                            DateTime? previousMessageTime;

                            // Build messages in chronological order (oldest to newest)
                            for (int i = 0; i < sortedMessages.length; i++) {
                              final msg = sortedMessages[i];
                              final isMe = msg.senderId == currentUserId;
                              final text = EncryptionService.decryptText(
                                  msg.encryptedContent);
                              final localTimestamp = msg.timestamp.toLocal();

                              // Show date header if needed
                              if (_shouldShowDateHeader(
                                  localTimestamp, previousMessageTime)) {
                                messageWidgets.add(
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme
                                              .surfaceContainerHighest
                                              .withValues(alpha: 0.7),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                          _formatDate(msg.timestamp),
                                          style: theme.textTheme.labelMedium
                                              ?.copyWith(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: 0.7),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              previousMessageTime = localTimestamp;

                              // Determine if this message is the last in a group from the same sender
                              final isLastInGroup =
                                  i == sortedMessages.length - 1 ||
                                      sortedMessages[i + 1].senderId !=
                                          msg.senderId;

                              messageWidgets.add(
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: isLastInGroup ? 8 : 2,
                                    bottom: isLastInGroup ? 8 : 2,
                                    left: isMe ? 64 : 8,
                                    right: isMe ? 8 : 64,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: isMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if (!isMe && isLastInGroup)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: FutureBuilder<String>(
                                            future: _getUsername(msg.senderId),
                                            builder: (context, snapshot) {
                                              final username =
                                                  snapshot.data ?? '?';
                                              return CircleAvatar(
                                                radius: 16,
                                                backgroundColor: theme
                                                    .colorScheme.primary
                                                    .withValues(alpha: 0.18),
                                                child: Text(
                                                  _getInitials(username),
                                                  style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: isMe
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            if (!isMe && isLastInGroup)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4),
                                                child: FutureBuilder<String>(
                                                  future: _getUsername(
                                                      msg.senderId),
                                                  builder: (context, snapshot) {
                                                    final username =
                                                        snapshot.data ?? '...';
                                                    return Text(
                                                      username,
                                                      style: theme
                                                          .textTheme.labelSmall
                                                          ?.copyWith(
                                                        color: theme.colorScheme
                                                            .onSurface
                                                            .withValues(
                                                                alpha: 0.6),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            GestureDetector(
                                              onLongPress: () =>
                                                  _showEditDelete(i),
                                              onTap: () => _showReactions(i),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 280),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 12),
                                                decoration: BoxDecoration(
                                                  color: isMe
                                                      ? theme
                                                          .colorScheme.primary
                                                      : theme.colorScheme
                                                          .surfaceContainerHighest,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            18),
                                                    topRight:
                                                        const Radius.circular(
                                                            18),
                                                    bottomLeft: Radius.circular(
                                                        isMe ? 18 : 6),
                                                    bottomRight:
                                                        Radius.circular(
                                                            isMe ? 6 : 18),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                              alpha: 0.05),
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(0, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      text,
                                                      style: theme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                        color: isMe
                                                            ? theme.colorScheme
                                                                .onPrimary
                                                            : theme.colorScheme
                                                                .onSurface,
                                                        fontSize: 16,
                                                        height: 1.4,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          _formatTime(
                                                              msg.timestamp),
                                                          style: theme.textTheme
                                                              .labelSmall
                                                              ?.copyWith(
                                                            color: isMe
                                                                ? theme
                                                                    .colorScheme
                                                                    .onPrimary
                                                                    .withValues(
                                                                        alpha:
                                                                            0.7)
                                                                : theme
                                                                    .colorScheme
                                                                    .onSurface
                                                                    .withValues(
                                                                        alpha:
                                                                            0.5),
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                        if (isMe) ...[
                                                          const SizedBox(
                                                              width: 4),
                                                          _buildStatusIcon(
                                                              'read'),
                                                        ],
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (_reactionTargetIndex == i)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    _buildReactionEmoji('👍'),
                                                    _buildReactionEmoji('😂'),
                                                    _buildReactionEmoji('❤️'),
                                                    _buildReactionEmoji('😮'),
                                                    _buildReactionEmoji('😢'),
                                                    _buildReactionEmoji('👏'),
                                                  ],
                                                ),
                                              ),
                                            if (_editDeleteIndex == i)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextButton.icon(
                                                      onPressed: () =>
                                                          _hideEditDelete(),
                                                      icon: const Icon(
                                                          Icons.edit,
                                                          size: 16),
                                                      label: const Text('Edit'),
                                                    ),
                                                    TextButton.icon(
                                                      onPressed: () =>
                                                          _hideEditDelete(),
                                                      icon: const Icon(
                                                          Icons.delete,
                                                          size: 16),
                                                      label:
                                                          const Text('Delete'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (isMe && isLastInGroup)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: FutureBuilder<String>(
                                            future: _getUsername(currentUserId),
                                            builder: (context, snapshot) {
                                              final username =
                                                  snapshot.data ?? '?';
                                              return CircleAvatar(
                                                radius: 16,
                                                backgroundColor: theme
                                                    .colorScheme.primary
                                                    .withValues(alpha: 0.18),
                                                child: Text(
                                                  _getInitials(username),
                                                  style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            // Always return a widget to satisfy the non-nullable return type
                            return ListView(
                              controller: _scrollController,
                              reverse: false,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              physics: const BouncingScrollPhysics(),
                              children: [
                                ...messageWidgets,
                                const SizedBox(height: 20),
                                if (_otherUserTyping)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 8.0, bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme
                                              .surfaceContainerHighest,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        theme.colorScheme
                                                            .primary),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              TranslationService.tr(
                                                  context, 'userTyping'),
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withValues(alpha: 0.7),
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            controller: _controller,
                            minLines: 1,
                            maxLines: 4,
                            style: theme.textTheme.bodyLarge,
                            decoration: InputDecoration(
                              hintText:
                                  TranslationService.tr(context, 'typeMessage'),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 14),
                            ),
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 200),
                                  _scrollToBottom);
                            },
                            onSubmitted: (_) =>
                                _sendMessage(context, currentUserId),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _sendMessage(context, currentUserId),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.18),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.send,
                              color: Colors.white, size: 22),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionEmoji(String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => _hideReactions(),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context, String currentUserId) async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();

    try {
      await ref.read(chatServiceProvider).sendMessage(
            chatId: 'global',
            senderId: currentUserId,
            receiverId: '',
            plainText: text,
          );

      if (!mounted) return;

      // Force scroll to bottom after sending message
      setState(() {
        _shouldScrollToBottom = true;
      });

      // Wait for the message to be added to the list, then scroll to bottom
      Future.delayed(const Duration(milliseconds: 400), () {
        if (!context.mounted) return;
        _scrollToBottom();
      });
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${TranslationService.tr(context, 'errorSendingMessage')}: $e')),
      );
    }
  }
}

// Add this widget at the bottom of the file if not already present
class AnimatedParticles extends StatefulWidget {
  const AnimatedParticles({super.key});

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final int _particleCount = 18;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 12))
          ..repeat();
    _particles = List.generate(_particleCount, (i) => _Particle(_random));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(_particles, _controller.value),
        );
      },
    );
  }
}

class _Particle {
  late double x, y, radius, speed, angle, opacity;
  late Color color;
  final Random random;

  _Particle(this.random) {
    reset();
  }

  void reset() {
    x = random.nextDouble();
    y = random.nextDouble();
    radius = random.nextDouble() * 12 + 8;
    speed = random.nextDouble() * 0.2 + 0.05;
    angle = random.nextDouble() * 2 * pi;
    opacity = random.nextDouble() * 0.3 + 0.2;
    color = Color.lerp(Colors.white, Colors.blueAccent, random.nextDouble())!
        .withOpacity(opacity);
  }

  void update(double t) {
    x += cos(angle) * speed * t * 0.5;
    y += sin(angle) * speed * t * 0.5;
    if (x < 0 || x > 1 || y < 0 || y > 1) reset();
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticlePainter(this.particles, this.progress) {
    for (final p in particles) {
      p.update(progress);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = p.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(
          Offset(p.x * size.width, p.y * size.height), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
