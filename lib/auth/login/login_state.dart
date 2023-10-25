// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'package:flu_0/auth/form_submission_status.dart';

class LoginState {
  final String username;
  final String usernameError;
  bool get isValidUsername => username.length > 3;
  final String password;
  final String passwordError;
  bool get isValidPassword => password.length > 6;
  final FormSubmissionStatus formStatus;
  //final User? user; // User object for successful login

  LoginState({
    this.username = '',
    this.usernameError = '',
    this.password = '',
    this.passwordError = '',
    this.formStatus = const InitialFormStatus(),
    //this.user,
  });

  LoginState copyWith({
    String? username,
    String? password,
    String? usernameError,
    String? passwordError,
    FormSubmissionStatus? formStatus,
    //User? user,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameError: usernameError ?? this.usernameError,
      passwordError: passwordError ?? this.passwordError,
      formStatus: formStatus ?? this.formStatus,
      //user: user ?? this.user,
    );
  }
}

class User {
  final String username;
  final String email;

  User({
    required this.username,
    required this.email,
  });
}

class ForgotPasswordState extends LoginState {
  ForgotPasswordState();
}
