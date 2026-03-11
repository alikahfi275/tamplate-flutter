import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tamplate_getx/data/repositories/auth_repository.dart';

import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';
import 'package:tamplate_getx/modules/authentication/screens/auth_screen.dart';
import 'package:tamplate_getx/services/auth_service.dart';

class FakeAuthRepository extends Fake implements AuthRepository {}

class FakeAuthService extends Fake implements AuthService {}

class FakeAuthController extends GetxController implements AuthController {
  @override
  final isLoading = false.obs;

  final AuthRepository _repository = FakeAuthRepository();
  final AuthService _storage = FakeAuthService();

  String? email;
  String? password;

  @override
  AuthRepository get repository => _repository;

  @override
  AuthService get storage => _storage;

  @override
  Future<void> login(String email, String password) async {
    this.email = email;
    this.password = password;
  }

  @override
  Future<void> logout() async {}
}

void main() {
  late FakeAuthController controller;

  setUp(() {
    Get.testMode = true;

    controller = FakeAuthController();

    Get.put<AuthController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Auth screen should render form', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: AuthScreen()));

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Should show error when password empty', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: AuthScreen()));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text("Password tidak boleh kosong"), findsOneWidget);
  });

  testWidgets('Should show error when password less than 6', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: AuthScreen()));

    await tester.enterText(find.byType(TextFormField).at(0), "test@email.com");
    await tester.enterText(find.byType(TextFormField).at(1), "123");

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text("Password minimal 6 karakter"), findsOneWidget);
  });

  testWidgets('Should call login when form valid', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: AuthScreen()));

    await tester.enterText(find.byType(TextFormField).at(0), "test@email.com");
    await tester.enterText(find.byType(TextFormField).at(1), "123456");

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(controller.email, "test@email.com");
    expect(controller.password, "123456");
  });
}
