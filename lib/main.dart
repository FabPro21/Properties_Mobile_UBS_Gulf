import 'dart:io';
import 'package:fap_properties/utils/push_notifications_service.dart';
import 'package:fap_properties/views/auth/splash_screen/splash_screen.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sizer/sizer.dart';
// import 'package:flutter/foundation.dart';

/* -------------------------------------------------------------------------- */
/*                     // bypass this Mir Iftikhar says                       */
/* -------------------------------------------------------------------------- */

// Enable Firebase
// by using Enable Firebase we can find the place where we can enable/disable firebase

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/* -------------------------------------------------------------------------- */
/*                     // bypass this Mir Iftikhar says                     */
/* -------------------------------------------------------------------------- */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // For Production  Must uncomment before go live
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider:
  //       kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  //   appleProvider: kDebugMode
  //       ? AppleProvider.debug
  //       : AppleProvider.appAttestWithDeviceCheckFallback,
  // );
  // await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  // await FirebaseAppCheck.instance.getToken();
  // Must uncomment before go live

  // for download file
  await FlutterDownloader.initialize(
    debug:
        true, // optional: set to false to disable printing logs to console (default: true)
  );

  await dotenv.load(fileName: ".env");
  HttpOverrides.global = new MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // myCustomImplementation();
    // privacyScreen();
    super.initState();
  }

  // privacyScreen() when user tap on home button (android) or same in iphone
  // app move on background this func will show white screen istead of showing data
  // AppIcon
  // LaunchImage
  // splash
  // backgroundImg1
  // Future<void> privacyScreen() async {
  //   bool result = await PrivacyScreen.instance.enable(
  //     iosOptions: const PrivacyIosOptions(
  //       enablePrivacy: true,
  //       privacyImageName: "",
  //       autoLockAfterSeconds: -1,
  //       lockTrigger: IosLockTrigger.willResignActive,
  //     ),
  //     androidOptions: const PrivacyAndroidOptions(
  //       enableSecure: true,
  //       autoLockAfterSeconds: 0,
  //     ),
  //     backgroundColor: Colors.white.withOpacity(0),
  //     blurEffect: PrivacyBlurEffect.light,
  //   );
  //   print(result);
  // }

  // Future myCustomImplementation() async {
  //   try {
  //     String checkMsg;
  //     log(AppConfig().baseUrl);
  //     List<String> allowedShAFingerprintList = [
  //       "9F A6 EF 8C 93 86 50 C9 4D 95 96 ED 2E 84 BF 21 F7 1E C3 AC"
  //     ];
  //     Map<String, String> headerHttp;
  //     final secure = await HttpCertificatePinning.check(
  //       serverURL: 'https://landlord.fabproperties.ae',
  //       headerHttp: headerHttp,
  //       sha: SHA.SHA1,
  //       allowedSHAFingerprints: allowedShAFingerprintList,
  //       timeout: 50,
  //     );

  //     checkMsg = secure;
  //     log("RESULT false: $checkMsg");
  //     if (secure.contains("CONNECTION_SECURE")) {
  //       log("RESULT true: $checkMsg");
  //       return true;
  //     } else {
  //       log("RESULT false: $checkMsg");
  //       return false;
  //     }
  //   } catch (e) {
  //     log("message error == $e");
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // myCustomImplementation();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
         localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          builder: (BuildContext context, Widget child) {
            final MediaQueryData data = MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            );
            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: 1.0,
              ),
              child: child,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
              ),
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.grey,
              canvasColor: Colors.transparent,
              snackBarTheme:
                  SnackBarThemeData(backgroundColor: Colors.white54)),
          home: SplashScreen(),
          onInit: () {
            PushNotificationService().setupInteractedMessage();
          },
        );
      },
    );
  }
}


// import 'dart:io';
// import 'package:fap_properties/utils/push_notifications_service.dart';
// import 'package:fap_properties/views/auth/splash_screen/splash_screen.dart';
// // import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:get/get.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:sizer/sizer.dart';
// // import 'package:flutter/foundation.dart';

// /* -------------------------------------------------------------------------- */
// /*                     // bypass this Mir Iftikhar says                       */
// /* -------------------------------------------------------------------------- */

// // Enable Firebase
// // by using Enable Firebase we can find the place where we can enable/disable firebase

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     // bypass this Mir Iftikhar says                     */
// /* -------------------------------------------------------------------------- */

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   // For Production  Must uncomment before go live
//   // await FirebaseAppCheck.instance.activate(
//   //   androidProvider:
//   //       kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
//   //   appleProvider: kDebugMode
//   //       ? AppleProvider.debug
//   //       : AppleProvider.appAttestWithDeviceCheckFallback,
//   // );
//   // await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
//   // await FirebaseAppCheck.instance.getToken();
//   // Must uncomment before go live

//   // for download file
//   await FlutterDownloader.initialize(
//     debug:
//         true, // optional: set to false to disable printing logs to console (default: true)
//     // ignoreSsl:
//     //     true // option: set to false to disable working with http links (default: false)
//   );

//   await dotenv.load(fileName: ".env");
//   HttpOverrides.global = new MyHttpOverrides();

//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light));
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   runApp(
//     Phoenix(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     // myCustomImplementation();
//     // privacyScreen();
//     super.initState();
//   }

//   // privacyScreen() when user tap on home button (android) or same in iphone
//   // app move on background this func will show white screen istead of showing data
//   // AppIcon
//   // LaunchImage
//   // splash
//   // backgroundImg1
//   // Future<void> privacyScreen() async {
//   //   bool result = await PrivacyScreen.instance.enable(
//   //     iosOptions: const PrivacyIosOptions(
//   //       enablePrivacy: true,
//   //       privacyImageName: "",
//   //       autoLockAfterSeconds: -1,
//   //       lockTrigger: IosLockTrigger.willResignActive,
//   //     ),
//   //     androidOptions: const PrivacyAndroidOptions(
//   //       enableSecure: true,
//   //       autoLockAfterSeconds: 0,
//   //     ),

//   //     backgroundColor: Colors.white.withOpacity(0),
//   //     blurEffect: PrivacyBlurEffect.light,
//   //   );
//   //   print(result);
//   // }

//   /* -------------------------------------------------------------------------- */
//   /*                     // removing this Mir Iftikhar says                     */
//   /* -------------------------------------------------------------------------- */
// // for Feed Back 123
//   // Future myCustomImplementation() async {
//   //   try {
//   //     String checkMsg;
//   //     log(AppConfig().baseUrl);
//   //     List<String> allowedShAFingerprintList = [
//   //       "9F A6 EF 8C 93 86 50 C9 4D 95 96 ED 2E 84 BF 21 F7 1E C3 AC"
//   //     ];
//   //     Map<String, String> headerHttp;
//   //     final secure = await HttpCertificatePinning.check(
//   //       serverURL: "https://uatlandlord.fabproperties.ae/",
//   //       headerHttp: headerHttp,
//   //       sha: SHA.SHA1,
//   //       allowedSHAFingerprints: allowedShAFingerprintList,
//   //       timeout: 50,
//   //     );

//   //     checkMsg = secure;
//   //     log("RESULT false: $checkMsg");
//   //     if (secure.contains("CONNECTION_SECURE")) {
//   //       log("RESULT true: $checkMsg");
//   //       return true;
//   //     } else {
//   //       log("RESULT false: $checkMsg");
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     log("message error == $e");
//   //     return false;
//   //   }
//   // }
// // 112233
// // sending dumny req no for testing

//   @override
//   Widget build(BuildContext context) {
//     // myCustomImplementation();

//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return GetMaterialApp(
//           // add builder because want to make indepent app for font size of device
//           localizationsDelegates: [
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//           supportedLocales: [
//             Locale('en', ''),
//             Locale('ar', ''), // arabic, no country code
//           ],
//           builder: (BuildContext context, Widget child) {
//             final MediaQueryData data = MediaQuery.of(context).copyWith(
//               textScaleFactor: 1.0,
//             );
//             return MediaQuery(
//               data: data.copyWith(
//                 textScaleFactor: 1.0,
//               ),
//               child: child,
//             );
//           },
//           // above lines for restrict the use of device dont
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//               appBarTheme: AppBarTheme(
//                 backgroundColor: Colors.white,
//               ),
//               backgroundColor: Colors.white,
//               scaffoldBackgroundColor: Colors.grey,
//               canvasColor: Colors.transparent,
//               snackBarTheme:
//                   SnackBarThemeData(backgroundColor: Colors.white54)),
//           home: SplashScreen(),
//           onInit: () {
//             PushNotificationService().setupInteractedMessage();
//           },
//         );
//         // return GetMaterialApp(
//         //   debugShowCheckedModeBanner: false,
//         //   theme: ThemeData(
//         //       appBarTheme: AppBarTheme(
//         //           backgroundColor: Colors.white,
//         //           systemOverlayStyle: SystemUiOverlayStyle.light),
//         //       backgroundColor: Colors.white,
//         //       scaffoldBackgroundColor: Colors.grey,
//         //       canvasColor: Colors.transparent,
//         //       snackBarTheme:
//         //           SnackBarThemeData(backgroundColor: Colors.white54)),
//         //   home: SplashScreen(),
//         //   onInit: () {
//         //     PushNotificationService().setupInteractedMessage();
//         //   },
//         // );
//       },
//     );
//   }
// }












//  < ------------------------------------------------------ > //

// import 'dart:io';

// import 'package:fap_properties/utils/push_notifications_service.dart';
// import 'package:fap_properties/views/auth/splash_screen/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:get/get.dart';
// // import 'package:privacy_screen/privacy_screen.dart';
// import 'package:sizer/sizer.dart';

// // F671AEDA56B10182E0530AA3CA2EF0A4

// /* -------------------------------------------------------------------------- */
// /*                     // bypass this Mir Iftikhar says                       */
// /* -------------------------------------------------------------------------- */

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     // bypass this Mir Iftikhar says                     */
// /* -------------------------------------------------------------------------- */

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // for download file
//   await FlutterDownloader.initialize(
//     debug:
//         true, // optional: set to false to disable printing logs to console (default: true)
//     // ignoreSsl:
//     //     true // option: set to false to disable working with http links (default: false)
//   );

//   await dotenv.load(fileName: ".env");
//   HttpOverrides.global = new MyHttpOverrides();

//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light));
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   runApp(
//     Phoenix(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     // myCustomImplementation();
//     // privacyScreen();
//     super.initState();
//   }

//   // privacyScreen() when user tap on home button (android) or same in iphone
//   // app move on background this func will show white screen istead of showing data
//   // AppIcon
//   // LaunchImage
//   // splash
//   // backgroundImg1
//   // Future<void> privacyScreen() async {
//   //   bool result = await PrivacyScreen.instance.enable(
//   //     iosOptions: const PrivacyIosOptions(
//   //       enablePrivacy: true,
//   //       privacyImageName: "",
//   //       autoLockAfterSeconds: -1,
//   //       lockTrigger: IosLockTrigger.willResignActive,
//   //     ),
//   //     androidOptions: const PrivacyAndroidOptions(
//   //       enableSecure: true,
//   //       autoLockAfterSeconds: 0,
//   //     ),

//   //     backgroundColor: Colors.white.withOpacity(0),
//   //     blurEffect: PrivacyBlurEffect.light,
//   //   );
//   //   print(result);
//   // }

//   /* -------------------------------------------------------------------------- */
//   /*                     // removing this Mir Iftikhar says                     */
//   /* -------------------------------------------------------------------------- */
// // for Feed Back 123
//   // Future myCustomImplementation() async {
//   //   try {
//   //     String checkMsg;
//   //     log(AppConfig().baseUrl);
//   //     List<String> allowedShAFingerprintList = [
//   //       "9F A6 EF 8C 93 86 50 C9 4D 95 96 ED 2E 84 BF 21 F7 1E C3 AC"
//   //     ];
//   //     Map<String, String> headerHttp;
//   //     final secure = await HttpCertificatePinning.check(
//   //       serverURL: "https://uatlandlord.fabproperties.ae/",
//   //       headerHttp: headerHttp,
//   //       sha: SHA.SHA1,
//   //       allowedSHAFingerprints: allowedShAFingerprintList,
//   //       timeout: 50,
//   //     );

//   //     checkMsg = secure;
//   //     log("RESULT false: $checkMsg");
//   //     if (secure.contains("CONNECTION_SECURE")) {
//   //       log("RESULT true: $checkMsg");
//   //       return true;
//   //     } else {
//   //       log("RESULT false: $checkMsg");
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     log("message error == $e");
//   //     return false;
//   //   }
//   // }
// // 112233
// // sending dumny req no for testing

//   @override
//   Widget build(BuildContext context) {
//     // myCustomImplementation();

//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return GetMaterialApp(
//           // add builder because want to make indepent app for font size of device
//           builder: (BuildContext context, Widget child) {
//             final MediaQueryData data = MediaQuery.of(context).copyWith(
//               textScaleFactor: 1.0,
//             );
//             return MediaQuery(
//               data: data.copyWith(
//                 textScaleFactor: 1.0,
//               ),
//               child: child,
//             );
//           },
//           // above lines for restrict the use of device dont
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//               appBarTheme: AppBarTheme(
//                 backgroundColor: Colors.white,
//               ),
//               backgroundColor: Colors.white,
//               scaffoldBackgroundColor: Colors.grey,
//               canvasColor: Colors.transparent,
//               snackBarTheme:
//                   SnackBarThemeData(backgroundColor: Colors.white54)),
//           home: SplashScreen(),
//           onInit: () {
//             PushNotificationService().setupInteractedMessage();
//           },
//         );
//         // return GetMaterialApp(
//         //   debugShowCheckedModeBanner: false,
//         //   theme: ThemeData(
//         //       appBarTheme: AppBarTheme(
//         //           backgroundColor: Colors.white,
//         //           systemOverlayStyle: SystemUiOverlayStyle.light),
//         //       backgroundColor: Colors.white,
//         //       scaffoldBackgroundColor: Colors.grey,
//         //       canvasColor: Colors.transparent,
//         //       snackBarTheme:
//         //           SnackBarThemeData(backgroundColor: Colors.white54)),
//         //   home: SplashScreen(),
//         //   onInit: () {
//         //     PushNotificationService().setupInteractedMessage();
//         //   },
//         // );
//       },
//     );
//   }
// }
// import 'dart:io';
// import 'package:fap_properties/utils/push_notifications_service.dart';
// import 'package:fap_properties/views/auth/splash_screen/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:get/get.dart';
// // import 'package:privacy_screen/privacy_screen.dart';
// import 'package:sizer/sizer.dart';

// // F671AEDA56B10182E0530AA3CA2EF0A4

// /* -------------------------------------------------------------------------- */
// /*                     // bypass this Mir Iftikhar says                       */
// /* -------------------------------------------------------------------------- */

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

// /* -------------------------------------------------------------------------- */
// /*                     // bypass this Mir Iftikhar says                     */
// /* -------------------------------------------------------------------------- */

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // for download file
//   await FlutterDownloader.initialize(
//     debug:
//         true, // optional: set to false to disable printing logs to console (default: true)
//     // ignoreSsl:
//     //     true // option: set to false to disable working with http links (default: false)
//   );

//   await dotenv.load(fileName: ".env");
//   HttpOverrides.global = new MyHttpOverrides();

//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light));
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   runApp(
//     Phoenix(
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     // myCustomImplementation();
//     // privacyScreen();
//     super.initState();
//   }

//   // privacyScreen() when user tap on home button (android) or same in iphone
//   // app move on background this func will show white screen istead of showing data
//   // AppIcon
//   // LaunchImage
//   // splash
//   // backgroundImg1
//   // Future<void> privacyScreen() async {
//   //   bool result = await PrivacyScreen.instance.enable(
//   //     iosOptions: const PrivacyIosOptions(
//   //       enablePrivacy: true,
//   //       privacyImageName: "",
//   //       autoLockAfterSeconds: -1,
//   //       lockTrigger: IosLockTrigger.willResignActive,
//   //     ),
//   //     androidOptions: const PrivacyAndroidOptions(
//   //       enableSecure: true,
//   //       autoLockAfterSeconds: 0,
//   //     ),

//   //     backgroundColor: Colors.white.withOpacity(0),
//   //     blurEffect: PrivacyBlurEffect.light,
//   //   );
//   //   print(result);
//   // }

//   /* -------------------------------------------------------------------------- */
//   /*                     // removing this Mir Iftikhar says                     */
//   /* -------------------------------------------------------------------------- */
// // for Feed Back 123
//   // Future myCustomImplementation() async {
//   //   try {
//   //     String checkMsg;
//   //     log(AppConfig().baseUrl);
//   //     List<String> allowedShAFingerprintList = [
//   //       "9F A6 EF 8C 93 86 50 C9 4D 95 96 ED 2E 84 BF 21 F7 1E C3 AC"
//   //     ];
//   //     Map<String, String> headerHttp;
//   //     final secure = await HttpCertificatePinning.check(
//   //       serverURL: "https://uatlandlord.fabproperties.ae/",
//   //       headerHttp: headerHttp,
//   //       sha: SHA.SHA1,
//   //       allowedSHAFingerprints: allowedShAFingerprintList,
//   //       timeout: 50,
//   //     );

//   //     checkMsg = secure;
//   //     log("RESULT false: $checkMsg");
//   //     if (secure.contains("CONNECTION_SECURE")) {
//   //       log("RESULT true: $checkMsg");
//   //       return true;
//   //     } else {
//   //       log("RESULT false: $checkMsg");
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     log("message error == $e");
//   //     return false;
//   //   }
//   // }
// // 112233
// // sending dumny req no for testing

//   @override
//   Widget build(BuildContext context) {
//     // myCustomImplementation();

//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return GetMaterialApp(
//           // add builder because want to make indepent app for font size of device
//           builder: (BuildContext context, Widget child) {
//             final MediaQueryData data = MediaQuery.of(context).copyWith(
//               textScaleFactor: 1.0,
//             );
//             return MediaQuery(
//               data: data.copyWith(
//                 textScaleFactor: 1.0,
//               ),
//               child: child,
//             );
//           },
//           // above lines for restrict the use of device dont
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//               appBarTheme: AppBarTheme(
//                 backgroundColor: Colors.white,
//               ),
//               backgroundColor: Colors.white,
//               scaffoldBackgroundColor: Colors.grey,
//               canvasColor: Colors.transparent,
//               snackBarTheme:
//                   SnackBarThemeData(backgroundColor: Colors.white54)),
//           home: SplashScreen(),
//           onInit: () {
//             PushNotificationService().setupInteractedMessage();
//           },
//         );
//         // return GetMaterialApp(
//         //   debugShowCheckedModeBanner: false,
//         //   theme: ThemeData(
//         //       appBarTheme: AppBarTheme(
//         //           backgroundColor: Colors.white,
//         //           systemOverlayStyle: SystemUiOverlayStyle.light),
//         //       backgroundColor: Colors.white,
//         //       scaffoldBackgroundColor: Colors.grey,
//         //       canvasColor: Colors.transparent,
//         //       snackBarTheme:
//         //           SnackBarThemeData(backgroundColor: Colors.white54)),
//         //   home: SplashScreen(),
//         //   onInit: () {
//         //     PushNotificationService().setupInteractedMessage();
//         //   },
//         // );
//       },
//     );
//   }
// }
// // import 'dart:io';

// // import 'package:fap_properties/utils/push_notifications_service.dart';
// // import 'package:fap_properties/views/auth/splash_screen/splash_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_dotenv/flutter_dotenv.dart';
// // import 'package:flutter_downloader/flutter_downloader.dart';
// // import 'package:flutter_phoenix/flutter_phoenix.dart';
// // import 'package:get/get.dart';
// // // import 'package:privacy_screen/privacy_screen.dart';
// // import 'package:sizer/sizer.dart';

// // // F671AEDA56B10182E0530AA3CA2EF0A4

// // /* -------------------------------------------------------------------------- */
// // /*                     // bypass this Mir Iftikhar says                       */
// // /* -------------------------------------------------------------------------- */

// // class MyHttpOverrides extends HttpOverrides {
// //   @override
// //   HttpClient createHttpClient(SecurityContext context) {
// //     return super.createHttpClient(context)
// //       ..badCertificateCallback =
// //           (X509Certificate cert, String host, int port) => true;
// //   }
// // }

// // /* -------------------------------------------------------------------------- */
// // /*                     // bypass this Mir Iftikhar says                     */
// // /* -------------------------------------------------------------------------- */

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   // for download file
// //   await FlutterDownloader.initialize(
// //     debug:
// //         true, // optional: set to false to disable printing logs to console (default: true)
// //     // ignoreSsl:
// //     //     true // option: set to false to disable working with http links (default: false)
// //   );

// //   await dotenv.load(fileName: ".env");
// //   HttpOverrides.global = new MyHttpOverrides();

// //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
// //       statusBarColor: Colors.transparent,
// //       statusBarIconBrightness: Brightness.light));
// //   SystemChrome.setPreferredOrientations(
// //       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
// //   runApp(
// //     Phoenix(
// //       child: MyApp(),
// //     ),
// //   );
// // }

// // class MyApp extends StatefulWidget {
// //   const MyApp({Key key}) : super(key: key);

// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   @override
// //   void initState() {
// //     // myCustomImplementation();
// //     // privacyScreen();
// //     super.initState();
// //   }

// //   // privacyScreen() when user tap on home button (android) or same in iphone
// //   // app move on background this func will show white screen istead of showing data
// //   // AppIcon
// //   // LaunchImage
// //   // splash
// //   // backgroundImg1
// //   // Future<void> privacyScreen() async {
// //   //   bool result = await PrivacyScreen.instance.enable(
// //   //     iosOptions: const PrivacyIosOptions(
// //   //       enablePrivacy: true,
// //   //       privacyImageName: "",
// //   //       autoLockAfterSeconds: -1,
// //   //       lockTrigger: IosLockTrigger.willResignActive,
// //   //     ),
// //   //     androidOptions: const PrivacyAndroidOptions(
// //   //       enableSecure: true,
// //   //       autoLockAfterSeconds: 0,
// //   //     ),

// //   //     backgroundColor: Colors.white.withOpacity(0),
// //   //     blurEffect: PrivacyBlurEffect.light,
// //   //   );
// //   //   print(result);
// //   // }

// //   /* -------------------------------------------------------------------------- */
// //   /*                     // removing this Mir Iftikhar says                     */
// //   /* -------------------------------------------------------------------------- */
// // // for Feed Back 123
// //   // Future myCustomImplementation() async {
// //   //   try {
// //   //     String checkMsg;
// //   //     log(AppConfig().baseUrl);
// //   //     List<String> allowedShAFingerprintList = [
// //   //       "9F A6 EF 8C 93 86 50 C9 4D 95 96 ED 2E 84 BF 21 F7 1E C3 AC"
// //   //     ];
// //   //     Map<String, String> headerHttp;
// //   //     final secure = await HttpCertificatePinning.check(
// //   //       serverURL: "https://uatlandlord.fabproperties.ae/",
// //   //       headerHttp: headerHttp,
// //   //       sha: SHA.SHA1,
// //   //       allowedSHAFingerprints: allowedShAFingerprintList,
// //   //       timeout: 50,
// //   //     );

// //   //     checkMsg = secure;
// //   //     log("RESULT false: $checkMsg");
// //   //     if (secure.contains("CONNECTION_SECURE")) {
// //   //       log("RESULT true: $checkMsg");
// //   //       return true;
// //   //     } else {
// //   //       log("RESULT false: $checkMsg");
// //   //       return false;
// //   //     }
// //   //   } catch (e) {
// //   //     log("message error == $e");
// //   //     return false;
// //   //   }
// //   // }
// // // 112233
// // // sending dumny req no for testing

// //   @override
// //   Widget build(BuildContext context) {
// //     // myCustomImplementation();

// //     return Sizer(
// //       builder: (context, orientation, deviceType) {
// //         return GetMaterialApp(
// //           // add builder because want to make indepent app for font size of device
// //           builder: (BuildContext context, Widget child) {
// //             final MediaQueryData data = MediaQuery.of(context).copyWith(
// //               textScaleFactor: 1.0,
// //             );
// //             return MediaQuery(
// //               data: data.copyWith(
// //                 textScaleFactor: 1.0,
// //               ),
// //               child: child,
// //             );
// //           },
// //           // above lines for restrict the use of device dont
// //           debugShowCheckedModeBanner: false,
// //           theme: ThemeData(
// //               appBarTheme: AppBarTheme(
// //                 backgroundColor: Colors.white,
// //               ),
// //               backgroundColor: Colors.white,
// //               scaffoldBackgroundColor: Colors.grey,
// //               canvasColor: Colors.transparent,
// //               snackBarTheme:
// //                   SnackBarThemeData(backgroundColor: Colors.white54)),
// //           home: SplashScreen(),
// //           onInit: () {
// //             PushNotificationService().setupInteractedMessage();
// //           },
// //         );
// //         // return GetMaterialApp(
// //         //   debugShowCheckedModeBanner: false,
// //         //   theme: ThemeData(
// //         //       appBarTheme: AppBarTheme(
// //         //           backgroundColor: Colors.white,
// //         //           systemOverlayStyle: SystemUiOverlayStyle.light),
// //         //       backgroundColor: Colors.white,
// //         //       scaffoldBackgroundColor: Colors.grey,
// //         //       canvasColor: Colors.transparent,
// //         //       snackBarTheme:
// //         //           SnackBarThemeData(backgroundColor: Colors.white54)),
// //         //   home: SplashScreen(),
// //         //   onInit: () {
// //         //     PushNotificationService().setupInteractedMessage();
// //         //   },
// //         // );
// //       },
// //     );
// //   }
// // }
