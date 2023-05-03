import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:dartz/dartz.dart';

import '../network/failure.dart';
import '../request/request.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
}
