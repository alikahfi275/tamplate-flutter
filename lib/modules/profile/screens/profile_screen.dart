import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:tamplate_getx/modules/profile/controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.category_rounded),
        onPressed: () => Get.toNamed('/products'),
      ),
      body: controller.obx(
        (user) => Column(
          children: [
            Image.network(user!.image),
            Text(user.username),
            Text("${user.firstName} ${user.lastName}"),
            Text(user.email),
          ],
        ),

        onLoading: const Center(child: CircularProgressIndicator()),

        onError: (error) => Center(child: Text(error ?? "Terjadi kesalahan")),

        onEmpty: const Center(child: Text("Data kosong")),
      ),
    );
  }
}
