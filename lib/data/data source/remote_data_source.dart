import 'package:complete_advanced_flutter/data/network/app_api.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:retrofit/http.dart';

import '../request/request.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return _appServiceClient.login(
        email: loginRequest.email,
        password: loginRequest.password,
        imei: loginRequest.imei,
        deviceType: loginRequest.deviceType);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        countryMobileCode: registerRequest.countryMobileCode,
        name: registerRequest.name,
        email: registerRequest.email,
        password: registerRequest.password,
        mobileNumber: registerRequest.mobileNumber,
        profilePicture: registerRequest.profilePicture);
  }
}
