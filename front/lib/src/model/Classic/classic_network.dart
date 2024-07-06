import 'package:dio/dio.dart';
import 'package:kyledle/config.dart' as config;
import 'package:kyledle/constants.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: apiBaseUrl,
    connectTimeout: const Duration(seconds: apiTimeout),
    receiveTimeout: const Duration(seconds: apiTimeout),
    headers: {
      config.apiKeyHeader: config.apiKey,
    },
  ),
);

/// If returns null, API call has not worked.
Future<Map<String, dynamic>?> getData(String game) async {
  try {
    final response =
        await dio.get<Map<String, dynamic>>('/data?game=$game&mode=classic');
    return response.data;
  } catch (e) {
    print('Fetch Data Fail: $e');
    return null;
  }
}
