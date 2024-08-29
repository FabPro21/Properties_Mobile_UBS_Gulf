import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

import '../../../helpers/encription.dart';

class VendorUpdateSvcReqFile {
  static Future<dynamic> updateFile(
      int attachmentId, String filePath, String exp) async {
    var url = AppConfig().vendorUpdateServiceRequestFiles;
    var data = {
      'AttachmentId': encriptdatasingle(attachmentId.toString()).toString() ,
      'ExpireDate':encriptdatasingle(exp).toString() ,
    };
    var response;
    response = await BaseClientClass.uploadFile(url ?? "", data, 'File', filePath);
    if (response is StreamedResponse) {
      if (response.statusCode == 200) {
        return 200;
      } else
        return response.statusCode;
    } else
      return response;
  }
}

  //   if (res is http.StreamedResponse) {
  //     if (res.statusCode == 200) {
  //       var resp = await res.stream.bytesToString();
  //       if (kDebugMode) print(resp);
  //       return resp;
  //     } else
  //       return res.statusCode;
  //   }
  // }
