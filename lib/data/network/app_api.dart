import 'package:complete_advanced_flutter/app/constant.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:retrofit/http.dart';
// ignore: depend_on_referenced_packages
import "package:dio/dio.dart";
part "app_api.g.dart";

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String? baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login({
    @Field("email") required String email,
    @Field("password") required String password,
    @Field("imei") required String imei,
    @Field("deviceType") required String deviceType,
  });

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
      {@Field("country_mobile_code") required String countryMobileCode,
      @Field("name") required String name,
      @Field("email") required String email,
      @Field("password") required String password,
      @Field("mobile_numer") required String mobileNumber,
      @Field("profile_picture") String? profilePicture});
}
