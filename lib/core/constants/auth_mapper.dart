import 'package:tamplate_getx/data/models/auth_model.dart';
import 'package:tamplate_getx/data/models/user_model.dart';

UserModel toUserModel(AuthModel auth) {
  final user = UserModel()
    ..userId = auth.id
    ..username = auth.username
    ..email = auth.email
    ..firstName = auth.firstName
    ..lastName = auth.lastName
    ..gender = auth.gender
    ..image = auth.image;

  return user;
}
