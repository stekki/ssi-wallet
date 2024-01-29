import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/custom_clippers.dart';
import '../utils/styles.dart';
import '../widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0XFFE6EDFF),
        body: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Container(
                      color: DesignColors().secondaryColor,
                    ),
                  )
                ],
              ),
              ClipPath(
                clipper: FirstClipper(),
                child: Container(
                  color: DesignColors().secondaryColor,
                ),
              ),
              ClipPath(
                clipper: SecondClipper(),
                child: Container(
                  color: DesignColors().tertiaryColor,
                ),
              ),
              ClipPath(
                clipper: ThirdClipper(),
                child: Container(
                  color: DesignColors().tertiaryColor,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.065),
                    const Text('FINDY', style: TextStyles.lpTitle),
                    SizedBox(height: height * 0.15),
                    const Text('Welcome to the Findy Wallet',
                        style: TextStyles.lpWelcome),
                    SizedBox(height: height * 0.03875),
                    const Text('Login to the service to continue',
                        style: TextStyles.lpText),
                    SizedBox(height: height * 0.20),
                    LandingPageButton(
                      text: 'Login',
                      onPressed: () {
                        //login logic
                      },
                    ),
                    SizedBox(height: height * 0.220),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account yet? ",
                        style: TextStyles.lpRegisterText,
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed('register');
                                },
                              text: 'Sign up',
                              style: TextStyles.lpSignUpText),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
