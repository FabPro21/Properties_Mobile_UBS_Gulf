import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contract_details_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class VendorGetContractDetailsServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getVendorContractDetails;
    var contractID = SessionController().getContractID().toString();
    Map data = {"ContractId": contractID};

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      VendorGetContractDetailsModel getContractDetailsModel =
          vendorGetContractDetailsModelFromJson(response.body);
      return getContractDetailsModel;
    }
    return response;
  }
}
