import 'package:flu_0/auth/auth_respository.dart';
import 'package:flu_0/auth/form_submission_status.dart';
import 'package:flu_0/auth/login/login_bloc.dart';
import 'package:flu_0/auth/login/login_event.dart';
import 'package:flu_0/auth/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 230, 253, 1),
      body: BlocProvider(
        create: (BuildContext context) =>
            LoginBloc(context.read<AuthRepository>()),
        child: _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameField(),
              _passwordField(),
              _forgotpassword(),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
          validator: (value) {
            print(value);
            print(state.username);
            return state.isValidUsername ? null : 'Username is too short';
          },
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginUsernameChanged(username: value),
              ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 21),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
            validator: (value) =>
                state.isValidPassword ? null : 'Password is too short',
            onChanged: (value) => context.read<LoginBloc>().add(
                  LoginPasswordChanged(password: value),
                ),
          ),
        );
      },
    );
  }

  Widget _forgotpassword() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 21, bottom: 21),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot password?",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: state.formStatus is FormSubmitting
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(129, 51, 241, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 10), // Change padding
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10)), // Change border radius
                  ),
                  child: const Text('Login'),
                ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
