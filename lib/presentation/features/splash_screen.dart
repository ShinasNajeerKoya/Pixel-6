import 'package:flutter/material.dart';
import 'package:pixel6_test/presentation/features/customer/customers_listing/customers_listing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CustomersListingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: const BoxDecoration(),
          child: Image.asset("assets/logo/pixel6_login_logo.png", fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}
