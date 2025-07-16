import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSettings {
  final String username;
  final String email;

  AccountSettings({
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
    };
  }

  factory AccountSettings.fromMap(Map<String, dynamic> map) {
    return AccountSettings(
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }
}

class AccountSettingsService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUsername(String newUsername) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    // Update in Firestore
    await _firestore.collection('users').doc(user.uid).update({
      'username': newUsername,
    });
  }

  Future<void> updateEmail(String newEmail, String password) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    // Reauthenticate user before changing email
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);

    // Update email in Firebase Auth
    await user.updateEmail(newEmail);

    // Update email in Firestore
    await _firestore.collection('users').doc(user.uid).update({
      'email': newEmail,
    });
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    // Reauthenticate user before changing password
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);

    // Update password
    await user.updatePassword(newPassword);
  }

  Future<AccountSettings> getCurrentSettings() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return AccountSettings.fromMap(doc.data()!);
  }
}
