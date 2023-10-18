// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'package:flu_0/auth/form_submission_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername => username.length > 3;
  final String password;
  bool get isValidPassword => password.length > 6;
  final FormSubmissionStatus formStatus;

  LoginState(
      {this.username = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()})
      : assert(username != null && password != null && formStatus != null);

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
