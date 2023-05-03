import 'package:complete_advanced_flutter/data/network/error_handler.dart';

class Failure {
  String code;
  String message;

  Failure({required this.code, required this.message});
}

class DefaultFailure extends Failure {
  DefaultFailure()
      : super(
            code: ResponseCode.UNKNOWN.toString(),
            message: ResponseMessage.UNKNOWN);
}
