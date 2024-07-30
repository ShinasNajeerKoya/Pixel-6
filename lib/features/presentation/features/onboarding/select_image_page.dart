import 'dart:convert';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixel6_test/core/utils/notification_utils.dart';
import 'package:pixel6_test/features/data/models/user_model.dart';
import 'package:pixel6_test/features/presentation/features/home/home_page.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_elevated_button.dart';
import 'package:pixel6_test/features/presentation/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectImagePage extends StatefulWidget {
  final String userLoginKey;

  const SelectImagePage({super.key, required this.userLoginKey});

  @override
  _SelectImagePageState createState() => _SelectImagePageState();
}

class _SelectImagePageState extends State<SelectImagePage> {
  User? user;
  final ImagePicker _picker = ImagePicker();
  String _pickImageError = "";

  @override
  void initState() {
    super.initState();
    _loadUserFromPreferences();
  }

  Future<void> _loadUserFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(widget.userLoginKey);
    if (userDataJson != null) {
      setState(() {
        user = User.fromJson(jsonDecode(userDataJson));
      });
    }
  }

  Future<void> _selectImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        Uint8List imageBytes = await image.readAsBytes();
        setState(() {
          user?.image = base64Encode(imageBytes);
        });
      }
    } catch (error) {
      setState(() {
        _pickImageError = error.toString();
      });
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                title: 'Upload an Image',
                fontSize: 18,
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  if (user?.image != null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Image.memory(base64Decode(user!.image!)),
                      ),
                    );
                  }
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: const [10, 7],
                  radius: const Radius.circular(2),
                  strokeWidth: 2,
                  child: SizedBox(
                    height: height / 2,
                    width: width / 1.2,
                    child: user?.image == null
                        ? Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/icons/gallery_icon.png"),
                            ),
                          )
                        : Image.memory(
                            base64Decode(user!.image!),
                            fit: BoxFit.fitHeight,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    onTap: _selectImage,
                    title: "Upload",
                  ),
                  CustomElevatedButton(
                    title: "Save Image",
                    fontColor: Colors.white,
                    backgroundColor: const Color(0xffF5852B),
                    onTap: () async {
                      if (user?.image != null) {
                        await _saveUserToPreferences();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(userLoginKey: widget.userLoginKey),
                          ),
                        );
                        // notification
                        // sendWelcomeNotification();
                      } else {
                        print("no image");
                        setState(() {
                          _pickImageError = "No image found";
                        });
                      }
                    },
                  ),
                ],
              ),
              if (_pickImageError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                  child: Text(
                    _pickImageError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
