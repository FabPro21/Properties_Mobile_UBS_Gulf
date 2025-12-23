// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/services/tenant_services/response_of_multipart.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
import 'package:fap_properties/views/auth/splash_screen/splash_screen.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BaseClientClass {
  // static const int timeOutDuration = 30;
  static const int timeOutDuration = 60;
  static String dumnyUrl = '';
  //////
  static Future<dynamic> post(String url, data, {String? token}) async {
    token ??= SessionController().getToken();
    var forTestingdata = data;
    var data1 = await encriptdata(data);
    data = {"requestBody": data1};
    if (kDebugMode) {
      print('Encripted Data Post $url :::: => $data');
      print('Token Post :::: => $token');
    }
    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $token',
              'ApiKey': 'UZ5QdWg2dLm1sop09082AccIa03DxupsIWDt9rqfeM',
              "raw": "datawithoutfile"
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: timeOutDuration));
      if (kDebugMode) {
        print('response:: ${response.statusCode}');
      }
      return _getResponse(response, url, forTestingdata);
    } on SocketException {
      if (kDebugMode) {
        print('Response :: BCC SocketException:: No internet connection');
      }
      await Get.to(() => const NoInternetScreen());
      Get.offAll(() => const SplashScreen());
      return SessionController().getLanguage() == 1
          ? 'No internet connection'
          : 'لا يوجد اتصال بالإنترنت';
    } on TimeoutException {
      getx.Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().connectionTimedOut,
        backgroundColor: AppColors.white54,
      );
      return AppMetaLabels().connectionTimedOut;
    } catch (e) {
       if (kDebugMode) {
        print(e);
      }
      return AppMetaLabels().anyError;
    }
  }

////////
  static Future<dynamic> postwithheader(String url, data,
      {String? token}) async {
    token ??= SessionController().getToken();
    var forTestingdata = data;
    data = {"requestBody": encriptdata(data)};
    if (kDebugMode) {
      print('Encripted Data PostWithHeader :::: => $data');
    }
    // print('Token PostWithHeader :::: => $token');
    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer $token',
              'ApiKey': 'UZ5QdWg2dLm1sop09082AccIa03DxupsIWDt9rqfeM',
              "raw": "datawithoutfile"
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: timeOutDuration));
      if (kDebugMode) {
        print('Request: ${response.request}');
        // print('Headers: ${response.request.headers}');
        print('End: $url');
      }
      if (kDebugMode) {
        print('response:: ${response.statusCode}');
      }
      return _getResponse(response, url, forTestingdata);
    } on SocketException {
      if (kDebugMode) {
        print('Response :: BCC SocketException:: No internet connection');
      }
      await Get.to(() => const NoInternetScreen());
      Get.offAll(() => const SplashScreen());
      return 'No internet connection';
    } on TimeoutException {
      if (kDebugMode) {
        print('Response ::TimeoutException:: Time out');
      }
      getx.Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().connectionTimedOut,
        backgroundColor: AppColors.white54,
      );
      return AppMetaLabels().connectionTimedOut;
    } catch (e) {
      
      if (kDebugMode) {
        print('Response ::Catch e.toString():: ${e.toString()}');
      print('Response ::Catch:: $e');
      }
      return AppMetaLabels().anyError;
    }
  }

/////////
  static Future<dynamic> postwithheaderwithouttoken(
    String url,
    data,
  ) async {
    dumnyUrl = url;
    var forTestingdata = data;
    data = {"requestBody": encriptdata(data)};
    if (kDebugMode) {
      print('Encripted Data Postwithheaderwithouttoken :::: => $data');
    }

    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(url),
            body: json.encode(data),
            headers: {
              "Content-Type": "application/json",
              'Authorization': 'Bearer ',
              'ApiKey': 'UZ5QdWg2dLm1sop09082AccIa03DxupsIWDt9rqfeM',
              "raw": "datawithoutfile"
            },
            encoding: Encoding.getByName('utf-8'),
          )
          .timeout(const Duration(seconds: timeOutDuration));

       if (kDebugMode) print('Request: ${response.request}');
        // print('Headers: ${response.request.headers}');
       if (kDebugMode) print('End: $url');


     if (kDebugMode) print('response:: ${response.statusCode}');
      return _getResponse(response, url, forTestingdata);
    } on SocketException {
     if (kDebugMode) print('Response :: BCC SocketException:: No internet connection');
      await Get.to(() => const NoInternetScreen());
      Get.offAll(() => const SplashScreen());

      return 'No internet connection';
    } on TimeoutException {
      getx.Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().connectionTimedOut,
        backgroundColor: AppColors.white54,
      );
      return AppMetaLabels().connectionTimedOut;
    } catch (e) {
      if (kDebugMode) print(e);
      return AppMetaLabels().anyError;
    }
  }

///////
  static Future<dynamic> uploadFile(
      String url, Map<String, String> fields, String fileField, String filePath,
      {String? token}) async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      await Get.offAll(const NoInternetScreen());
      Get.offAll(() => const SplashScreen());
      return;
    }
    String bearerToken = token ?? SessionController().getToken() ?? '';
    try {
      http.MultipartRequest request =
          http.MultipartRequest("POST", Uri.parse(url));
      // if (filePath != null) {
      if (filePath != '') {
          if (kDebugMode) {
          print('Inside ::::: ');
        }
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath(fileField, filePath);
        request.files.add(multipartFile);
      }
      request.fields.addAll(fields);
      request.headers.addAll({
        "Content-Type": "application/json",
        'Authorization': 'Bearer $bearerToken',
      });
        if (kDebugMode) {
        print('Request :::::::: $request');
      }
      http.StreamedResponse response = await request.send();
      // var res = await http.Response.fromStream(response);
      // print('Respone :11::22:: ${res.body}');

      if (response.statusCode == 404) {
        final respStr = await response.stream.bytesToString();
        if (response.statusCode == 404 && respStr.contains('HTML') == true ||
            respStr.contains(
                    '!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN') ==
                true) {
          // print(respStr);
          Get.to(() => ResponseInText(
                respose: respStr,
              ));
        }
      }
      // response.statusCode == 401 putting this condition because
      // in multipart we are not calling _getResponse for handle the response
      if (response.statusCode == 401) {
        Get.offAll(() => const SelectRoleScreen());
        getx.Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().unauthorized,
          backgroundColor: AppColors.white54,
        );
        return AppMetaLabels().unauthorized;
      }
      // Response of UploadFile
      // The below lines for print the response of uploadFile
      // var res = await http.Response.fromStream(response);
      // print('Respone :11::22:: ${res.body}');
      return response;
    } catch (e) {
      if (kDebugMode){
        print('Catch ========> From BaseClient $e');
      print(e);
      print(e.toString());
      }
      
      return 0;
    }
  }

  static Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static dynamic _getResponse(
      http.Response response, String url, dynamic data) async {
       if (kDebugMode) { print(
        'Response Body :::: inside getResponse:: $url ::: $data Test:=> ${response.body}');}

    if (response.statusCode == 404) {
      if (response.statusCode == 404 &&
              response.body.contains('HTML') == true ||
          response.body.contains(
                  '!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN') ==
              true) {
        if (kDebugMode) {
          print(response.body);
        }
        await Get.to(() => ResponseInText(
              respose: response.body.trim(),
            ));
      }
    }
     if (response.statusCode == 503) {
      if (response.statusCode == 503 &&
              response.body.contains('HTML') == true ||
          response.body.contains(
                  '!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN') ==
              true) {
        if (kDebugMode) {
          print(response.body);
        }
        await Get.to(() => ResponseInText(
              respose: response.body.trim(),
            ));
      }
    }
    if (response.body.contains('BadRequestExecution Timeout Expired')) {
      if (kDebugMode) {
        print('Response inhelper :: ${response.body}');
      }
      return AppMetaLabels().connectionTimedOut;
    }
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        if (url == AppConfig().validateUser ||
            url == AppConfig().validateUserFB) {
          return AppMetaLabels().invalidPhoneNumber;
        }
        return AppMetaLabels().badRequest;
      case 401:
        Get.offAll(() => const SelectRoleScreen());
        getx.Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().unauthorized,
          backgroundColor: AppColors.white54,
        );
        return AppMetaLabels().unauthorized;
      case 403:
        Get.offAll(() => const SelectRoleScreen());
        getx.Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().unauthorized,
          backgroundColor: AppColors.white54,
        );
        return AppMetaLabels().unauthorized;
      case 404:
        return AppMetaLabels().noDatafound;
      case 500:
        if (kDebugMode) {
          print(response.body);
        }
        // getx.Get.snackbar(
        //   AppMetaLabels().error,
        //   AppMetaLabels().anyError,
        //   backgroundColor: AppColors.white54,
        // );
        return AppMetaLabels().anyError;

      case 501:
        if (kDebugMode) {
          print(response.body);
        }
        getx.Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().processingError,
          backgroundColor: AppColors.white54,
        );
        return AppMetaLabels().noDatafound;

      default:
        getx.Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().couldNotConnectToServer,
          backgroundColor: AppColors.white54,
        );
        return AppMetaLabels().couldNotConnectToServer;
    }
  }
}
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:fap_properties/data/helpers/encription.dart';
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/data/services/tenant_services/response_of_multipart.dart';
// import 'package:fap_properties/utils/constants/app_config.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/views/auth/select_role/select_role_screen.dart';
// import 'package:fap_properties/views/common/no_internet_screen.dart';
// import 'package:flutter/foundation.dart' as foundation;
// import 'package:get/get.dart' as getx;
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class BaseClientClass {
//   // static const int timeOutDuration = 30;
//   static const int timeOutDuration = 60;
//   static String dumnyUrl = '';
//   //////
//   static Future<dynamic> post(String url, data, {String token}) async {
//     if (token == null) token = SessionController().getToken();
//     // print('Url :::: => $url');
//     // print('Data :::: => $data');
//     var data1 = await encriptdata(data);
//     data = {"requestBody": data1};
//     print('Encripted Data Post :::: => $data');
//     // print('Token Post :::: => $token');
//     http.Response response;
//     try {
//       response = await http
//           .post(
//             Uri.parse(url),
//             body: json.encode(data),
//             headers: {
//               "Content-Type": "application/json",
//               'Authorization': 'Bearer $token',
//               'ApiKey': 'UZ5QdWg2dLm1sop09082AccIa03DxupsIWDt9rqfeM',
//               "raw": "datawithoutfile"
//             },
//             encoding: Encoding.getByName('utf-8'),
//           )
//           .timeout(Duration(seconds: timeOutDuration));
//       if (foundation.kDebugMode) {
//         // print('Request: ${response.request}');
//         // print('Headers: ${response.request.headers}');
//         // print('End: $url');
//       }
//       print('response:: ${response.statusCode}');
//       return _getResponse(response, url);
//     } on SocketException {
//       print('Response ::SocketException:: No internet connection');
   

//       return 'No internet connection';
//     } on TimeoutException {
//       print(response);
//       getx.Get.snackbar(
//         AppMetaLabels().error,
//         AppMetaLabels().connectionTimedOut,
//         backgroundColor: AppColors.white54,
//       );
//       return '${AppMetaLabels().connectionTimedOut}';
//     } catch (e) {
//       if (foundation.kDebugMode) print(e);
//       return AppMetaLabels().anyError;
//     }
//   }

// ////////
//   static Future<dynamic> postwithheader(String url, data,
//       {String token}) async {
//     if (token == null) token = SessionController().getToken();
//     print('Url :::: => $url');
//     // print('Data :::: => $data');
//     data = {"requestBody": encriptdata(data)};
//     print('Encripted Data PostWithHeader :::: => $data');
//     // print('Token PostWithHeader :::: => $token');
//     http.Response response;
//     try {
//       response = await http
//           .post(
//             Uri.parse(url),
//             body: json.encode(data),
//             headers: {
//               "Content-Type": "application/json",
//               'Authorization': 'Bearer $token',
//               'ApiKey': 'UZ5QdWg2dLm1sop09082AccIa03DxupsIWDt9rqfeM',
//               "raw": "datawithoutfile"
//             },
//             encoding: Encoding.getByName('utf-8'),
//           )
//           .timeout(Duration(seconds: timeOutDuration));
//       if (foundation.kDebugMode) {
//         print('Request: ${response.request}');
//         // print('Headers: ${response.request.headers}');
//         print('End: $url');
//       }
//       return _getResponse(response, url);
//     } on SocketException {
//       print('Response ::SocketException:: No internet connection');
//       return 'No internet connection';
//     } on TimeoutException {
//       print('Response ::TimeoutException:: Time out');
//       getx.Get.snackbar(
//         AppMetaLabels().error,
//         AppMetaLabels().connectionTimedOut,
//         backgroundColor: AppColors.white54,
//       );
//       return '${AppMetaLabels().connectionTimedOut}';
//     } catch (e) {
//       print('Response ::Catch e.toString():: ${e.toString()}');
//       print('Response ::Catch:: $e');
//       if (foundation.kDebugMode) print(e);
//       return AppMetaLabels().anyError;
//     }
//   }

// /////////
//   static Future<dynamic> postwithheaderwithouttoken(
//     String url,
//     data,
//   ) async {
//     dumnyUrl = url;
//     print('Url :::: => $url');
//     // print('Data :::: => $data');
//     data = {"requestBody": encriptdata(data)};
//     print('Encripted Data Postwithheaderwithouttoken :::: => $data');

//     http.Response response;
//     try {
//       response = await http
//           .post(
//             Uri.parse(url),
//             body: json.encode(data),
//             headers: {
//               "Content-Type": "application/json",
//               'Authorization': 'Bearer ',
//               'ApiKey': 'UZ5QdWg2dLm1sop09082AccIa03DxupsIWDt9rqfeM',
//               "raw": "datawithoutfile"
//             },
//             encoding: Encoding.getByName('utf-8'),
//           )
//           .timeout(Duration(seconds: timeOutDuration));
//       if (foundation.kDebugMode) {
//         print('Request: ${response.request}');
//         // print('Headers: ${response.request.headers}');
//         print('End: $url');
//       }
//       return _getResponse(response, url);
//     } on SocketException {
//       print('Response ::SocketException:: No internet connection');
//       return 'No internet connection';
//     } on TimeoutException {
//       getx.Get.snackbar(
//         AppMetaLabels().error,
//         AppMetaLabels().connectionTimedOut,
//         backgroundColor: AppColors.white54,
//       );
//       return '${AppMetaLabels().connectionTimedOut}';
//     } catch (e) {
//       if (foundation.kDebugMode) print(e);
//       return AppMetaLabels().anyError;
//     }
//   }

// ///////
//   static Future<dynamic> uploadFile(
//       String url, Map<String, String> fields, String fileField, String filePath,
//       {String token}) async {
//     print('Url :::: => $url');
//     String bearerToken = token ?? SessionController().getToken();
//     // print(bearerToken);
//     try {
//       http.MultipartRequest request =
//           new http.MultipartRequest("POST", Uri.parse(url));
//       if (filePath != null) {
//         http.MultipartFile multipartFile =
//             await http.MultipartFile.fromPath(fileField, filePath);
//         request.files.add(multipartFile);
//       }
//       request.fields.addAll(fields);
//       request.headers.addAll({
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $bearerToken',
//       });
//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 404) {
//         final respStr = await response.stream.bytesToString();
//         if (response.statusCode == 404 && respStr.contains('HTML') == true ||
//             respStr.contains(
//                     '!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN') ==
//                 true) {
//           // print(respStr);
//           Get.to(() => ResponseInText(
//                 respose: respStr,
//               ));
//         }
//       }
//       // response.statusCode == 401 putting this condition because
//       // in multipart we are not calling _getResponse for handle the response
//       if (response.statusCode == 401) {
//         Get.offAll(() => SelectRoleScreen());
//         getx.Get.snackbar(
//           AppMetaLabels().error,
//           "${AppMetaLabels().unauthorized}",
//           backgroundColor: AppColors.white54,
//         );
//         return AppMetaLabels().unauthorized;
//       }
//       return response;
//     } catch (e) {
//       if (foundation.kDebugMode) print(e);
//       print('Catch ========> From BaseClient $e');
//       if (foundation.kReleaseMode) print(e);
//       if (foundation.kReleaseMode) print(e.toString());
//       return 0;
//     }
//   }

//   static Future<bool> isInternetConnected() async {
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         return true;
//       }
//     } on SocketException catch (_) {
//       return false;
//     }
//     return false;
//   }

//   static dynamic _getResponse(http.Response response, String url) async {
//     // print('Response :::: inside getResponse::::: $response');
//     print('Response Body :::: inside getResponse::$url::: ${response.body}');

//     if (response.statusCode == 404) {
//       if (response.statusCode == 404 &&
//               response.body.contains('HTML') == true ||
//           response.body.contains(
//                   '!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN') ==
//               true) {
//         print(response.body);
//         await Get.to(() => ResponseInText(
//               respose: response.body.trim(),
//             ));
//       }
//     }
//     switch (response.statusCode) {
//       case 200:
//         return response;
//       case 400:
//         if (url == AppConfig().validateUser) {
//           getx.Get.snackbar(
//             AppMetaLabels().error,
//             AppMetaLabels().invalidPhoneNumber,
//             backgroundColor: AppColors.white54,
//           );
//         }

//         return AppMetaLabels().badRequest;
//       case 401:
//         Get.offAll(() => SelectRoleScreen());
//         getx.Get.snackbar(
//           AppMetaLabels().error,
//           "${AppMetaLabels().unauthorized}",
//           backgroundColor: AppColors.white54,
//         );
//         return AppMetaLabels().unauthorized;
//       case 403:
//         Get.offAll(() => SelectRoleScreen());
//         getx.Get.snackbar(
//           AppMetaLabels().error,
//           "${AppMetaLabels().unauthorized}",
//           backgroundColor: AppColors.white54,
//         );
//         return AppMetaLabels().unauthorized;
//       case 404:
//         return AppMetaLabels().noDatafound;
//       case 500:
//         if (foundation.kDebugMode) print(response.body);
//         getx.Get.snackbar(
//           AppMetaLabels().error,
//           AppMetaLabels().anyError,
//           backgroundColor: AppColors.white54,
//         );
//         return AppMetaLabels().anyError;

//       case 501:
//         if (foundation.kDebugMode) print(response.body);
//         getx.Get.snackbar(
//           AppMetaLabels().error,
//           AppMetaLabels().processingError,
//           backgroundColor: AppColors.white54,
//         );
//         return AppMetaLabels().noDatafound;

//       default:
//         getx.Get.snackbar(
//           AppMetaLabels().error,
//           "${AppMetaLabels().couldNotConnectToServer}",
//           backgroundColor: AppColors.white54,
//         );
//         return '${AppMetaLabels().couldNotConnectToServer}';
//     }
//   }
// }
