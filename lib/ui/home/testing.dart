import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/data/model/userclass.datr.dart';
import 'package:YOURDRS_FlutterAPP/data/service/user_service.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecurityPin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Security_state();
  }
}

class Security_state extends State<SecurityPin> {
  Future<UserAuth> _futureUser;

  bool _passwordvisible;
  final _formKey = GlobalKey<FormState>();

  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordvisible = false;
  }

  /// method to validate the email and password from json data
  void authentication() {
    setState(() {
      var check_email = email_controller.text;
      var check_password = password_controller.text;

      if (check_email == "a@gmail.com" && check_password == "abc#ABC99") {
        print("true");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        print("false");

        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Row(
              children: [
                Text(
                  "Enter your email id and pasword",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: (_futureUser == null)
              ? Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomizedColors.text_field_background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            // validator: validateEmail,
                            controller: email_controller,
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
                            // validator: validatePassword,
                            controller: password_controller,
                            keyboardType: TextInputType.text,
                            obscureText: !_passwordvisible,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, top: 15),
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
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 30, bottom: 30),
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
                              onPressed: authentication,

                              //     () {
                              //   if (_formKey.currentState.validate()) {
                              //     Navigator.of(context).push(
                              //       MaterialPageRoute(
                              //           builder: (context) => SecurityPin()),
                              //     );
                              //   }
                              // },

                              color: CustomizedColors.signInButtonColor,
                              child: Text(
                                AppStrings.sign_in,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: CustomizedColors.sign_in_text_color),
                              )),
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 80),
                        ),
                      ],
                    ),
                  ),
                )

          /// if _futureUser is not null
              : FutureBuilder<UserAuth>(
                  future: fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return Text(
                        snapshot.data.title,
                        style: TextStyle(fontSize: 30),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

// By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
        ),
      ),
    );
  }
}