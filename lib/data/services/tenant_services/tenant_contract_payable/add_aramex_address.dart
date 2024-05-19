import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/constants/meta_labels.dart';

class AddAramexAddress {
  static Future<dynamic> addAddress(
      int contractId, String address, int deliveryOption) async {
    var url = AppConfig().updateContractPaymentAddress;
    var data = {
      'ContractId': contractId.toString(),
      'Address': address,
      'SelfDelivery': deliveryOption.toString()
    };
    var resp = await BaseClientClass.post(url, data);

    if (resp is http.Response) {
      try {
        final status = json.decode(resp.body)['status'];
        if (status == 'ok')
          return status;
        else
          return AppMetaLabels().someThingWentWrong;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return resp;
  }
}
class AddAramexAddressNew {
  static Future<dynamic> addAddressNew(
      int contractId, String address, int deliveryOption) async {
    var url = AppConfig().updateContractPaymentAddressNew;
    var data = {
      'ContractId': contractId.toString(),
      'Address': address,
      'SelfDelivery': deliveryOption.toString()
    };
    var resp = await BaseClientClass.post(url, data);

    if (resp is http.Response) {
      try {
        final status = json.decode(resp.body)['status'];
        if (status == 'ok')
          return status;
        else
          return AppMetaLabels().someThingWentWrong;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return resp;
  }
}
