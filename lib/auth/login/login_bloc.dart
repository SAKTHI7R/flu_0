// ignore_for_file: override_on_non_overriding_member

import 'package:flu_0/auth/auth_respository.dart';
import 'package:flu_0/auth/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flu_0/auth/login/login_event.dart';
import 'package:flu_0/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc(this.authRepo) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
    }

    try {
      await authRepo.login();
      yield state.copyWith(formStatus: SubmissionSuccess());
    } catch (e) {
      yield state.copyWith(formStatus: SubmissionFailed(e as Exception));
    }
  }
}
