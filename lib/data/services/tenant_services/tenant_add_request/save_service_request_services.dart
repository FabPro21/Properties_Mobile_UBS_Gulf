// import 'package:fap_properties/data/helpers/base_client.dart';
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/drop2files/app_config_drop2.dart';
// import 'package:fap_properties/drop2files/drop2_models/drop2_tenent_models/tenant_add_request/get_tenant_properties_model.dart';
// import 'package:http/http.dart' as http;

// class SaveServiceRequestServices {
//   static Future<dynamic> getData() async {
//     var url = AppConfig2.saveServiceRequest +
//         SessionController().getTenantId().toString();

//     var data;

//     var response = await BaseClientClass.post(url, data);

//     if (response is http.Response) {
//       // GetTenantPropertiesModel getModel =
//       //     getTenantPropertiesModelFromJson(response.body);
//       return getModel;
//     }
//     return response;
//   }
// }
