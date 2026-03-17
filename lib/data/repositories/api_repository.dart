import 'package:dio/dio.dart';

import 'package:tamplate_getx/data/models/auth_model.dart';
import 'package:tamplate_getx/data/models/user_api_model.dart';
import 'package:tamplate_getx/data/providers/api_provider.dart';

class ApiRepository {
  final ApiProvider provider;

  ApiRepository(this.provider);

  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await provider.postLogin(email: email, password: password);

      return AuthModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login gagal");
    }
  }

  Future<UserApiModel> getProfile() async {
    try {
      final data = await provider.getProfile();
      return UserApiModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login gagal");
    }
  }
}
