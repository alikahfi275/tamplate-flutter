import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

class EncryptionKeyService {
  static const fileName = "isar_key";

  Future<List<int>> getKey() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$fileName");

    if (await file.exists()) {
      final keyString = await file.readAsString();
      return keyString.codeUnits;
    }

    final random = Random.secure();
    final key = List<int>.generate(32, (_) => random.nextInt(256));

    await file.writeAsString(String.fromCharCodes(key));

    return key;
  }
}
