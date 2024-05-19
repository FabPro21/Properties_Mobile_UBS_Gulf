import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/public_models/public_booking_request/public_save_booking_request_model.dart';
import '../../../helpers/session_controller.dart';

class PublicSaveBookingRequestService {
  static Future<dynamic> saveFeedbackData(
      dynamic propertyID,
      dynamic description,
      dynamic contractUnitId,
      dynamic otherContactPersonName,
      dynamic otherContactPersonMobile,
      dynamic agentId) async {
    var url = AppConfig().savePublicBookingRequest;

    var data = {
      "propertyId": propertyID,
      "description": description,
      "contractUnitId": contractUnitId,
      "otherContactPersonName": otherContactPersonName,
      "OtherContactPersonMobile": otherContactPersonMobile,
      if (agentId.isNotEmpty) "agentId": agentId,
    };

    var response = await BaseClientClass.post(url, data,
        token: SessionController().getPublicToken());
    if (response is http.Response) {
      PublicSaveBookingRequestModel getModel =
          publicSaveBookingRequestModelFromJson(response.body);
      return getModel;
    }
    return response;
  }
}
