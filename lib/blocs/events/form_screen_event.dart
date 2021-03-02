abstract class FormScreenEvent {}

class FormScreenEventSubmit extends FormScreenEvent {
  final String email;
  final String password;

  FormScreenEventSubmit(this.email, this.password);
}
