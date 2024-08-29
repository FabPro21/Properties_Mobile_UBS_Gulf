import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class VendorUploadSvcReqFile {
  static Future<dynamic> uploadFile(int caseNo, String filePath,
      String fileType, String exp, int docTypeId) async {
    var url = AppConfig().vendorUploadServiceRequestFiles;
    print(url);

    if (exp == '') {
      var now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String foramteDate = formatter.format(now);
      exp = foramteDate;
    }

    var data = {
      'CaseNo': encriptdatasingle(caseNo.toString()).toString(),
      'AttachmentType': encriptdatasingle(fileType).toString(),
      'ExpireDate': encriptdatasingle(exp).toString(),
      'DocumentTypeId': encriptdatasingle(docTypeId.toString()).toString(),
    };
    var q = {
      'CaseNo': (caseNo.toString()).toString(),
      'AttachmentType': (fileType).toString(),
      'ExpireDate': (exp).toString(),
      'DocumentTypeId': (docTypeId.toString()).toString(),
    };

    print(q);
    print(exp);

    var response;
 print('************************* $filePath');
    response = await BaseClientClass.uploadFile(url ?? "", data, 'File', filePath);
    if (response is StreamedResponse) {
      print('*************************');
      print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else
        return response.statusCode;
    } else
      return response;
  }

  static Future<dynamic> uploadFileInvoiceSR(int caseNo, String filePath,
      String fileType, String exp, int docTypeId, String reqID) async {
    var url = AppConfig().vendorUploadInvoiceServiceRequestFiles;
    print(url);

    if (exp == '') {
      var now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String foramteDate = formatter.format(now);
      exp = foramteDate;
    }

    var data = {
      'ExpireDate': encriptdatasingle(exp).toString(),
      'AttachmentType': encriptdatasingle(fileType).toString(),
      'RequestId': encriptdatasingle(reqID).toString(),
      'CaseNo': encriptdatasingle(caseNo.toString()).toString(),
      'DocumentTypeId': encriptdatasingle(docTypeId.toString()).toString(),
    };
    var q = {
      'ExpireDate': (exp).toString(),
      'AttachmentType': (fileType).toString(),
      'RequestId': (reqID).toString(),
      'CaseNo': (caseNo.toString()).toString(),
      'DocumentTypeId': (docTypeId.toString()).toString(),
    };

    print('Data ::::::::: $q');

    var response;

    response = await BaseClientClass.uploadFile(url ?? "", data, 'File', filePath);
    if (response is StreamedResponse) {
      // var res = await response.stream.bytesToString();
      // print('************************* $res');
      // print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else
        return response.statusCode;
    } else
      return response;
  }
}
