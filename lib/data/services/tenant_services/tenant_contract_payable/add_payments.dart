import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

// 1122 1
class AddPaymentsService {
  static Future<dynamic> addPayment(final data, String filePath) async {
    var url = AppConfig().addContractPayment;
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
