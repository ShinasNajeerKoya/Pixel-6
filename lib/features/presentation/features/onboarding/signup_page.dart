import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixel6_test/features/data/models/user_model.dart';
import 'package:pixel6_test/features/presentation/features/onboarding/login_page.dart';
import 'package:pixel6_test/features/presentation/features/onboarding/select_image_page.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_button.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    initialGetSaveData();
  }

  void initialGetSaveData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  void storeFormData() {
    String uniqueLoginKey = usernameController.text;
    // generate unique key for each login so that the stored data will not be overwritten

    User user = User(
      username: usernameController.text,
      password: passwordController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
    );

    String userdata = jsonEncode(user);
    sharedPreferences!.setString(uniqueLoginKey, userdata);
  }

  void signUserUp() {
    setState(() {
      storeFormData();
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SelectImagePage(
                  userLoginKey: usernameController.text,
                )));
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: sharedPreferences == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const SizedBox(height: 80),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/logo/pixel6_login_logo.png"),
                  ),
                  const SizedBox(height: 70),
                  CustomTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'Phone Number',
                    obscureText: false,
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    onTap: signUserUp,
                    title: "Sign Up",
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                        child: const CustomText(
                          title: 'SignIn now',
                          fontColor: Color(0xffb2340d),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
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
