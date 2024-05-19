// import 'package:fap_properties/data/helpers/base_client.dart';
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/data/models/common_models/validate_model.dart';
// import 'package:fap_properties/utils/constants/app_config.dart';
// import 'package:fap_properties/utils/constants/keys.dart';
// import 'package:http/http.dart' as http;

// class AddPublicUserServices {
//   static Future<dynamic> addPublicUser() async {
//     String phoneNumber;

//     phoneNumber = SessionController().getPhone();
//     var data = {
//       'mobile': phoneNumber,
//       'SecretKey': AppKeys.secretKey,
//     };
//     var url = AppConfig().addPublicUser;
//     var response = await BaseClientClass.post(url, data);
//     if (response is http.Response) {
//       ValidateandAddPublicUserModel validateandAddPublicUserModel =
//           validateandAddPublicUserModelFromJson(response.body);
//       return validateandAddPublicUserModel;
//     }
//     return response;
//   }
// }
