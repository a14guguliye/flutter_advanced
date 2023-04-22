import 'package:complete_advanced_flutter/app/functions.dart';
import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/domain/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository repository;

  LoginUseCase(this.repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput Input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await repository.login(LoginRequest(
        email: Input.email,
        password: Input.password,
        imei: deviceInfo.identifier,
        deviceType: deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput({required this.email, required this.password});
}
