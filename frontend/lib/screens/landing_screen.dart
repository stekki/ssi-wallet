// ignore_for_file: use_build_context_synchronously, unused_local_variable, unused_catch_clause
import 'dart:io' show Platform;
import 'dart:math';

import 'package:authn/authn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/config/graphql_config.dart';
import 'package:go_router/go_router.dart';

import '../utils/secure_storage.dart';
import '../utils/helpers.dart' as helpers;
import '../utils/styles.dart';
import '../widgets/landing_page_button.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  Future<void> login(BuildContext context) async {
    if (Platform.isLinux) {
      _showLoadingDialog(context);
      try {
        String jwt =
            await authnCmd("login", emailController.text, pinController.text);
        SecureStorageUtil().writeToken(jwt);
        GraphQLConfig().createClient();
        context.go('/home');
      } on Exception catch (e) {
        helpers.showErrorSnackBar(context,
            "An unexpected error occurred. User not found or incorrect password");
      } finally {
        Navigator.of(context).pop();
      }
    } else {
      helpers.showErrorSnackBar(
          context, "Action not supported for this Platform");
    }
  }

  Future<void> register(BuildContext context) async {
    if (Platform.isLinux) {
      _showLoadingDialog(context);
      try {
        final jwt = await authnCmd(
            "register", emailController.text, pinController.text);
        helpers.showInfoSnackBar(context, "Registration successful");
      } catch (e) {
        helpers.showErrorSnackBar(context, e.toString());
      } finally {
        Navigator.of(context).pop();
      }
    } else {
      helpers.showErrorSnackBar(
          context, "Action not supported for this Platform");
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 24),
              Text("Please wait..."),
            ],
          ),
        );
      },
    );
  }

  Future<void> devSignIn(BuildContext context) async {
    TextEditingController tokenController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            controller: tokenController,
            decoration: const InputDecoration(hintText: 'Enter JWT Token'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Sign In'),
              onPressed: () {
                SecureStorageUtil().writeToken(tokenController.text);
                GraphQLConfig().createClient();
                Navigator.of(context).pop();
                context.go('/home');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: Column(
          children: [
            Container(
              height: height * 0.3,
              width: width,
              decoration: scaffoldBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.22,
                    height: height * 0.12,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        alignment: FractionalOffset.center,
                        image: AssetImage('assets/logos/findywallet_white.png'),
                      ),
                    ),
                  ),
                  Text(
                    "Credi",
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: max(height * 0.05, 20),
                      fontWeight: FontWeight.normal,
                      color: DesignColors.extraColorWhite,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Secure, Private, Yours",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(text: "Welcome to "),
                            TextSpan(
                              text: "Credi",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    ", your secure SSI wallet. Get started by signing up or logging in."),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: pinController,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Pin Code',
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LandingPageButton(
                            text: 'Sign Up',
                            onPressed: () => register(context),
                          ),
                          SizedBox(height: 20),
                          LandingPageButton(
                            text: 'Sign In',
                            onPressed: () => login(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          mini: true,
          onPressed: () => devSignIn(context),
          child: const Icon(Icons.developer_mode),
        ),
      ),
    );
  }
}
