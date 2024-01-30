import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            const Text("Register Screen"),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () => context.go('/'),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(40),
                    right: Radius.circular(40),
                  )),
                  backgroundColor: const Color.fromARGB(255, 88, 52, 52),
                ),
                child: const Text('go back')),
          ])),
    );
  }
}
