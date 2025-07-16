import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  static final _key =
      encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 chars
  static final _iv = encrypt.IV.fromUtf8('8bytesiv12345678'); // 16 chars
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  static String encryptText(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  static String decryptText(String encryptedText) {
    final decrypted = _encrypter.decrypt64(encryptedText, iv: _iv);
    return decrypted;
  }
}
