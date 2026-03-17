import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:tamplate_getx/services/token_local_service.dart';

class DioService extends GetxService {
  late final Dio dio;

  final TokenLocalService tokenLocalService;

  bool _isRefreshing = false;
  final List<Completer<void>> _queue = [];

  DioService(this.tokenLocalService) {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    _initInterceptor();
  }

  void _initInterceptor() {
    /// 🔥 2️⃣ AUTH + AUTO REFRESH
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenLocalService.getToken();
          if (token?.accessToken != null) {
            options.headers["Authorization"] = "Bearer ${token?.accessToken}";
          }
          handler.next(options);
        },

        onError: (error, handler) async {
          /// Kalau bukan 401 → langsung lanjut
          if (error.response?.statusCode != 401) {
            return handler.next(error);
          }

          final token = await tokenLocalService.getToken();

          /// Kalau tidak ada refresh token → logout
          if (token?.refreshToken == null) {
            await _logout();
            return handler.next(error);
          }

          /// Kalau sedang refresh → tunggu
          if (_isRefreshing) {
            final completer = Completer<void>();
            _queue.add(completer);
            await completer.future;

            final newToken = await tokenLocalService.getToken();

            error.requestOptions.headers["Authorization"] =
                "Bearer ${newToken?.accessToken}";

            final retryResponse = await dio.fetch(error.requestOptions);

            return handler.resolve(retryResponse);
          }

          _isRefreshing = true;

          try {
            /// 🔥 Pakai Dio baru supaya tidak infinite loop
            final refreshDio = Dio(BaseOptions(baseUrl: dio.options.baseUrl));

            final response = await refreshDio.post(
              "/auth/refresh",
              data: {"refreshToken": token?.refreshToken, "expiresInMins": 1},
            );

            final newAccess = response.data["accessToken"];
            final newRefresh = response.data["refreshToken"];

            /// Simpan token baru
            await tokenLocalService.saveToken(newAccess, newRefresh);

            /// Release semua request yang ngantri
            for (var completer in _queue) {
              completer.complete();
            }
            _queue.clear();

            /// Retry request awal
            error.requestOptions.headers["Authorization"] = "Bearer $newAccess";

            final retryResponse = await dio.fetch(error.requestOptions);

            return handler.resolve(retryResponse);
          } catch (e) {
            await _logout();
            return handler.next(error);
          } finally {
            _isRefreshing = false;
          }
        },
      ),
    );
  }

  Future<void> _logout() async {
    await tokenLocalService.clearToken();
    Get.offAllNamed('/login');
  }
}
