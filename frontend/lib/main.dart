import 'package:flutter/material.dart';
import 'custom_clippers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});
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
                  const Text('FINDY',
                      style: TextStyle(
                          color: Color.fromARGB(255, 94, 136, 180),
                          fontSize: 60,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: height * 0.15),
                  const Text(
                    'Welcome to the Findy Wallet',
                    style: TextStyle(
                        color: Color(0XFF07376F),
                        fontStyle: FontStyle.normal,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Piazzolla"),
                  ),
                  SizedBox(height: height * 0.03875),
                  const Text('Login to the service to continue',
                      style: TextStyle(
                          color: Color(0XFF07376F),
                          fontStyle: FontStyle.normal,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Piazzolla")),
                  SizedBox(height: height * 0.25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20))),
                      backgroundColor: const Color(0XFF07376F),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                      child: Text(
                        'Login With Email',
                        style: TextStyle(
                            color: Color(0XFFE6EDFF),
                            fontStyle: FontStyle.normal,
                            fontSize: 23,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.065),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20))),
                      backgroundColor: const Color(0XFF07376F),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                      child: Text(
                        'Login With Face ID',
                        style: TextStyle(
                            color: Color(0XFFE6EDFF),
                            fontStyle: FontStyle.normal,
                            fontSize: 23,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
