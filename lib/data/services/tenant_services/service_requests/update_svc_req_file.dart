import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/data/services/tenant_services/response_of_multipart.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class UpdateSvcReqFile {
  static Future<dynamic> updateFile(
      int attachmentId, String filePath, String exp) async {
    var url = AppConfig().updateServiceRequestFiles;

    var data = {
      'AttachmentId': encriptdatasingle(attachmentId.toString()).toString(),
      'ExpireDate': encriptdatasingle(exp).toString(),
    };
    var response;
    response =
        await BaseClientClass.uploadFile(url ?? "", data, 'File', filePath);
    print('Response ::::updateFile:::::: ${response.statusCode}');
    // final respStr = await response.stream.bytesToString();
    // print('Response ::::updateFile::respStr:::: $respStr');
    if (response is StreamedResponse) {
      if (response.statusCode == 200) {
        return 200;
      } else {
        final respStr = await response.stream.bytesToString();
        if (response.statusCode == 413) {
          Get.to(() => ResponseInText(
                respose: respStr,
              ));
        }
        return response.statusCode;
      }
    } else
      return response;
  }
}
