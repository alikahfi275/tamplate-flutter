import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';
import 'package:tamplate_getx/data/repositories/api_repository.dart';
import 'package:tamplate_getx/services/auth_service.dart';
import 'package:tamplate_getx/data/models/auth_model.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;

  late AuthController controller;
  late MockAuthRepository repository;
  late MockAuthService storage;

  setUp(() {
    repository = MockAuthRepository();
    storage = MockAuthService();

    controller = AuthController(repository, storage);
  });

  test('login success should save token', () async {
    final auth = AuthModel(
      id: 1,
      username: "test",
      email: "test@email.com",
      firstName: "Test",
      lastName: "User",
      gender: "male",
      image: "",
      accessToken: "token123",
      refreshToken: "refresh123",
    );

    when(
      () => repository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => auth);

    when(() => storage.saveTokens(any(), any())).thenAnswer((_) async {});

    await controller.login("test@email.com", "123456");

    verify(
      () => repository.login(email: "test@email.com", password: "123456"),
    ).called(1);

    verify(() => storage.saveTokens("token123", "refresh123")).called(1);
  }, skip: true);
}
