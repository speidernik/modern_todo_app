// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modern_todo_app/core/app.dart';
import 'package:modern_todo_app/core/firebase/firebase_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Constants for Firestore collection and field names
const String usersCollection = 'users';
const String fcmTokenField = 'fcmToken';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with proper configuration
  await FirebaseConfig.initialize();
  await _initFirebaseMessaging();

  runApp(const ProviderScope(child: TodoApp()));
}

Future<void> _initFirebaseMessaging() async {
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  // Save FCM token to Firestore
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final token = await messaging.getToken();
    if (token != null) {
      await FirebaseFirestore.instance.collection(usersCollection).doc(user.uid).set({
        fcmTokenField: token,
      }, SetOptions(merge: true));
    }
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await FirebaseFirestore.instance.collection(usersCollection).doc(user.uid).set({
        fcmTokenField: newToken,
      }, SetOptions(merge: true));
    });
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle foreground messages
    if (kDebugMode) {
      print('Received foreground message: \\${message.notification?.title}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseConfig.initialize();
  if (kDebugMode) {
    print('Handling a background message: \\${message.messageId}');
  }
}

// The main app widget is defined in core/app.dart as TodoApp.
// Removed unused MyApp and MyHomePage classes from template.
