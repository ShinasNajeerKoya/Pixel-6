import 'dart:convert';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixel6_test/core/utils/notification_utils.dart';
import 'package:pixel6_test/features/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String userLoginKey;

  const ProfilePage({super.key, required this.userLoginKey});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userdata = prefs.getString(widget.userLoginKey);
    if (userdata != null) {
      setState(() {
        user = User.fromJson(jsonDecode(userdata));
      });
    }
  }

  Future<void> _selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        user?.image = base64Encode(imageBytes);
        profilePictureUpdatedNotification();
      });
      await _saveUserToPreferences();
    }
  }

  Future<void> _saveUserToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user != null) {
      await prefs.setString(widget.userLoginKey, jsonEncode(user!.toJson()));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (user!.image != null)
                    GestureDetector(
                      onTap: () {
                        _selectImage();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: MemoryImage(
                                base64Decode(user!.image!),
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${user!.username}'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Password: ${user!.password}'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Email: ${user!.email}'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Phone Number: ${user!.phoneNumber}'),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
