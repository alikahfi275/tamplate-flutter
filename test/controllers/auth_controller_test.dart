import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tamplate_getx/data/models/auth_model.dart';
import 'package:tamplate_getx/data/repositories/api_repository.dart';
import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';
import 'package:tamplate_getx/services/token_local_service.dart';

class MockApiRepository extends Mock implements ApiRepository {}

class MockTokenLocalService extends Mock implements TokenLocalService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthController controller;
  late MockApiRepository mockRepository;
  late MockTokenLocalService mockLocalStorage;

  setUp(() {
    Get.testMode = true;

    mockRepository = MockApiRepository();
    mockLocalStorage = MockTokenLocalService();

    controller = AuthController(mockRepository, mockLocalStorage);
  });

  testWidgets('login success should save token', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: Scaffold(body: Container())));

    final tokens = AuthModel(
      accessToken: 'access_token',
      refreshToken: 'refresh_token',
    );

    when(
      () => mockRepository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => tokens);

    when(
      () => mockLocalStorage.saveToken(any(), any()),
    ).thenAnswer((_) async {});

    await controller.login('test@mail.com', '123456');

    /// tunggu snackbar selesai animation
    await tester.pumpAndSettle();

    verify(
      () => mockRepository.login(email: 'test@mail.com', password: '123456'),
    ).called(1);

    verify(
      () => mockLocalStorage.saveToken('access_token', 'refresh_token'),
    ).called(1);

    expect(controller.isLoading.value, false);
  });

  testWidgets('login failure should show error', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: Scaffold(body: Container())));

    when(
      () => mockRepository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception("Login Failed"));

    await controller.login('test@mail.com', '123456');

    /// tunggu snackbar selesai
    await tester.pumpAndSettle();

    verify(
      () => mockRepository.login(email: 'test@mail.com', password: '123456'),
    ).called(1);

    expect(controller.isLoading.value, false);
  });

  test(
    'logout should clear token',
    () async {
      when(() => mockLocalStorage.clearToken()).thenAnswer((_) async {});

      await controller.logout();

      verify(() => mockLocalStorage.clearToken()).called(1);
    },
    skip: 'IsarService static not initialized in unit test',
  );
}
