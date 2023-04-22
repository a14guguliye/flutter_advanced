import 'package:complete_advanced_flutter/data/data%20source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/data/network/error_handler.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
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
      try {
        /////it is safe to call the API
        final response = await remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
              code: response.status.toString(),
              message: response.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    ///// return connection error
    ///
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
