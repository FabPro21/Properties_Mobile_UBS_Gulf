import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:http/http.dart';

class AddTicketService {
  // 112233 add ticket
  static Future<dynamic> addTicket(
      String reqNo, String message, String filePath) async {
    var url = AppConfig().addTicketReply;

    var data = {
      "CaseId": encriptdatasingle(reqNo).toString(),
      "Reply": encriptdatasingle(message).toString(),
    };

    var response;
    print('File Path:');
    print(filePath);
    response = await BaseClientClass.uploadFile(url ?? "", data, "File", filePath);
    print(response);

    if (response is StreamedResponse) {
      if (response.statusCode == 200) {
        return 'Ok';
      } else if (response.statusCode == 400) {
        SnakBarWidget.getSnackBarError(
            AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
        return;
      } else
        return response.statusCode;
    } else
      return response;
  }
}
