import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EncryptMessage {
  static String encryptAES(String message) {
    final key = Key.fromUtf8(dotenv.env['AES_KEY']!);
    final iv = IV.fromUtf8(dotenv.env['IV_KEY']!);
    final Encrypter encrypter = Encrypter(AES(key));
    final Encrypted encrypted = encrypter.encrypt(message, iv: iv);
    return encrypted.base64;
  }

  static String decryptAES(String messageBase64) {
    final key = Key.fromUtf8(dotenv.env['AES_KEY']!);
    final iv = IV.fromUtf8(dotenv.env['IV_KEY']!);
    final Encrypter encrypter = Encrypter(AES(key));
    final String decryptedMessage = encrypter.decrypt64(messageBase64, iv: iv);
    return decryptedMessage;
  }
}
