import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert'; // Required for jsonEncode


class CryptoUtils {
  // Encryption key (32 bytes for AES-256)
  static final encrypt.Key encryptionKey = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');

  // Initialization vector (16 bytes for AES)
  static final encrypt.IV iv = encrypt.IV.fromLength(16);

  // Encrypt the data using AES
  static String encryptData(Map<String, dynamic> data) {
    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey, mode: encrypt.AESMode.cbc));
      final jsonString = jsonEncode(data);
      final encrypted = encrypter.encrypt(jsonString, iv: iv);
      return encrypted.base64;
    } catch (e) {
      throw Exception('Encryption failed: $e');
    }
  }
}