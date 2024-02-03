import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utils/custom_clippers.dart';
import '../utils/styles.dart';
import '../widgets/custom_button.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                clipper: RegisterClipper(),
                child: Container(
                  color: DesignColors().tertiaryColor,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.065),
                    Text('FINDY', style: TextStyles.lpTitle(height)),
                    SizedBox(height: height * 0.06),
                    Expanded(
                      child: IconButton(
                        padding: EdgeInsets.only(right: width * 0.9),
                        onPressed: () => {
                          context.pop(),
                        },
                        icon: Icon(
                          Icons.arrow_circle_left,
                          size: width * 0.15,
                          color: DesignColors().mainColor,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.12),
                    RichText(
                      text: TextSpan(
                        text: "Sign up with ",
                        style: TextStyles.rpRegisterText(height),
                        children: [
                          TextSpan(
                              text: 'EMAIL', style: TextStyles.rpEmailText(height)),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.16),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 0.15 * width, right: 0.15 * width),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Enter email',
                              labelStyle:
                              TextStyle(color: DesignColors().mainColor),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(height * 0.0225),
                                borderSide: BorderSide(
                                    color: DesignColors().mainColor, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(height * 0.0225)),
                                borderSide: BorderSide(
                                    color: DesignColors().mainColor, width: 3.0),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.070),
                    LandingPageButton(
                      width: width,
                      height: height,
                      text: 'Sign up',
                      onPressed: () {
                        // logic logic
                      },
                    ),
                    SizedBox(height: height * 0.070),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
