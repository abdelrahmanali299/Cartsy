import 'package:dio/dio.dart';
import 'package:fake_store/core/api/api_consumer.dart';
import 'package:fake_store/core/api/api_interceptor.dart';
import 'package:fake_store/core/api/end_points.dart';
import 'package:fake_store/core/functions/handle_dio_exception.dart';

class DioConsumer implements ApiConsumer {
  static late Dio dio;
  @override
  DioConsumer();
  static dioInit() {
    dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
    dio.interceptors.add(ApiInterceptor());
  }

  Future delete(String path) async {
    try {
      await dio.delete(path);
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final res = await dio.get(path, queryParameters: queryParameters);
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future post(String path, {Map<String, dynamic>? body}) async {
    try {
      var res = await dio.post(path, data: body);
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future put(String path, {Map<String, dynamic>? body}) async {
    try {
      await dio.put(path, data: body);
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
