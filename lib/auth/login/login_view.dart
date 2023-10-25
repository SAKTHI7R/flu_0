import 'package:flu_0/auth/auth_respository.dart';
import 'package:flu_0/auth/form_submission_status.dart';
import 'package:flu_0/auth/login/forgot_password_page.dart';
import 'package:flu_0/auth/login/login_bloc.dart';
import 'package:flu_0/auth/login/login_event.dart';
import 'package:flu_0/auth/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // ignore: use_key_in_widget_constructors
  LoginView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 230, 253, 1),
      //   resizeToAvoidBottomInset: true,
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          final isMediumScreen =
              constraints.maxWidth >= 600 && constraints.maxWidth < 1200;

          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : (isMediumScreen ? 24 : 40),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _logo(fontSize: isSmallScreen ? 16 : 25),
                  _usernameField(fontSize: isSmallScreen ? 16 : 20),
                  _passwordField(fontSize: isSmallScreen ? 16 : 20),
                  _forgotpassword(fontSize: isSmallScreen ? 12 : 16),
                  _loginButton(
                    width: isSmallScreen ? 600 : (isMediumScreen ? 750 : 650),
                    height: isSmallScreen ? 60 : 70,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _logo({fontSize = 17}) {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.only(bottom: 89),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Logo_edmn.svg',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Open Seasame!!!',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'The Stage is Set, Login and Steal the Spotlight',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _usernameField({double fontSize = 20}) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(fontSize: fontSize),
          decoration: InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
              gapPadding: 5.0,
            ),
          ),
          validator: (value) {
            return state.isValidUsername ? null : 'Username is too short';
          },
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginUsernameChanged(username: value),
              ),
        );
      },
    );
  }

  Widget _passwordField({double fontSize = 20}) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(top: 21),
          child: TextFormField(
            style: TextStyle(fontSize: fontSize),
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
                gapPadding: 5.0,
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

  Widget _forgotpassword({double fontSize = 16}) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return SizedBox(
        child: Container(
          padding: const EdgeInsets.only(top: 21, bottom: 21),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage()));
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _loginButton({double width = 200, double height = 50}) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: Size.fromWidth(width),
                  minimumSize: Size(width, height),
                  backgroundColor: const Color.fromRGBO(129, 51, 241, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Login'),
              );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
