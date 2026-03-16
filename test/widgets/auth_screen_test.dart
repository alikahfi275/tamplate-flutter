import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:tamplate_getx/modules/authentication/screens/auth_screen.dart';
import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';

import 'package:tamplate_getx/services/dio_service.dart';
import 'package:tamplate_getx/data/providers/api_provider.dart';
import 'package:tamplate_getx/data/repositories/api_repository.dart';
import 'package:tamplate_getx/services/token_local_service.dart';

class DummyAuthController extends GetxController implements AuthController {
  @override
  final ApiRepository repository = Get.find<ApiRepository>();

  @override
  final TokenLocalService localStorage = Get.find<TokenLocalService>();

  @override
  final isLoading = false.obs;

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> logout() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DummyAuthController controller;

  setUp(() {
    Get.testMode = true;

    /// dependency chain
    Get.put(DioService());
    Get.put(ApiProvider());
    Get.put(ApiRepository());
    Get.put(TokenLocalService());

    controller = DummyAuthController();
    Get.put<AuthController>(controller);
  });

  tearDown(() {
    Get.reset();
  });

  Widget createWidget() {
    return GetMaterialApp(home: AuthScreen());
  }

  testWidgets("AuthScreen renders UI correctly", (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.text("Login"), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets("shows validation error when password < 6", (tester) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(find.byType(TextFormField).at(0), "test@mail.com");
    await tester.enterText(find.byType(TextFormField).at(1), "123");

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text("Password minimal 6 karakter"), findsOneWidget);
  });
}
