import 'package:encrypt/encrypt.dart';

class EncryptionService {
  final _key = Key.fromUtf8('12345678901234567890123456789012');
  final _iv = IV.fromLength(16);

  late final Encrypter _encrypter;

  EncryptionService() {
    _encrypter = Encrypter(AES(_key));
  }

  String encryptText(String text) {
    return _encrypter.encrypt(text, iv: _iv).base64;
  }

  String decryptText(String text) {
    return _encrypter.decrypt(Encrypted.fromBase64(text), iv: _iv);
  }
}
