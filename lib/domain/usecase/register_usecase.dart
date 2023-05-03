import 'package:complete_advanced_flutter/app/functions.dart';
import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/data/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository repository;

  RegisterUseCase(this.repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput Input) async {
    return await repository.register(RegisterRequest(
        countryMobileCode: Input.countryMobileCode,
        name: Input.name,
        email: Input.email,
        password: Input.password,
        mobileNumber: Input.mobileNumber,
        profilePicture: Input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String name;
  String email;
  String password;
  String mobileNumber;
  String? profilePicture;

  RegisterUseCaseInput({
    required this.countryMobileCode,
    required this.name,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.profilePicture,
  });
}
