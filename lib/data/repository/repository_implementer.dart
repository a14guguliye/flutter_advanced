import 'package:complete_advanced_flutter/data/data%20source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/domain/model.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/domain/repository.dart';
import 'package:dartz/dartz.dart';

import '../network/network_info.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  RepositoryImpl({required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    // TODO: implement login
    if (await networkInfo.isConnected) {
      /////it is safe to call the API
      final response = await remoteDataSource.login(loginRequest);

      if (response.status == 0) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(
            code: 409.toString(),
            message: response.message ?? "we have business error"));
      }
    }
    ///// return connection error
    ///
    return Left(
        Failure(code: 501.toString(), message: "check ur internet connection"));
  }
}
