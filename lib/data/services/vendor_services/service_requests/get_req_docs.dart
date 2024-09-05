import 'dart:convert';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class VendorGetReqDocs {
  static Future<dynamic> getDocs(String caseNo, int roleId) async {
    final String url = AppConfig().vendorGetServiceRequestDocs??"";
    Map data = {
      "CaseNo": caseNo.toString(),
      "RoleId": roleId.toString(),
    };
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        var resp = json.decode(response.body);

        if (resp['path'] != null || resp['path'].isNotEmpty()) {
          var byteDocs = resp["path"] as List;
          var docIds = resp["photoId"] as List;
          List<DocFile> reqPhotos = [];
          for (int i = 0; i < byteDocs.length; i++) {
            reqPhotos.add(DocFile(
                file: base64Decode(byteDocs[i].replaceAll('\n', '')),
                id: docIds[i],
                name: 'doc${docIds[i]}'));
            print('reqPhotos at $i ::::::: ${reqPhotos[i]}');
            print('reqPhotos at $i name::::::: ${reqPhotos[i].name}');
            print('reqPhotos at $i nameAr::::::: ${reqPhotos[i].nameAr}');
            print(
                'reqPhotos at $i attachmentDate::::::: ${reqPhotos[i].attachmentDate}');
            print(
                'reqPhotos at $i documentTypeId::::::: ${reqPhotos[i].documentTypeId}');
            print('reqPhotos at $i expiry::::::: ${reqPhotos[i].expiry}');
            print('reqPhotos at $i file::::::: ${reqPhotos[i].file}');
            print('reqPhotos at $i id::::::: ${reqPhotos[i].id}');
            print('reqPhotos at $i id::::::: ${reqPhotos[i].type}');
          }
          return reqPhotos;
        } else
          return AppMetaLabels().noDatafound;
      } catch (e) {
        if (kDebugMode) print(e);
        return AppMetaLabels().anyError;
      }
    }
    return response;
  }
}
