import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioFile {
  static final DioFile _instance = DioFile._internal();
  DioFile._internal();

  static DioFile getInstance() {
    return _instance;
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://millima.flutterwithakmaljon.uz/api",
    ),
  )..interceptors.add(DioInterceptors());

  Dio get dio => _dio;

}

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if(options.uri.toString() != "${options.baseUrl}/login" && options.uri.toString() != "${options.baseUrl}/register"){
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString("token");
      
      options.headers["Authorization"] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
