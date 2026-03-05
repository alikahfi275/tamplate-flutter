import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamplate_getx/modules/authentication/screens/auth_screen.dart';
import 'package:tamplate_getx/modules/home/bindings/home_binding.dart';
import 'package:tamplate_getx/modules/home/screens/home_screen.dart';
import 'package:tamplate_getx/modules/profile/bindings/profile_binding.dart';
import 'package:tamplate_getx/modules/profile/screens/profile_screen.dart';
import 'package:tamplate_getx/services/isar_service.dart';
import 'modules/authentication/bindings/auth_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IsarService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => AuthScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileScreen(),
          binding: ProfileBinding(),
        ),
      ],
    );
  }
}
