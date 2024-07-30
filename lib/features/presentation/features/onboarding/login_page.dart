import 'dart:convert';
import 'dart:developer';

import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel6_test/features/data/models/user_model.dart';
import 'package:pixel6_test/features/presentation/features/onboarding/select_image_page.dart';
import 'package:pixel6_test/features/presentation/features/onboarding/signup_page.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_button.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    initialGetSaveData();
  }

  void initialGetSaveData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Set<String> keys = sharedPreferences!.getKeys();

    // logic for showcasing the credentials stored in shared pref
    for (String key in keys) {
      var value = sharedPreferences!.get(key);
      log('Key: $key, Value: $value');
    }
  }

  // for signin

  void signUserIn() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter both username and password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      log("Login Pressed");
      String key = usernameController.text;
      String? userdata = sharedPreferences?.getString(key);

      if (userdata != null) {
        User user = User.fromJson(jsonDecode(userdata));
        if (user.username == usernameController.text && user.password == passwordController.text) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SelectImagePage(
                userLoginKey: usernameController.text,
              ),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Invalid username or password'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('No user found'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      log('Exception details: $error');
    }
  }

  Future<void> _callingFunction(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      path: phoneNumber,
      scheme: 'tel',
    );

    try {
      if (await canLaunchUrl(phoneLaunchUri)) {
        await launchUrl(phoneLaunchUri);
      } else {
        throw "Could not launch phone dialer for number: $phoneNumber";
      }
    } on PlatformException catch (platformError) {
      String platformErrorMessage = platformError.message ?? "An unknown error occurred.";
      floatingSnackBar(
          message: platformErrorMessage,
          context: context,
          backgroundColor: Colors.red.shade800,
          textStyle: const TextStyle(fontSize: 13));
      log("Error launching phone dialer: $platformError");
    } catch (unexpectedErrorCaught) {
      String unexpectedErrorCaughtMessage = "$unexpectedErrorCaught";
      floatingSnackBar(
          message: unexpectedErrorCaughtMessage,
          context: context,
          backgroundColor: Colors.red.shade800,
          textStyle: const TextStyle(fontSize: 13));
      log("Unexpected error: $unexpectedErrorCaughtMessage");
    }
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 80),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/logo/pixel6_login_logo.png"),
            ),
            const SizedBox(height: 140),
            CustomTextField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            CustomButton(
              onTap: signUserIn,
              title: "Sign In",
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const SignupPage()));

                    log("register now clicked");
                  },
                  child: const CustomText(
                    title: 'Register now',
                    fontColor: Color(0xffb2340d),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            const Center(
              child: CustomText(
                title: "v1.0, Pixel6 Web Studio Pvt. Ltd.",
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
