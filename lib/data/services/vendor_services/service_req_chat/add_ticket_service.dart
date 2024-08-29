import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

class VendorAddTicketService {
  static Future<dynamic> addTicket(
      String reqNo, String message, String filePath) async {
    var url = AppConfig().vendorAddTicket;
    var data = {
      "CaseId": encriptdatasingle(reqNo).toString() ,
      "Reply":encriptdatasingle(message).toString()  ,
    };
    encriptdata(data);
    var response;
    response = await BaseClientClass.uploadFile(url ?? "", data, "File", filePath);

    if (response is StreamedResponse) {
      if (response.statusCode == 200) {
        return 'Ok';
      } else
        return response.statusCode;
    } else
      return response;
  }
}
