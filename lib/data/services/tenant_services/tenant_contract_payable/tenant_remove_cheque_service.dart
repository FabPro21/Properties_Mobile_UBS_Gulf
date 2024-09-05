import 'package:http/http.dart' as http;
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';

class TenantRemoveChequeService {
  static Future<dynamic> removeCheque(int paymentSettingId) async {
    var url = AppConfig().removeCheque;
    var data = {"PaymentSettingId": paymentSettingId.toString()};

    var resp = await BaseClientClass.post(url ?? "", data);

    if (resp is http.Response) {
      return resp.statusCode;
    }
    return resp;
  }
}
class TenantRemoveChequeServiceNew {
  static Future<dynamic> removeChequeNew(int paymentSettingId) async {
    var url = AppConfig().removeChequeNew;
    var data = {"PaymentSettingId": paymentSettingId.toString()};

    var resp = await BaseClientClass.post(url ?? "", data);

    if (resp is http.Response) {
      return resp.statusCode;
    }
    return resp;
  }
}
