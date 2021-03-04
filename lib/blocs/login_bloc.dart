import 'dart:async';

import 'package:YOURDRS_FlutterAPP/data/model/user_class.dart';
import 'package:YOURDRS_FlutterAPP/data/service/user_service.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<FormScreenEvent, FormScreenState> {
  ApiServices services;

  LoginBloc(this.services) : super(FormScreenState(isTrue: true));

  @override
  Stream<FormScreenState> mapEventToState(
    FormScreenEvent event,
  ) async* {
    try {
      if (event is FormScreenEvent) {
        AuthenticateUser authenticateUser =
            await services.postApiMethod(event.email, event.password);
        print("My Email is ${event.email}");
        print(authenticateUser);

        /// check if the status value is correct
        if (authenticateUser.header.statusCode == "200") {
          print('Authenticated Successful');
          yield FormScreenState(isTrue: true);

          /// if the status value is not true return as false
        } else if (authenticateUser.header.statusCode == "401") {
          print('Authentication Failed');
          yield FormScreenState(isTrue: false);
        }
      }
    } catch (Exception) {
      print("Exception Error");
    }
  }
}
