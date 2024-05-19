// import 'dart:convert';

// import 'package:fap_properties/data/helpers/base_client.dart';
// import 'package:fap_properties/data/models/tenant_models/contract_payable/payment_methods_model.dart';
// import 'package:fap_properties/utils/constants/app_config.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:http/http.dart' as http;

// import '../../helpers/session_controller.dart';

// class GetPaymentMethod {
//   static Future<dynamic> getData() async {
//     var response = await BaseClientClass.post(
//         AppConfig().getOutstandingPayments +
//             SessionController().getContractID().toString(),
//         {});
//     if (response is http.Response) {
//       try {
//         final _jsonResp = json.decode(response.body);
//         if (_jsonResp['statusCode'] == '200') {
//           return paymentMethodsFromJson(response.body);
//         } else if (_jsonResp['statusCode'] == '404') {
//           return AppMetaLabels().noMethodsFound;
//         } else
//           return _jsonResp['message'];
//       } catch (e) {
//         return AppMetaLabels().someThingWentWrong;
//       }
//     }
//     return response;
//   }
// }
