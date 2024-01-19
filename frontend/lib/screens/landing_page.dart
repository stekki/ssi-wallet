import 'package:flutter/material.dart';
import '../utils/custom_clippers.dart';
import '../utils/styles.dart';
import '../widgets/custom_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0XFFE6EDFF),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: Container(
                    color:
                        const Color.fromARGB(1, 182, 218, 255).withOpacity(0.5),
                  ),
                )
              ],
            ),
            ClipPath(
              clipper: FirstClipper(),
              child: Container(
                color: const Color.fromARGB(1, 182, 218, 255).withOpacity(0.5),
              ),
            ),
            ClipPath(
              clipper: SecondClipper(),
              child: Container(
                color: const Color(0XFFE6EDFF),
              ),
            ),
            ClipPath(
              clipper: ThirdClipper(),
              child: Container(
                color: const Color(0XFFE6EDFF),
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
                  SizedBox(height: height * 0.25),
                  LandingPageButton(
                    text: 'Login',
                    onPressed: () {
                      //login logic
                    },
                  ),
                  SizedBox(height: height * 0.065),
                  LandingPageButton(
                    text: 'Register',
                    onPressed: () {
                      //register logic
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
