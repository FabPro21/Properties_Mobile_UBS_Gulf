// import 'package:get/get.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:flutter/material.dart';

// class InternetConnectivity extends GetxController {
//   // RxBool isConnected = false.obs;

//   @override
//   void onInit() {
//     checkInternetConnection();
//     super.onInit();
//   }

//   void checkInternetConnection() async {
//     await Future.delayed(Duration(seconds: 3));
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       if (result == ConnectivityResult.mobile ||
//           result == ConnectivityResult.wifi) {
//         // isConnected.value = true;
//         print('*****************Connected**************');
//         showSimpleNotification(Text("Internet Connected"),
//             background: Colors.green);
//       } else {
//         print('*****************Disconnected**************');
//         showSimpleNotification(Text("No Internet"), background: Colors.green);
//         // isConnected.value = false;
//       }
//     });
//   }
// }
