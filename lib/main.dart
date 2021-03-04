import 'dart:developer';

import 'package:YOURDRS_FlutterAPP/blocs/login_bloc.dart';
import 'package:YOURDRS_FlutterAPP/data/service/user_service.dart';
import 'package:YOURDRS_FlutterAPP/ui/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(ApiServices()),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: LoginScreen(),
      ),
    );
  }
}
