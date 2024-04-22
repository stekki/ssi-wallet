// ignore_for_file: use_build_context_synchronously, unused_local_variable

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
    String jwt = '';
    _showLoadingDialog(context);
    try {
      jwt = await authnCmd("login", emailController.text, pinController.text);
      SecureStorageUtil().writeToken(jwt);
      GraphQLConfig().createClient();
      context.go('/home');
    } on Exception catch (e) {
      //helpers.showErrorSnackBar(context, "An unexpected error occurred");
      helpers.showErrorSnackBar(context, e.toString());
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future<void> register(BuildContext context) async {
    _showLoadingDialog(context);
    try {
      final jwt =
          await authnCmd("register", emailController.text, pinController.text);
      helpers.showInfoSnackBar(context, "Registration successful");
    } catch (e) {
      helpers.showErrorSnackBar(context, e.toString());
    } finally {
      Navigator.of(context).pop();
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
      body: Column(
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
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LandingPageButton(
                        text: 'Sign Up',
                        onPressed: () => register(context),
                      ),
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
        ],
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
