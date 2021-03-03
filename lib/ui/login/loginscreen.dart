import 'package:YOURDRS_FlutterAPP/blocs/form_screen_bloc.dart';
import 'package:YOURDRS_FlutterAPP/blocs/states/form_screen_state.dart';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/data/model/enums/field_error.dart';
import 'package:YOURDRS_FlutterAPP/data/model/userclass.datr.dart';
import 'package:YOURDRS_FlutterAPP/data/service/user_service.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

///  Login method using FutureBuilder tried on Tuesday

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  bool _passwordvisible;
  FormScreenBloc _bloc;

  //
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordvisible = false;
    this._bloc = FormScreenBloc();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _bloc = Bloc_Counter();
    return BlocListener<FormScreenBloc, FormScreenState>(
      bloc: this._bloc,
      listener: (context, state) {
        if (state.submissionSuccess) {
          showDialog(
            context: context,
            child: AlertDialog(
                title: Text('Authentication Successful!'),
                content: Image.asset(
                  AppIcons.alert_img,
                ),
                actions: [
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SecurityPin(),
                    )),
                  ),
                ]),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<FormScreenBloc, FormScreenState>(
              bloc: this._bloc,
              builder: (context, state) {
                if (state.isBusy) {
                  return CircularProgressIndicator();
                }

                return ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Container for your doctor text with image
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
                                AppIcons.doctor_img,
                                // I added asset image
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
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.2,
                              maxWidth: MediaQuery.of(context).size.width * 0.9,
                            ),
                            child: Text(
                              AppStrings.your_doctor_text,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      CustomizedColors.your_doctors_text_color),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 25),
                        ),

                        /// Form to validate the user data using RegExp
                        /// This Form contains two TextFormField
                        FutureBuilder<AuthenticateUser>(
                          future: postApiMethod(this._emailController.text,
                              this._passwordController.text),
                          builder: (context, snapshot) {
                            //  if (snapshot.hasData) {
                            //    print(snapshot.data);

                            /// This Form contains two TextFormField
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text(snapshot.data.userName),
                                  /// code for the email validation
                                  Container(
                                    decoration: BoxDecoration(
                                      color: CustomizedColors
                                          .text_field_background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: this._emailController,
                                      style: TextStyle(
                                        color: this._hasEmailError(state)
                                            ? Colors.black
                                            : Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.error,
                                          color: this._hasEmailError(state)
                                              ? Colors.red
                                              : CustomizedColors
                                                  .text_field_background,
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(left: 20, top: 15),
                                        border: InputBorder.none,
                                        hintText:
                                            AppStrings.email_text_field_hint,
                                        labelStyle: TextStyle(
                                          color: this._hasEmailError(state)
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                        hintStyle: TextStyle(
                                          color: this._hasEmailError(state)
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30, top: 60),
                                  ),

                                  /// if statement to check the text field
                                  /// is empty or not and display error message
                                  if (this._hasEmailError(state)) ...[
                                    SizedBox(height: 5),
                                    Text(
                                      this._emailErrorText(state.emailError),
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                  SizedBox(height: 40),

                                  /// code for the password validation
                                  Container(
                                    decoration: BoxDecoration(
                                      color: CustomizedColors
                                          .text_field_background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      controller: this._passwordController,
                                      style: TextStyle(
                                        color: this._hasPasswordError(state)
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                      obscureText: !_passwordvisible,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20, top: 15),
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordvisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordvisible =
                                                  !_passwordvisible;
                                            });
                                          },
                                        ),
                                        hintText:
                                            AppStrings.password_text_field_hint,
                                        labelStyle: TextStyle(
                                          color: this._hasPasswordError(state)
                                              ? Colors.black
                                              : Colors.red,
                                        ),
                                        hintStyle: TextStyle(
                                          color: this._hasPasswordError(state)
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30),
                                  ),

                                  /// if statement to check the text field
                                  /// is empty or not and display error message
                                  if (this._hasPasswordError(state)) ...[
                                    SizedBox(height: 5),
                                    Text(
                                      this._passwordErrorText(
                                          state.passwordError),
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                  SizedBox(height: 30),

                                  /// Implementation for the sign in  Flat button
                                  Container(
                                    decoration: BoxDecoration(
                                      color: CustomizedColors
                                          .text_field_background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () {
                                          postApiMethod(
                                              this._emailController.text,
                                              this._passwordController.text);
                                          if (snapshot.data.header.statusCode ==
                                              "200") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SecurityPin()));
                                          } else {}
                                          // this._bloc.add(
                                          // FormScreenEventSubmit(
                                          //
                                          //     this._emailController.text,
                                          //     this
                                          //         ._passwordController
                                          //         .text));
                                        },
                                        color:
                                            CustomizedColors.signInButtonColor,
                                        child: Text(
                                          AppStrings.sign_in,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: CustomizedColors
                                                  .sign_in_text_color),
                                        )),
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30, top: 40),
                                  ),
                                ],
                              ),
                            );
                            //   }
                            //    else if (snapshot.hasError) {
                            //      return Text("${snapshot.error}");
                            //    }

                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  bool _hasEmailError(FormScreenState state) => state.emailError != null;

  String _emailErrorText(FieldError error) {
    switch (error) {
      case FieldError.Empty:
        return 'You need to enter an email address';
      case FieldError.Invalid:
        return 'Email address invalid';
      default:
        return '';
    }
  }

  bool _hasPasswordError(FormScreenState state) => state.passwordError != null;

  String _passwordErrorText(FieldError error) {
    switch (error) {
      case FieldError.Empty:
        return 'You need to enter an password';
      case FieldError.Invalid:
        return 'your password is invalid';
      default:
        return '';
    }
  }
}
