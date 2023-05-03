class LoginRequest {
  String email;
  String password;

  String imei;
  String deviceType;

  LoginRequest(
      {required this.email,
      required this.password,
      required this.imei,
      required this.deviceType});
}

class RegisterRequest {
  String countryMobileCode;
  String name;
  String email;
  String password;
  String mobileNumber;
  String? profilePicture;

  RegisterRequest({
    required this.countryMobileCode,
    required this.name,
    required this.email,
    required this.password,
    required this.mobileNumber,
    this.profilePicture,
  });
}
