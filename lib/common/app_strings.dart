import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';

class AppStrings {
  static const welcome = 'Welcome!';
  static const signIn = "Signin";
  static const tryAgain = "tryAgain";
  static const notNow = "notNow";

  /// team 1
  static const your = "Your";
  static const doctors = "Doctors";
  static const welcome_text = 'Welcome!';
  static const your_doctor_text =
      'YourDoctors - Your Practice, Your Patients, Your Peace Of Mind.';
  static const email_text_field_hint = 'Enter your email address ';
  static const password_text_field_hint = 'Password';
  static const sign_in = 'Sign In';
  static const enter_email = 'Please enter your email  ';
  static const wrong_email = 'Enter the correct Email';
  static const enter_password = 'Please enter your password';
  static const wrong_password = 'Enter the correct password';
  static const wrong_password_email = 'Enter the correct Email and Password';
}

class ApiUrlConstants {

  /// getting the user Data
  static const getUser =
      AppConstants.dioBaseUrl + "api/Account/AuthenticateUser";
}
