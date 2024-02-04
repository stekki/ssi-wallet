import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: ProfileCard()),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
        margin: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_circle_rounded,
                size: 64,
                semanticLabel: 'Profile picture',
              ),
              // TODO: Add a user info based on login info
              ListTile(
                  title: Center(
                      child: Text(
                    "Piss Head",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
                  )),
                  subtitle: Center(child: Text("pisshead@gmail.com"))),
              Icon(
                Icons.qr_code_2,
                size: 256,
              ),
              // TODO: Add button for sharing
            ]));
  }
}
