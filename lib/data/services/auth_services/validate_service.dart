// import 'package:fap_properties/data/helpers/base_client.dart';
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/data/models/common_models/validate_model.dart';
// import 'package:fap_properties/utils/constants/app_config.dart';
// import 'package:fap_properties/utils/constants/keys.dart';
// import 'package:http/http.dart' as http;

// class ValidateService {
//   static Future<dynamic> validateUser() async {
//     String phone = SessionController().getPhone();
//     var data = {
//       'mobile': phone,
//       'SecretKey': AppKeys.secretKey,
//     };
//     final String url = AppConfig().validate;
//     var response = await BaseClientClass.post(url, data);

//     if (response is http.Response) {
//       ValidateandAddPublicUserModel validateModel =
//           validateandAddPublicUserModelFromJson(response.body);

//       return validateModel;
//     }
//     return response;
//   }
// }
