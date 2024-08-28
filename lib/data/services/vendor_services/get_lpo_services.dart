import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/get_lpo_services_model.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;

class GetLpoServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getlposervies;
    var lpoId = SessionController().getLpoId();
    Map data = {"LpoId": lpoId};

    var response = await BaseClientClass.post(url ?? "", data);
    if (response is http.Response) {
      try {
        GetLpoServicesModel lpoServicesModel =
            getLpoServicesModelFromJson(response.body);
        return lpoServicesModel;
      } catch (e) {
        return AppMetaLabels().someThingWentWrong;
      }
    }
    return response;
  }
}
