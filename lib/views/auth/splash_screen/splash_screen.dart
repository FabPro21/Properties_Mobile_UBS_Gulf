// ignore_for_file: unused_import

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/auth/splash_screen/splash_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashScreenController = Get.put(SplashScreenController());

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    // Enable Firebase
    // From SessionController().enableFireBaseOTP this flag we are enabling and disable firebase
    SessionController().enableFireBaseOTP = true;
    splashScreenController.isSetupMpin();

    _getFcmToken();
    _setupNotificationListeners();
    super.initState();
  }

  void _getFcmToken() async {
    // Get the FCM token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }

  void _setupNotificationListeners() {
    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.messageId}');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle notifications when the app is opened from a terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked: ${message.messageId}');
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }

  @override
  Widget build(BuildContext context) {
    print(' isFab App :::::: ${SessionController().isFabApp}');
    return Scaffold(
      backgroundColor: AppColors.colliersBackgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagesPath.splash_Colliers),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
