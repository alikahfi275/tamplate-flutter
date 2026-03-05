import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.account_circle),
        onPressed: () => Get.toNamed('/profile'),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;

        if (user == null) {
          return const Center(child: Text("User tidak ditemukan"));
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Username: ${user.username}"),

              Text("Email: ${user.email}"),

              Text("Name: ${user.firstName} ${user.lastName}"),

              Text("Name: ${controller.accessToken.value}"),

              Text("===================================="),

              Text("Name: ${controller.refreshToken.value}"),

              Text("Name: ${user.firstName} ${user.lastName}"),
            ],
          ),
        );
      }),
    );
  }
}
