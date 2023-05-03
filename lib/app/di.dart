import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/data/data%20source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/network/app_api.dart';
import 'package:complete_advanced_flutter/data/network/dio_factory.dart';
import 'package:complete_advanced_flutter/data/network/network_info.dart';
import 'package:complete_advanced_flutter/data/repository/repository_implementer.dart';
import 'package:complete_advanced_flutter/data/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:complete_advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
// ignore: import_of_legacy_library_into_null_safe
////import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  instance.registerLazySingleton(() => sharedPreferences);

  instance.registerLazySingleton(
      () => AppPreferences(sharedPreferences: instance<SharedPreferences>()));

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(true));

  instance.registerLazySingleton(() => DioFactory(appPreferences: instance()));

  final dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(networkInfo: instance(), remoteDataSource: instance()));
}

initLoginModule() {
  instance.registerFactory(() => LoginUseCase(instance()));

  instance.registerFactory(() => LoginViewModel(instance()));
}

initForgotPasswordViewModule() {
  instance.registerFactory(() => ForgotPasswordUseCase(instance()));
  instance.registerFactory(() => ForgotPasswordViewModel(instance()));
}
