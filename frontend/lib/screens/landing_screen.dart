//import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/secure_storage.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/landing_page_button.dart';
import 'package:frontend/utils/helpers.dart' as helpers;

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
      ],
    );
  }

/*
  Widget developerOptions() {
    return Column(
      children: <Widget>[
        const SizedBox(height: Constants.lpLoginButtonSpacing),
        LandingPageButton(
          text: 'Sign in with token (dev)',
          onPressed: () {
            // Sign in with token
            promptForToken(context);
          },
          color: DesignColors.extraColorGray,
        ),
        const SizedBox(height: Constants.lpLoginButtonSpacing),
        LandingPageButton(
          text: 'Skip to home (dev)',
          onPressed: () {
            // Sign in with Piss-Head
            //log('My man, Piss-Head');
            context.go('/home');
          },
          color: DesignColors.extraColorGray,
        )
      ],
    );
  }
  */

  void _showDeveloperOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.vpn_key),
              title: const Text('Sign in with token (dev)'),
              onTap: () {
                Navigator.of(context).pop(); // Dismiss bottom sheet
                promptForToken(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.skip_next),
              title: const Text('Skip to home (dev)'),
              onTap: () {
                Navigator.of(context).pop(); // Dismiss bottom sheet
                context.go('/home');
              },
            ),
          ],
        );
      },
    );
  }

  Widget registerForm(double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: height * 0.07),
      child: const TextField(
        decoration: InputDecoration(
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
      body: Container(
        decoration: scaffoldBackground,
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: height * 0.15,
              child: Column(
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
                    //Theme.of(context).textTheme.displayLarge,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: max(height * 0.05, 20),
                      fontWeight: FontWeight.w900,
                      color: DesignColors.extraColorWhite,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: height * 0.4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  color: DesignColors.extraColorWhite,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Sign In'),
                          Tab(text: 'Register'),
                        ],
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
                                  registerForm(height),
                                  LandingPageButton(
                                    text: 'Register',
                                    onPressed: () {
                                      // Register logic
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) =>
                                              helpers.showInfoSnackBar(context,
                                                  "Registration successful"));
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
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () => _showDeveloperOptions(context),
                backgroundColor: Colors.grey.withOpacity(0.5),
                mini: true,
                child: const Icon(Icons.developer_mode, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
