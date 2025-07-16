import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  static final _key =
      encrypt.Key.fromUtf8('12345678901234567890123456789012'); // 32 Zeichen
  static final _iv = encrypt.IV.fromUtf8('1234567890123456'); // 16 Zeichen
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  static String encryptData(String? data) {
    if (data == null || data.isEmpty) return '';
    final encrypted = _encrypter.encrypt(data, iv: _iv);
    return encrypted.base64;
  }

  static String decryptData(String? encryptedData) {
    if (encryptedData == null || encryptedData.isEmpty) return '';
    final encrypted = encrypt.Encrypted.fromBase64(encryptedData);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
}
