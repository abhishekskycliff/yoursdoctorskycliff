import 'package:YOURDRS_FlutterAPP/ui/home/Home.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/loginscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}
