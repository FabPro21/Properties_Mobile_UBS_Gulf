import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/lpo_invoices_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

class LpoInvoicesServices {
  static Future<dynamic> getData() async {
    var lpoId = SessionController().getLpoId().toString();
    var url = AppConfig().lpoInvoices;
    Map data = {"LpoId": lpoId};

    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      LpoInvoicesModel lpoModel = lpoInvoicesModelFromJson(response.body);
      return lpoModel;
    }
    return response;
  }
}
