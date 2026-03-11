import 'package:isar/isar.dart';

part 'token_model.g.dart';

@collection
class TokenModel {
  Id id = Isar.autoIncrement;

  String? accessToken;
  String? refreshToken;
}
