import 'package:YOURDRS_FlutterAPP/data/model/enums/field_error.dart';

class FormScreenState {
  final bool isBusy;
  final FieldError emailError;
  final FieldError passwordError;
  final bool submissionSuccess;

  FormScreenState({
    this.isBusy: false,
    this.emailError,
    this.passwordError,
    this.submissionSuccess,
  });
}
