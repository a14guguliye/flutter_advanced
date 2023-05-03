// ignore: import_of_legacy_library_into_null_safe
////import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  ///TODO: WORKING ON DATA CONNECTION CHECKER IN FUTURE
  final bool _dataConnectionChecker;
  NetworkInfoImpl(this._dataConnectionChecker);
  @override
  Future<bool> get isConnected => Future.value(true);
}
