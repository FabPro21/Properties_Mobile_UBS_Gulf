import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/public_models/public_cancel_bookingreq/public_cancel_bookingreq_model.dart';
import '../../../helpers/session_controller.dart';

class PublicCancelBookingRequestService {
  static Future<dynamic> cancelBookingRequest(int caseNo) async {
    var url = AppConfig().cancelPublicBookingreq;
    var data = {"CaseNo":caseNo.toString()};
    var resp = await BaseClientClass.post(url ?? "", data,
        token: SessionController().getPublicToken());
    if (resp is http.Response) {
      PublicCancelBookingRequestModel getModel =
          publicCancelBookingRequestModelFromJson(resp.body);
      return getModel;
    }
    return resp;
  }
}
