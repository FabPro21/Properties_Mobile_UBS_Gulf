import 'dart:convert';
import 'dart:math';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TenantGetReqDocs {
  static Future<dynamic> getDocs(String caseNo, int roleId) async {
    final String url = AppConfig().getReqDocsPDF;
     var data = {"CaseNo":caseNo.toString(),"RoleId":roleId.toString(),};
     print('Data for case No ::::::: $data');
    var response = await BaseClientClass.post(url, data);
    if (response is http.Response) {
      try {
        var resp = json.decode(response.body);
        if (resp['path'] != null || resp['path'].isNotEmpty()) {
          var byteDocs = resp["path"] as List;
          var docIds = resp["photoId"] as List;
          var docTypes = resp["attachmentType"] as List;
          List<DocFile> reqPhotos = [];
          for (int i = 0; i < byteDocs.length; i++) {
            reqPhotos.add(DocFile(
                file: base64Decode(byteDocs[i].replaceAll('\n', '')),
                id: docIds[i],
                name: 'doc${docIds[i]}',
                type: docTypes[i],
                size: getFileSize(
                    base64Decode(byteDocs[i].replaceAll('\n', '')))));
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

  static String getFileSize(Uint8List file) {
    int bytes = file.lengthInBytes;
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }
}
