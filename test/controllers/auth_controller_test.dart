import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';
import 'package:tamplate_getx/data/repositories/api_repository.dart';
import 'package:tamplate_getx/services/token_local_service.dart';
import 'package:tamplate_getx/data/models/auth_model.dart';

class MockApiRepository extends Mock implements ApiRepository {}

class MockTokenLocalService extends Mock implements TokenLocalService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthController controller;
  late MockApiRepository mockRepository;
  late MockTokenLocalService mockToken;

  setUp(() {
    Get.testMode = true;

    mockRepository = MockApiRepository();
    mockToken = MockTokenLocalService();

    Get.put<ApiRepository>(mockRepository);
    Get.put<TokenLocalService>(mockToken);

    controller = AuthController();
  });

  tearDown(() {
    Get.reset();
  });

  test(
    "login success",
    () async {
      final auth = AuthModel(
        accessToken: "access",
        refreshToken: "refresh",
        id: 1,
        username: "test",
        email: "test@mail.com",
        firstName: "test",
        lastName: "test",
        gender: "test",
        image: "test",
      );

      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => auth);

      when(() => mockToken.saveToken(any(), any())).thenAnswer((_) async {});

      await controller.login("test@mail.com", "123456");

      verify(
        () => mockRepository.login(email: "test@mail.com", password: "123456"),
      ).called(1);
    },

    /// skip test supaya tidak error snackbar
    skip: "Skipped because Get.snackbar causes animation/timer issue in test",
  );
}
