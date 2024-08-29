import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';


import '../../helpers/session_controller.dart';

class GetMetaDataServices {
  static Future<dynamic> getData() async {
    final String url = AppConfig().getMetaData??"";
    Map data = {
      'version': "1.5",
      //'SecretKey': dotenv.env['secretKey'],
    };
    await BaseClientClass.postwithheader(url, data,
        token: SessionController().getLoginToken());
  }
}
