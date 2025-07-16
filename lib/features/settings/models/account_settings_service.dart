import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'account_settings.dart';

class AccountSettingsService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<AccountSettings> getCurrentSettings() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user signed in');
    final doc = await _firestore.collection('users').doc(user.uid).get();
    final username = doc.data()?['username'] ?? '';
    return AccountSettings(
      username: username,
      email: user.email ?? '',
    );
  }

  Future<void> updateUsername(String username) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user signed in');
    await _firestore.collection('users').doc(user.uid).set(
      {'username': username},
      SetOptions(merge: true),
    );
  }

  Future<void> updateEmail(String email, String currentPassword) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user signed in');
    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(cred);
    await user.updateEmail(email);
    await _firestore.collection('users').doc(user.uid).set(
      {'email': email},
      SetOptions(merge: true),
    );
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user signed in');
    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(cred);
    await user.updatePassword(newPassword);
  }
}
