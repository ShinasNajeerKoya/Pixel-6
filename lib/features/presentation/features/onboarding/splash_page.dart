import 'package:flutter/material.dart';
import 'package:pixel6_test/features/presentation/features/onboarding/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Update this with your actual next screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        height: 200,
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(),
        child: Image.asset("assets/logo/pixel6_logo.png", fit: BoxFit.fitHeight),
      )),
    );
  }
}
