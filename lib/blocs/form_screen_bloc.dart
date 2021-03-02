import 'package:YOURDRS_FlutterAPP/blocs/states/form_screen_state.dart';
import 'package:YOURDRS_FlutterAPP/data/model/enums/field_error.dart';
import 'package:YOURDRS_FlutterAPP/mixins/validation_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/form_screen_event.dart';

class FormScreenBloc extends Bloc<FormScreenEvent, FormScreenState>
    with ValidationMixin {
  FormScreenBloc();

  @override
  FormScreenState get initialState => FormScreenState();

  @override
  Stream<FormScreenState> mapEventToState(FormScreenEvent event) async* {
    if (event is FormScreenEventSubmit) {
      yield FormScreenState(isBusy: true);

      if (this.isFieldEmpty(event.email)) {
        yield FormScreenState(emailError: FieldError.Empty);
        return;
      }



     else if (!this.validateEmailAddress(event.email)) {
        yield FormScreenState(emailError: FieldError.Invalid);
        return;
      }


     else if (this.isFieldEmpty(event.password)) {
        yield FormScreenState(passwordError: FieldError.Empty);
        return;
      }


      else if(!this.validatePassword(event.password)) {
        yield FormScreenState(passwordError: FieldError.Invalid);
        return;
      }
      else{}

      yield FormScreenState(submissionSuccess: true);
    }
  }



}
