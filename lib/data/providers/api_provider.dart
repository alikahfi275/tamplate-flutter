import 'package:get/get.dart';

import 'package:tamplate_getx/services/dio_service.dart';

class ApiProvider {
  final dioService = Get.find<DioService>();

  ApiProvider();

  Future<Map<String, dynamic>> postLogin({
    required String email,
    required String password,
  }) async {
    final response = await dioService.dio.post(
      "/auth/login",
      data: {"username": email, "password": password, "expiresInMins": 1},
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getProfile() async {
    final response = await dioService.dio.get("/auth/me");
    return response.data;
  }
}
