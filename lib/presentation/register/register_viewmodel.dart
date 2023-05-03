import 'dart:async';
import 'dart:io';

import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/freezed_data_classes.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController<String> _usernameStreamController =
      StreamController.broadcast();
  final StreamController<String> _emailStreamController =
      StreamController.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController.broadcast();
  final StreamController<String> _mobileStreamController =
      StreamController.broadcast();
  final StreamController<File> _profileStreamController =
      StreamController.broadcast();

  final StreamController<bool> _isAllInputValid = StreamController.broadcast();

  var registerObject = RegisterObject("", "", "", "", "", "");

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _usernameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _mobileStreamController.close();
    _profileStreamController.close();
    _isAllInputValid.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileStreamController.sink;

  @override
  Sink get inputProfilePicture => _profileStreamController.sink;

  @override
  Sink get inputUPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _usernameStreamController.sink;

  @override
  Stream<String?> get outptErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobilenumberValid) {
        if (isMobilenumberValid) {
          return null;
        }
        return "Invalid Mobile Number";
      });

  @override
  Stream<String?> get outputErrorEmail =>
      outputIsEmailValid.map((isEmailValid) {
        if (isEmailValid) {
          return null;
        }
        return "Invalid Email";
      });

  @override
  Stream<String?> get outputErrorPassword =>
      outputIsPasswordValid.map((isPasswordValid) {
        if (isPasswordValid) {
          return null;
        }
        return "Invalid Password";
      });

  @override
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map((isUsernameValid) {
        if (isUsernameValid) {
          return null;
        } else {
          return "Invalid Username";
        }
      });

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map(_isEmailValid);

  bool _isEmailValid(email) {
    if (email.length > 4) {
      return true;
    }
    return false;
  }

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileStreamController.stream.map(_isMobileNumberValid);

  bool _isMobileNumberValid(mobileNumber) {
    if (mobileNumber.length > 4) {
      return true;
    }
    return false;
  }

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map(_isPasswordValid);

  bool _isPasswordValid(password) {
    if (password.length > 4) {
      return true;
    }
    return false;
  }

  @override
  Stream<bool> get outputIsProfileValid =>
      _profileStreamController.stream.map((file) => true);
  @override
  Stream<bool> get outputIsUserNameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  bool _isUsernameValid(String username) {
    return username.length >= 4;
  }

  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  setCountryCode(String countryCode) {
    registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    _validate();
  }

  @override
  setEmail(String email) {
    if (_isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    }
    registerObject = registerObject.copyWith(email: "");
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    if (_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    }
    registerObject = registerObject.copyWith(mobileNumber: EMPTY);
    _validate();
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    registerObject = registerObject.copyWith(profilePicture: file.path);
    _validate();
  }

  @override
  setUsername(String userName) {
    if (_isUsernameValid(userName)) {
      registerObject = registerObject.copyWith(name: userName);
    } else {
      registerObject = registerObject.copyWith(name: EMPTY);
    }
    _validate();
  }

  @override
  Sink get isAllInputValid => _isAllInputValid.sink;

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValid.stream.map((event) {
        return _validateAllInputs();
      });

  bool _validateAllInputs() {
    return registerObject.profilePicture?.isNotEmpty ??
        true &&
            _isEmailValid(registerObject.email) &&
            _isPasswordValid(registerObject.password) &&
            _isMobileNumberValid(registerObject.mobileNumber) &&
            _isUsernameValid(registerObject.name);
  }

  _validate() {
    isAllInputValid.add(_validateAllInputs());
  }
}

abstract class RegisterViewModelInput {
  register();

  setUsername(String userName);

  setMobileNumber(String mobileNumber);

  setCountryCode(String countryCode);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File file);

  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputUPassword;
  Sink get inputProfilePicture;

  Sink get isAllInputValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outptErrorMobileNumber;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;
  Stream<bool> get outputIsProfileValid;
  Stream<bool> get outputIsAllInputValid;
}
