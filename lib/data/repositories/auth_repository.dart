import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tamplate_getx/data/models/user_api_model.dart';
import '../models/auth_model.dart';
import '../providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider provider;

  AuthRepository(this.provider);

  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await provider.postLogin(email: email, password: password);

      return AuthModel.fromJson(data);
    } on DioException catch (e) {
      debugPrint("ssLogin error: ${e.response?.data}");
      throw Exception(e.response?.data["message"] ?? "Login gagal");
    }
  }

  Future<UserApiModel> getProfile() async {
    try {
      final data = await provider.getProfile();
      return UserApiModel.fromJson(data);
    } on DioException catch (e) {
      debugPrint("ssLogin error: ${e.response?.data}");
      throw Exception(e.response?.data["message"] ?? "Login gagal");
    }
  }
}
