import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';
import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  bool _passwordvisible;
  final _formKey = GlobalKey<FormState>();

  @override
  // ignore: must_call_super
  void initState() {
    _passwordvisible = false;
  }

  /// method to validate the email
  String validateEmail(String value) {
    Pattern pattern = AppConstants.emailPattern;
    RegExp regex = new RegExp(pattern);
    print(value);

    try {
      if (value.isEmpty) {
        return AppStrings.enter_email;
      } else {
        if (!regex.hasMatch(value))
          return AppStrings.wrong_password;
        else {
          return null;
        }
      }
    } catch (Exception) {
      print(Exception);
    }
  }

  /// method to validate the password
  String validatePassword(String value) {
    Pattern pattern = AppConstants.password_pattern;
    RegExp regex = new RegExp(pattern);
    print(value);

    try {
      if (value.isEmpty) {
        return AppStrings.enter_password;
      } else {
        if (!regex.hasMatch(value))
          return AppStrings.wrong_password;
        else {
          return null;
        }
      }
    } catch (Exception) {
      print(Exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ListView to add multiple components
      body: ListView(
        children: [
          Column(
            // which add column properties at the center
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Container for the main your doctor text with image
              Container(
                child: Row(
                  // which add Row properties at the center
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.your,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: CustomizedColors.your_text_color),
                    ),
                    Text(
                      AppStrings.doctors,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: CustomizedColors.doctor_text_color),
                    ),
                    Image.asset(
                      AppIcons.doctor_img, // I added asset image
                      height: 60,
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(bottom: 80),
              ),

              /// Container for welcome screen
              Container(
                child: Text(
                  AppStrings.welcome_text,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 35),
                ),
                margin: EdgeInsets.only(bottom: 20),
              ),

              /// Container for your_doctors text
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.2,
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  child: Text(
                    AppStrings.your_doctor_text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: CustomizedColors.your_doctors_text_color),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 80),
              ),

              /// Form to validate the user data using RegExp
              /// This Form contains two TextFormField
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustomizedColors.text_field_background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        validator: validateEmail,
                        //    controller: controller_email,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          border: InputBorder.none,
                          hintText: AppStrings.email_text_field_hint,
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 30, right: 30),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomizedColors.text_field_background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        validator: validatePassword,
                        //   controller: controller_password,
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordvisible,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, top: 15),
                          border: InputBorder.none,
                          hintText: AppStrings.password_text_field_hint,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordvisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordvisible = !_passwordvisible;
                              });
                            },
                          ),
                        ),
                      ),
                      margin:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                    ),
                  ],
                ),
              ),

              /// Implementation for the sign in  Flat button
              Container(
                decoration: BoxDecoration(
                  color: CustomizedColors.text_field_background,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SecurityPin()),
                        );
                      }
                    },
                    color: CustomizedColors.signInButtonColor,
                    child: Text(
                      AppStrings.sign_in,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: CustomizedColors.sign_in_text_color),
                    )),
                margin: const EdgeInsets.only(left: 30, right: 30, top: 80),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
