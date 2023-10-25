// ignore_for_file: prefer_const_constructors

import 'package:flu_0/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(239, 230, 253, 1),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isPortrait ? 16.0 : screenWidth * 0.1,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/icon.svg',
                                width: isPortrait ? 60 : 100,
                                height: isPortrait ? 60 : 100,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'No worries, we’ll send you reset instructions.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w200,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                        gapPadding: 4.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size.fromWidth(isPortrait ? 600 : 1200),
                      minimumSize: Size(isPortrait ? 500 : 600, 60),
                      backgroundColor: const Color.fromRGBO(129, 51, 241, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Get Reset Link'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/Vector.svg',
                                width: isPortrait ? 17 : 30,
                                height: isPortrait ? 22 : 40),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(MaterialPageRoute(
                                    builder: (context) => LoginView()));
                              },
                              child: Text(
                                "Back to log in ",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
