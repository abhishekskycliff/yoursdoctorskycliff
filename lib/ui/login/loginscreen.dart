import 'package:YOURDRS_FlutterAPP/blocs/login_screen_bloc/login_bloc.dart';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_icons.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/ui/home/Home.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin/create_security_pin.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/security_pin/verify_security_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  /// Declaring global variables
  final _formKey = GlobalKey<FormState>();
  var memberID;
  bool _passwordvisible;
  bool visible = false;

  /// Text editing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Shared Preference
  SharedPreferences logindata;
  SharedPreferences MemberIdData;
  bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
    _passwordvisible = false;
    super.initState();
  }

  /// To check the present data if user already login or not
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => VerifyPinScreen()));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, FormScreenState>(
      listener: (context, state) {
        /// if the status code is true it execute the statement else go to next statement
        if (state.isTrue == true) {
          if (state.isPinAvailable==true) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatePinScreen(
                          data: state.memberId,
                        )));
          }
        } else {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Row(
                children: [
                  Text(AppStrings.wrong_password_email,
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ],
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _text(),
                  _welcome_text(),
                  _yourdoctor(),
                  _textfieldform(),
                  _signinbutton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Container for your doctor text with image
  Widget _text() {
    return Container(
      child: Row(
        // which add Row Widget at the center
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
            AppImages.doctor_img,
            // I added asset image
            height: 60,
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 80),
    );
  }

  /// Container for welcome screen Text
  Widget _welcome_text() {
    return Container(
      child: Text(
        AppStrings.welcome_text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
      ),
      margin: EdgeInsets.only(bottom: 20),
    );
  }

  /// Container for your_doctors quote text
  Widget _yourdoctor() {
    return Container(
      // ConstrainedBox to display the text within it to make responsive
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.2,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Text(
          AppStrings.your_doctor_text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: CustomizedColors.your_doctors_text_color),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 25),
    );
  }

  /// Two TextField validate the user and navigate to next screen
  Widget _textfieldform() {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomizedColors.text_field_background,
                borderRadius: BorderRadius.circular(10),
              ),

              /// TextFormField for Email
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return AppStrings.enter_email;
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  border: InputBorder.none,
                  hintText: AppStrings.email_text_field_hint,
                ),
              ),
              margin: const EdgeInsets.only(left: 30, right: 30, top: 60),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: CustomizedColors.text_field_background,
                borderRadius: BorderRadius.circular(10),
              ),

              /// TextFormField for Email
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return AppStrings.enter_password;
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: !_passwordvisible,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, top: 15),
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
                        _passwordvisible = !_passwordvisible;
                      });
                    },
                  ),
                  hintText: AppStrings.password_text_field_hint,
                ),
              ),
              margin: const EdgeInsets.only(left: 30, right: 30),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Implementation for the sign in button (Flat button)
  Widget _signinbutton() {
    return Container(
      decoration: BoxDecoration(
        color: CustomizedColors.text_field_background,
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print('Successfull');
              setState(() {
                visible = true;
              });

              logindata.setBool('login', false);
              logindata.setString('username', emailController.text);
              print("This is Email ${emailController.text}");
              BlocProvider.of<LoginBloc>(context).add(FormScreenEvent(
                  emailController.text, passwordController.text));
            }
          },
          color: CustomizedColors.signInButtonColor,
          child: Text(
            AppStrings.sign_in,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: CustomizedColors.sign_in_text_color),
          )),
      margin: const EdgeInsets.only(left: 30, right: 30, top: 40),
    );
  }
}
