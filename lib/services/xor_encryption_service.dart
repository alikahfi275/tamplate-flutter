class XorEncryptionService {
  static const String _key = "tamplate_secret_key";

  String encrypt(String text) {
    final textBytes = text.codeUnits;
    final keyBytes = _key.codeUnits;

    final result = List<int>.generate(
      textBytes.length,
      (i) => textBytes[i] ^ keyBytes[i % keyBytes.length],
    );

    return result.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  String decrypt(String encrypted) {
    // convert HEX → bytes
    final bytes = <int>[];
    for (int i = 0; i < encrypted.length; i += 2) {
      bytes.add(int.parse(encrypted.substring(i, i + 2), radix: 16));
    }

    final keyBytes = _key.codeUnits;

    final result = List<int>.generate(
      bytes.length,
      (i) => bytes[i] ^ keyBytes[i % keyBytes.length],
    );

    return String.fromCharCodes(result);
  }

  bool isEncrypted(String value) {
    return !value.startsWith('eyJ');
  }
}
