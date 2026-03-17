import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';
import 'package:tamplate_getx/modules/authentication/screens/auth_screen.dart';

class MockAuthController extends Mock implements AuthController {}

void main() {
  late MockAuthController controller;

  setUp(() {
    Get.testMode = true;

    controller = MockAuthController();

    when(() => controller.isLoading).thenReturn(false.obs);
    when(() => controller.login(any(), any())).thenAnswer((_) async {});

    Get.put<AuthController>(controller);
  });

  Widget createWidget() {
    return GetMaterialApp(home: AuthScreen());
  }

  /// UI Render
  testWidgets('should render login screen', (tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  /// Validation
  testWidgets('should show password validation error', (tester) async {
    await tester.pumpWidget(createWidget());

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text("Password tidak boleh kosong"), findsOneWidget);
  });

  /// Login action
  testWidgets('should call login when button tapped', (tester) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(find.byType(TextFormField).at(0), "test@mail.com");

    await tester.enterText(find.byType(TextFormField).at(1), "123456");

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(() => controller.login("test@mail.com", "123456")).called(1);
  });
}
