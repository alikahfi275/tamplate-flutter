import 'package:tamplate_getx/services/dio_service.dart';

class AuthProvider {
  final DioService dioService;

  AuthProvider(this.dioService);

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

  Future<Map<String, dynamic>> postRefresh(String refreshToken) async {
    final response = await dioService.dio.post(
      "/auth/refresh",
      data: {"refreshToken": refreshToken},
    );

    return response.data;
  }
}
