import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  Future<AuthModel> refreshToken(String refreshToken) async {
    try {
      final data = await provider.postRefresh(refreshToken);
      return AuthModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.response?.data?["message"] ?? "Refresh token gagal");
    }
  }
}
