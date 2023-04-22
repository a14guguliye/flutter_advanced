import 'dart:async';

import 'package:complete_advanced_flutter/domain/usecase/login_usecase.dart';

import '../base/baseviewmodel.dart';
import '../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  late LoginUseCase _loginUseCase;

  LoginViewModel(LoginUseCase? loginUseCase);

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUsername
  Sink get inputUsername => _userNameStreamController.sink;

  @override
  login() async {
    // (await _loginUseCase.execute(LoginUseCaseInput(
    //         email: loginObject.username, password: loginObject.password)))
    //     .fold(
    //         (failure) => {
    //               //// left -- failure
    //               print(failure.message)
    //             },
    //         (data) => {
    //               ////right --right
    //               print(data.customer?.name)
    //             });
  }

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map((password) {
        return _isPasswordValid(password);
      });

  @override
  Stream<bool> get outputIsUsernameValid =>
      _userNameStreamController.stream.map((username) {
        return _isUsernameValid(username);
      });

  @override
  setPassword({String? password}) {
    // TODO: implement setPassword
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password ?? "");
    inputIsAllInputValid.add(() {});
  }

  @override
  setUserName({String? username}) {
    // TODO: implement setUserName
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username ?? "");
    inputIsAllInputValid.add(() {});
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  @override
  // TODO: implement inputIsAllInputValid
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUsernameValid(loginObject.username);
  }
}

abstract class LoginViewModelInputs {
  ////three functions
  setUserName({String username});

  setPassword({String password});

  login();

  ///two sinks
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
