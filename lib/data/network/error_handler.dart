import 'failure.dart';
import "package:dio/dio.dart";

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();

      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.connectionError:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.unknown:
        return DataSource.DEFAULT.getFailure();

      default:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();

          case ResponseCode.UNAUTHORISED:
            return DataSource.UNAUTHORISED.getFailure();

          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();

          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();

          default:
            return DataSource.DEFAULT.getFailure();
        }
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(
            code: ResponseCode.BAD_REQUEST.toString(),
            message: ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(
            code: ResponseCode.FORBIDDEN.toString(),
            message: ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(
            code: ResponseCode.UNAUTHORISED.toString(),
            message: ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(
            code: ResponseCode.NOT_FOUND.toString(),
            message: ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            code: ResponseCode.INTERNAL_SERVER_ERROR.toString(),
            message: ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            code: ResponseCode.CONNECT_TIMEOUT.toString(),
            message: ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(
            code: ResponseCode.CANCEL.toString(),
            message: ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            code: ResponseCode.RECEIVE_TIMEOUT.toString(),
            message: ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(
            code: ResponseCode.SEND_TIMEOUT.toString(),
            message: ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(
            code: ResponseCode.CACHE_ERROR.toString(),
            message: ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
            code: ResponseCode.NO_INTERNET_CONNECTION.toString(),
            message: ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(
            code: ResponseCode.UNKNOWN.toString(),
            message: ResponseMessage.UNKNOWN);
      default:
        return Failure(
            code: ResponseCode.UNKNOWN.toString(),
            message: ResponseMessage.UNKNOWN);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORISED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
/////////API status code

////local status code
  static const int UNKNOWN = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  static const String SUCCESS = "success";
  static const String NO_CONTENT = "success with no content";
  static const String BAD_REQUEST = "bad request, try again later";
  static const String FORBIDDEN = "forbidden request, try again later";
  static const String UNAUTHORISED = "user is unauthorized, try again later";
  static const String NOT_FOUND = "url not found, try again later";
  static const String INTERNAL_SERVER_ERROR =
      "something went wrong, try again later";
/////////API status code

////local status code
  static const String UNKNOWN = "something went wrong, try again later";
  static const String CONNECT_TIMEOUT = "time out error, try again later";
  static const String CANCEL = "request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "time out error, try again later";
  static const String SEND_TIMEOUT = "time out error, try again later";
  static const String CACHE_ERROR = "cache error, try again later";
  static const String NO_INTERNET_CONNECTION =
      "no connection error, try again later";
}
