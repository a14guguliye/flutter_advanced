import 'dart:async';

import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewmodelOutput, ForgotPasswordViewModelInput {
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _isAllInputValid =
      StreamController<bool>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValid.close();
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    var res = await _forgotPasswordUseCase.execute(email);

    if (res is Failure) {
      var res1 = res as Failure;
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: res1.message));
    } else if (res is String) {
      inputState.add(ContentState());
    }
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValid.sink;

  @override
  // TODO: implement outputIsAllInputValid
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValid.stream.map((isAllInputValid) => _isAllInputValidF());

  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  bool _isEmailValid(String email) {
    return email.contains("@");
  }

  bool _isAllInputValidF() {
    return _isEmailValid(email);
  }

  @override
  setEmail(String email) {
    email = email;
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class ForgotPasswordViewModelInput {
  forgotPassword();
  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewmodelOutput {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputValid;
}
