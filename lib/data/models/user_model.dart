import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;

  int? userId;

  String? username;

  String? email;

  String? firstName;

  String? lastName;

  String? gender;

  String? image;
}
