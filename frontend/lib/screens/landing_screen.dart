import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../utils/custom_clippers.dart';
import '../utils/styles.dart';
import '../widgets/custom_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
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

  Widget signInOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        LandingPageButton(
          text: 'Login with Email',
          onPressed: () {
            // Login with Email logic
          },
        ),
        const SizedBox(height: Constants.lpLoginButtonSpacing),
        LandingPageButton(
          text: 'Login with FaceID',
          onPressed: () {
            // Login with FaceID logic
          },
        ),
        const SizedBox(height: Constants.lpLoginButtonSpacing),
        LandingPageButton(
          text: 'Piss-Head Login',
          onPressed: () {
            // Login with Piss-Head
            log('My man Piss-Head');
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