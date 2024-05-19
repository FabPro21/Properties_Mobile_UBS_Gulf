// import 'package:fap_properties/data/helpers/base_client.dart';
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/data/models/tenant_models/tenant_get_units_model.dart';
// import 'package:fap_properties/utils/constants/api_url.dart';
// import 'package:http/http.dart' as http;

// class GetUnitsServices {
//   static Future<dynamic> getData() async {
//     var url = AppConfig.getUnits;
//     var userId = SessionController().getUserId().toString();

//     var response = await BaseClientClass.getAuthorization(url, userId);
//     if (response is http.Response) {
//       GetUnitsModel getUnitsModel = getUnitsModelFromJson(response.body);
//       return getUnitsModel;
//     }
//     return response;
//   }
// }
