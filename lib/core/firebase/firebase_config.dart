import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modern_todo_app/firebase_options.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Configure Firestore settings
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled:
          false, // Disable persistence to avoid multi-process issues
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }
}
