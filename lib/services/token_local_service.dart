import 'isar_service.dart';
import 'package:isar/isar.dart';

import 'package:tamplate_getx/data/models/token_model.dart';
import 'package:tamplate_getx/services/xor_encryption_service.dart';

class TokenLocalService {
  final encryption = XorEncryptionService();

  Future<void> saveToken(String accessToken, String refreshToken) async {
    final isar = IsarService.isar;

    final encryptedAccess = encryption.encrypt(accessToken);
    final encryptedRefresh = encryption.encrypt(refreshToken);

    await isar.writeTxn(() async {
      await isar.tokenModels.clear();

      await isar.tokenModels.put(
        TokenModel()
          ..accessToken = encryptedAccess
          ..refreshToken = encryptedRefresh,
      );
    });
  }

  Future<TokenModel?> getToken() async {
    final isar = IsarService.isar;
    final token = await isar.tokenModels.where().findFirst();

    if (token == null) return null;

    if (token.accessToken != null &&
        encryption.isEncrypted(token.accessToken!)) {
      token.accessToken = encryption.decrypt(token.accessToken!);
    }

    if (token.refreshToken != null &&
        encryption.isEncrypted(token.refreshToken!)) {
      token.refreshToken = encryption.decrypt(token.refreshToken!);
    }

    return token;
  }

  Future<void> clearToken() async {
    final isar = IsarService.isar;

    await isar.writeTxn(() async {
      await isar.tokenModels.clear();
    });
  }
}
