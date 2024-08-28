// ignore_for_file: unused_import

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/views/auth/splash_screen/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashScreenController = Get.put(SplashScreenController());

  @override
  void initState() {
    // Enable Firebase
    // From SessionController().enableFireBaseOTP this flag we are enabling and disable firebase
    SessionController().enableFireBaseOTP = true; 
    splashScreenController.isSetupMpin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(' isFab App :::::: ${SessionController().isFabApp}');
    return Scaffold(
      backgroundColor: Color(0xFF001838),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagesPath.splashGif),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
