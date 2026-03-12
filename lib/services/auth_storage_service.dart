import 'package:get_storage/get_storage.dart';

import 'package:encrypt/encrypt.dart' as encrypt;

class AuthStorageService {
  final box = GetStorage();

  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  final _key = encrypt.Key.fromUtf8('32characterslongsecretkey1234');
  final _iv = encrypt.IV.fromLength(16);

  late final encrypt.Encrypter _encrypter;

  AuthStorageService() {
    _encrypter = encrypt.Encrypter(encrypt.AES(_key));
  }

  String _encrypt(String value) {
    return _encrypter.encrypt(value, iv: _iv).base64;
  }

  String _decrypt(String value) {
    return _encrypter.decrypt64(value, iv: _iv);
  }

  Future<void> saveTokens(String access, String refresh) async {
    box.write(_accessKey, _encrypt(access));
    box.write(_refreshKey, _encrypt(refresh));
  }

  Future<String?> getAccessToken() async {
    final token = box.read(_accessKey);
    if (token == null) return null;

    return _decrypt(token);
  }

  Future<String?> getRefreshToken() async {
    final token = box.read(_refreshKey);
    if (token == null) return null;

    return _decrypt(token);
  }

  Future<void> clear() async {
    await box.erase();
  }
}
