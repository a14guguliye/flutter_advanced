import "package:complete_advanced_flutter/app/app_pref.dart";
import "package:complete_advanced_flutter/app/constant.dart";
import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:pretty_dio_logger/pretty_dio_logger.dart";

const String APPLICATION_JSON = "application/json";

const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";
const String textPlain = "text/plain";

class DioFactory {
  AppPreferences appPreferences;

  DioFactory({required this.appPreferences});

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeout = 60;

    String? language = await appPreferences.getAppLanguage();

    Map<String, String> headers = {
      CONTENT_TYPE: textPlain,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: language
    };

    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: Duration(seconds: timeout),
        receiveTimeout: Duration(seconds: timeout),
        headers: headers);

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
