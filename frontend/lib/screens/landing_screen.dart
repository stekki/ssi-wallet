import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/constants.dart';
import '../utils/custom_clippers.dart';
import '../utils/secure_storage.dart';
import '../utils/styles.dart';
import '../widgets/landing_page_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> promptForToken(BuildContext context) async {
    TextEditingController tokenController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter JWT Token'),
          content: TextField(
            controller: tokenController,
            decoration: const InputDecoration(hintText: 'JWT Token'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                String token = tokenController.text;
                // TODO: validate the token before proceeding, assume that token input is always correct
                SecureStorageUtil().writeToken(token);
                Navigator.of(context).pop(); // Close the dialog
                context.go('/home');
              },
            ),
          ],
        );
      },
    );
  }

  Widget signInOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        LandingPageButton(
          text: 'Sign in with Email',
          onPressed: () {
            // Sign in with Email logic
          },
        ),
        const SizedBox(height: Constants.lpLoginButtonSpacing),
        LandingPageButton(
          text: 'Sign in with FaceID',
          onPressed: () {
            // Sign in with FaceID logic
          },
        ),
        const SizedBox(height: Constants.lpLoginButtonSpacing),
        LandingPageButton(
          text: 'Sign in with token (dev)',
          onPressed: () {
            // Sign in with token
            promptForToken(context);
          },
          color: DesignColors.devRed,
        ),
        const SizedBox(height: Constants.lpLoginButtonSpacing),
        LandingPageButton(
          text: 'Skip to home (dev)',
          onPressed: () {
            // Sign in with Piss-Head
            log('My man, Piss-Head');
            context.go('/home');
          },
          color: DesignColors.devRed,
        ),
      ],
    );
  }

  Widget registerForm() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: DesignColors.tertiaryColor,
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
                    color: DesignColors.secondaryColor,
                  ),
                )
              ],
            ),
            ClipPath(
              clipper: FirstClipper(),
              child: Container(
                color: DesignColors.secondaryColor,
              ),
            ),
            ClipPath(
              clipper: SecondClipper(),
              child: Container(
                color: DesignColors.tertiaryColor,
              ),
            ),
            ClipPath(
              clipper: ThirdClipper(),
              child: Container(
                color: DesignColors.tertiaryColor,
              ),
            ),
            Positioned(
              top: height * 0.05,
              child: const Text('SSI Wallet!!!', style: TextStyles.lpTitle),
            ),
            Positioned.fill(
              top: height * 0.15,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Sign In'),
                      Tab(text: 'Register'),
                    ],
                    labelColor: Colors.black,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                          child: SingleChildScrollView(
                            child: signInOptions(),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              registerForm(),
                              LandingPageButton(
                                text: 'Register',
                                onPressed: () {
                                  // Register logic
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
