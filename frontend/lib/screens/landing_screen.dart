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
              // First layer is
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
                    Text('FINDY', style: TextStyles.lpTitle(height)),
                    SizedBox(height: height * 0.15),
                    Text('Welcome to the Findy Wallet',
                        style: TextStyles.lpWelcome(height)),
                    SizedBox(height: height * 0.03875),
                    Text('Login to the service to continue',
                        style: TextStyles.lpText(height)),
                    SizedBox(height: height * 0.20),
                    LandingPageButton(
                      width: width,
                      height: height,
                      text: 'Login',
                      onPressed: () {
                        //login logic
                      },
                    ),

                    // TODO: Remove this button before production
                    // ElevatedButton(
                    //     onPressed: () => context.go('/home'),
                    //     style: ElevatedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.horizontal(
                    //         left: Radius.circular(height * 0.06),
                    //         right: Radius.circular(height * 0.06),
                    //       )),
                    //       backgroundColor: const Color.fromARGB(255, 226, 2, 2),
                    //     ),
                    //     child: const Text('Skip login for devs')),
                    // SizedBox(height: height * 0.120),
                    // Remove this button before production

                    RichText(
                      text: TextSpan(
                        text: "Don't have an account yet? ",
                        style: TextStyles.lpRegisterText(height),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/register');
                                },
                              text: 'Sign up',
                              style: TextStyles.lpSignUpText(height)),
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
