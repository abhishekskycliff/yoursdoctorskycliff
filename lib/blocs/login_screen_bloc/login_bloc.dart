import 'dart:async';

import 'package:YOURDRS_FlutterAPP/data/model/login_model_class.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/preference/local_storage.dart';
import 'package:YOURDRS_FlutterAPP/data/service/login_api_service.dart';
import 'package:bloc/bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<FormScreenEvent, FormScreenState> {
  ApiServices services;

  LoginBloc(this.services) : super(FormScreenState(isTrue: true));
  bool isPinAvailable;

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
          var MemberId = authenticateUser.memberRole[0].memberId.toString();
          // var profilePhoto = authenticateUser.profilePhoto;
          print('Authenticated Successful');
          print('Member Id is....$MemberId');
          // print('profile Photo////// $profilePhoto');
          var result = await MySharedPreferences.instance
              .setStringValue(Keys.memberId, MemberId);
          print('memberID result $result');

          /// check if memberPin is present or not
          if (authenticateUser.memberPin == "") {
            yield FormScreenState(
                isTrue: true,
                memberId: MemberId,
                isPinAvailable: isPinAvailable = false);
          } else {
            yield FormScreenState(
                isTrue: true,
                memberId: MemberId,
                isPinAvailable: isPinAvailable = true);
          }

          yield FormScreenState(isTrue: true, memberId: MemberId);

          /// if the status value is not true return as false
        } else {
          print('Authentication Failed');
          yield FormScreenState(isTrue: false);
        }
      }
    } catch (Exception) {
      print("Exception Error");
    }
  }
}
